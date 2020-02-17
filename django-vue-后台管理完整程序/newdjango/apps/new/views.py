from django.shortcuts import HttpResponse
from django.views import View
from django.http import JsonResponse
import json, hashlib,collections
import jwt, datetime, urllib, re,base64
from django.conf import settings
from django.contrib.auth import logout,authenticate,login
from apps.new.models import NewUser, Roles, Options, Menus
from django.utils.deprecation import MiddlewareMixin
from apps.new.utils.jwtComponent import BackendToken
from django.core.cache import cache
from django.contrib.auth.hashers import make_password
from apps.new.utils.captcha import Captcha


class MiddleProcessReq(MiddlewareMixin):
    """中间件过滤所有请求"""
    def process_request(self, request):
        urlRouter = request.META.get('PATH_INFO')
        whiteListRoutes=["/login/","/login/ceshi/"]
        if not (urlRouter in whiteListRoutes):
            authorizationInfo=request.META.get("HTTP_AUTHORIZATION")
            if authorizationInfo:
                temp = BackendToken.GetToken(authorizationInfo)
                if temp is not None and temp==authorizationInfo:
                    optionList=Options.objects.all()
                    isBool = 0
                    for one in optionList:
                        str5=eval(repr(one.url))
                        str6=eval(repr(urlRouter))
                        result=re.match(str5, str6)
                        if result:
                            isBool = 1
                    if isBool != 1:
                        return JsonResponse({"code": 500})

                else:
                    return JsonResponse({"code": 500})
            else:
                return JsonResponse({"code": 500})



class Login(View):
    def get(self, request):
        tempCaptcha=Captcha.generate_captcha()
        request.session["captcha"]=tempCaptcha[0]
        cck=base64.b64encode(tempCaptcha[1]).decode("utf-8")
        # newUserOne=NewUser.objects.create_superuser(username='admin',password='adminadmin',email='11@qq.com')
        return JsonResponse({"code":2000,"captcha":cck})

    def post(self, request):
        username=request.POST.get("username")
        password=request.POST.get("password")
        captcha=str(request.POST.get("captcha")).lower()
        captchaStr=str(request.session['captcha']).lower()
        if captcha != captchaStr:
            return JsonResponse({"code": 500})
        if all([username,password]):
            user = authenticate(username=username,password=password)
            if user:
                login(request,user)
                temp = BackendToken.SetToken(request,user)
                cache.set(user.username,temp,timeout=None)
                return JsonResponse({"code": 2000,"token":temp,"user":user.username})
            else:
                return JsonResponse({"code": 500})

class Index(View):
    """遍历所选中菜单上级及本身"""
    def mapData(self,data,request):
        menuList = []
        tempList = collections.deque()
        tempList.append(data)
        while len(tempList)>0:
            res = tempList.popleft()
            for one in res:
                _list=[]
                if one.menuself:
                    _list.append(one.menuself)
                    tempList.append(_list)
                menuList.append(one.id)
        allMenuData=Menus.objects.all().filter(menuself=None)
        result=self.__class__().filterData(allMenuData,menuList,request)
        return result

    """根据菜单生成按钮权限"""
    def mapBtn(self,data,oneRoleOption):
        optionRelation=data.option_menu.all()
        btnList=["all","add","put","delete","edit"]
        if optionRelation:
            btnData=[]
            for one in optionRelation:
                str1=eval(repr(one.url))
                for listOne in btnList:
                    str2=eval(repr("/"+listOne+"/"))
                    result = re.search((str2),str1)
                    if result and (one in oneRoleOption):
                        btnData.append(listOne)
            return btnData



    """匹配菜单id生成新菜单"""
    def filterData(self,data,menulist,request):
        tempMenuList=[]
        for one in data:
            if one.id in menulist:
                _dict={
                    "id":one.id,
                    "title":one.title,
                    "order":one.order,
                    "path":one.url,
                    "icon":one.icon,

                }
                oneSub=one.menu_self.all()
                if oneSub.exists():
                    _dict["children"]=self.__class__().filterData(oneSub,menulist,request)
                else:
                    """获取当前用户对应角色下的所有权限"""
                    oneRoleOption=Options.objects.filter(role__user_role__username=request.user)
                    optionList=self.__class__().mapBtn(one,oneRoleOption)
                    # print(optionList,"77777777",one.title)
                    _dict["btnpermission"]=optionList
                tempMenuList.append(_dict)

        """调用排序菜单"""
        sortMenuList=self.__class__().sortLogic(tempMenuList)
        return sortMenuList

    """排序"""
    def sortedData(self,data):
        return int(data["order"])

    """排序逻辑"""
    def sortLogic(self,p):
        num1=sorted(p,key=self.__class__().sortedData)
        for one in num1:
            oneChildren=one.get("children")
            if oneChildren:
                one["children"] = self.__class__().sortLogic(oneChildren)
        return num1

    def get(self,request):
        oneNewUser=NewUser.objects.filter(username=request.user).first()
        oneR=Roles.objects.filter(title=oneNewUser.role.title).first()
        allOption=oneR.option_role.all()
        menuList=[]
        # request.session["specialUser"]=request.user
        for oneL in allOption:
            if not (oneL.menu in menuList):
                menuList.append(oneL.menu)
        menuAllList=self.__class__().mapData(menuList,request)
        return JsonResponse({"code":2000,"data":menuAllList})


class PersonDataApi(View):
    """获取用户信息"""
    def mapData(self,dataObj):
        allUserList=[]
        for oneuser in dataObj:
            try:
                _role = oneuser.role.title
                _roleId = oneuser.role.id
            except:
                _role = ""
                _roleId = ""
            _userDict={
                "id":oneuser.id,
                "title":oneuser.username,
                "roleId":_roleId,
                "role":_role
            }
            allUserList.append(_userDict)
        allRole=Roles.objects.all()
        allRoleList=[]
        for one in allRole:
            _dict={
                "id":one.id,
                "title":one.title
            }
            allRoleList.append(_dict)
        data={
            "code": 2000,
            "role": allRoleList,
            "users": allUserList,
            "total":NewUser.objects.count()
        }
        return data

    def get(self,request,page,size):
        queryStr = request.META.get("QUERY_STRING")
        isSearch = False
        if queryStr:
            queryStrFilter = queryStr.split("=")
            query1 = queryStrFilter[0].strip()
            query2 = queryStrFilter[1].strip()
            keyword = urllib.parse.unquote(query2, encoding="utf-8")
            isSearch = True if (query1 == "search" and query2 != "") else False
            if isSearch:
                oneData = NewUser.objects.filter(username=keyword)
                data = self.__class__().mapData(oneData)
                return JsonResponse(data)
        if all([page, size]):
            _page = int(page)
            _size = int(size)
            pageStart = (_page - 1) * _size
            pageEnd = _page * _size
            getData = NewUser.objects.all()[pageStart:pageEnd]
        else:
            getData = NewUser.objects.all()
        data=self.__class__().mapData(getData)
        return JsonResponse(data)

class PersonApi(View):
    """用户增删改查"""
    def post(self,request):
        reqData = request.POST.get("data")
        if len(reqData) > 0 and isinstance(reqData, str):
            reqDataLoad = json.loads(reqData)
            newuserName = NewUser.objects.filter(username=reqDataLoad["username"])
            roleId = int(reqDataLoad["roles"])
            oneRole = Roles.objects.filter(id=roleId).first()
            if newuserName.exists():
                if reqDataLoad["password"]=="" or reqDataLoad["password"]==None:
                    newuserName.update(role=oneRole)
                else:
                    tempPassword=make_password(reqDataLoad["password"])
                    newuserName.update(password=tempPassword,role=oneRole)
            else:
                NewUser.objects.create_user(username=reqDataLoad["username"],password=reqDataLoad["password"],role=oneRole)
        return JsonResponse({"code": 2000})

    def delete(self, reqeust):
        delDataList = reqeust.body.decode("utf-8")
        if delDataList and isinstance(json.loads(delDataList), list):
            for num in json.loads(delDataList):
                NewUser.objects.filter(id=num).delete()
            return JsonResponse({"code": 2000})


class MenusDataApi(View):
    """菜单管理数据获取"""
    def mapData(self, getdata):
        dataList = []
        for data in getdata:
            _dict = {
                "title": data.title,
                "path": data.url,
                "icon": data.icon,
                "order": data.order,
                "parent": data.menuself.title if data.menuself != None else "",
                "parentId": data.menuself.id if data.menuself != None else "",
                "id": data.id,
            }
            dataList.append(_dict)
        data = {
            "code": 2000,
            "data": dataList,
            "total": Menus.objects.all().count()
        }
        return data

    def get(self, request, page, size):
        # print(request.META)
        queryStr = request.META.get("QUERY_STRING")
        isSearch = False
        if queryStr:
            queryStrFilter = queryStr.split("=")
            query1 = queryStrFilter[0].strip()
            query2 = queryStrFilter[1].strip()
            keyword = urllib.parse.unquote(query2, encoding="utf-8")
            isSearch = True if (query1 == "search" and query2 != "") else False
            if isSearch:
                oneData = Menus.objects.filter(title=keyword)
                data = self.__class__().mapData(oneData)
                return JsonResponse(data)
        if all([page, size]):
            _page = int(page)
            _size = int(size)
            pageStart = (_page - 1) * _size
            pageEnd = _page * _size
            getData = Menus.objects.all()[pageStart:pageEnd]
        else:
            getData = Menus.objects.all()
        data = self.__class__().mapData(getData)
        # 判断是否获取上级菜单
        tempData = self.__class__().mapData(Menus.objects.all())
        data.update({"alldata": tempData})
        return JsonResponse(data)


class MenusApi(View):
    """
    菜单管理添加、删除、查寻
    """

    def post(self, request):
        # print(request.body)
        # print(request.POST.get("data"))
        data = request.POST.get("data")
        # print("菜单数据",data)
        if data and isinstance(data, str):
            dataLoad = json.loads(data)
            if dataLoad["parent"] == "0":
                oneMenu = Menus.objects.filter(title=dataLoad["name"])
                if oneMenu.exists():
                    oneMenu.update(url=dataLoad["path"], icon=dataLoad["icon"], order=dataLoad["order"], menuself=None)
                else:
                    Menus.objects.create(title=dataLoad["name"], url=dataLoad["path"], icon=dataLoad["icon"],
                                         order=dataLoad["order"], menuself=None)
            else:
                oneMenu = Menus.objects.filter(title=dataLoad["name"])
                if oneMenu.exists():
                    numId = dataLoad["parent"]
                    parentId = Menus.objects.filter(id=numId).first()
                    oneMenu.update(url=dataLoad["path"], icon=dataLoad["icon"], order=dataLoad["order"],
                                   menuself=parentId)
                else:
                    numId = dataLoad["parent"]
                    parentId = Menus.objects.filter(id=numId).first()
                    Menus.objects.create(title=dataLoad["name"], url=dataLoad["path"], icon=dataLoad["icon"],
                                         order=dataLoad["order"], menuself=parentId)
            return JsonResponse({"code": 2000})
        else:
            return JsonResponse({"code": 501})

    def delete(self, reqeust):
        delDataList = reqeust.body.decode("utf-8")
        if delDataList and isinstance(json.loads(delDataList), list):
            for num in json.loads(delDataList):
                Menus.objects.filter(id=num).delete()
            return JsonResponse({"code": 2000})


class ControlDataApi(View):
    """获取权限所有信息"""

    def mapMenuData(self, data):
        """获取菜单最后一级信息"""
        tempList = []
        for one in data:
            subData = one.menu_self.all()
            if subData:
                self.__class__().mapMenuData(subData)
            else:
                _dict = {
                    "title": one.title,
                    "id": one.id
                }
                tempList.append(_dict)
        return tempList

    def mapOptionData(self, data):
        dataList = []
        for one in data:
            try:
                oneMenuTitle = one.menu.title
            except:
                oneMenuTitle = ""
            _dict = {
                "id": one.id,
                "title": one.title,
                "path": one.url,
                "method": one.method,
                "menu": oneMenuTitle,
            }
            dataList.append(_dict)
        menuList = Menus.objects.all()
        lastMenuData = self.__class__().mapMenuData(menuList)
        data = {
            "code": 2000,
            "menudata": lastMenuData,
            "optiondata": dataList,
            "total": Options.objects.all().count()
        }
        return data

    def get(self, request, page, size):
        queryStr = request.META.get("QUERY_STRING")
        print(queryStr)
        isSearch = False
        if queryStr:
            queryStrFilter = queryStr.split("=")
            query1 = queryStrFilter[0].strip()
            query2 = queryStrFilter[1].strip()
            keyword = urllib.parse.unquote(query2, encoding="utf-8")
            isSearch = True if (query1 == "search" and query2 != "") else False
            if isSearch:
                oneData = Options.objects.filter(title=keyword)
                data = self.__class__().mapOptionData(oneData)
                return JsonResponse(data)
        if all([page, size]):
            _page = int(page)
            _size = int(size)
            pageStart = (_page - 1) * _size
            pageEnd = _page * _size
            getData = Options.objects.all()[pageStart:pageEnd]
        else:
            getData = Options.objects.all()
        data = self.__class__().mapOptionData(getData)
        return JsonResponse(data)


class ControlsApi(View):
    """权限增加、修改、删除"""

    def post(self, request):
        print(request.POST.get("data"))
        reqData = request.POST.get("data")
        if len(reqData) > 0 and isinstance(reqData, str):
            reqDataLoad = json.loads(reqData)
            optionName = Options.objects.filter(title=reqDataLoad["name"])
            menuId = int(reqDataLoad["menu"])
            oneMenu = Menus.objects.filter(id=menuId).first()
            if optionName.exists():
                optionName.update(url=reqDataLoad["path"], method=reqDataLoad["method"], menu=oneMenu)
            else:
                Options.objects.create(title=reqDataLoad["name"], url=reqDataLoad["path"], method=reqDataLoad["method"],
                                       menu=oneMenu)
        return JsonResponse({"code": 2000})

    def delete(self, reqeust):
        delDataList = reqeust.body.decode("utf-8")
        if delDataList and isinstance(json.loads(delDataList), list):
            for num in json.loads(delDataList):
                Options.objects.filter(id=num).delete()
            return JsonResponse({"code": 2000})


class RoleDataApi(View):
    """角色管理"""
    def mapData(self, data):
        dataList = []
        for one in data:
            roleOptionData = one.option_role.all()
            optionData = self.__class__().mergeOptionLevel(roleOptionData)
            _dict = {
                "id":one.id,
                "name":one.title,
                "option":optionData,
            }
            dataList.append(_dict)
        #获取所有菜单数据
        menuAllData = Menus.objects.filter(menuself=None)
        menuData=self.__class__().mergeLevel(menuAllData)
        #获取角色数据
        data={
            "code": 2000,
            "data": menuData,
            "role": dataList,
            "roletotal": Roles.objects.all().count()
        }
        return data

    """菜单与权限合并树层级"""
    def mergeLevel(self, data):
        #option_menu
        tempList=[]
        for one in data:
            subMenu = one.menu_self.all()
            tempDict={}
            _parentDict={
                "id": "".join(["menuid",str(one.id)]),
                "label": one.title
            }
            tempDict.update(_parentDict)
            if subMenu.exists():
                tempDict["children"] = self.__class__().mergeLevel(subMenu)
            else:
                subOptionData=one.option_menu.all()
                if subOptionData.exists():
                    subData=self.__class__().mergeOptionLevel(subOptionData)
                    tempDict["children"]=subData
            tempList.append(tempDict)
        return tempList

    def mergeOptionLevel(self,data):
        tempList=[]
        for one in data:
            _dict={
                "id": "".join(["optionid",str(one.id)]),
                "label":one.title
            }
            tempList.append(_dict)
        return tempList

    def get(self, request, page, size):
        #设定当前用户为superadmin
        # Roles.objects.create(title="superadmin")
        # Roles.objects.filter(id=13).delete()
        queryStr = request.META.get("QUERY_STRING")
        print(queryStr)
        isSearch = False
        roleAllData = Roles.objects.all()
        if queryStr:
            queryStrFilter = queryStr.split("=")
            query1 = queryStrFilter[0].strip()
            query2 = queryStrFilter[1].strip()
            keyword = urllib.parse.unquote(query2, encoding="utf-8")
            isSearch = True if (query1 == "search" and query2 != "") else False
            if isSearch:
                oneData = roleAllData.filter(title=keyword)
                searchData = self.__class__().mapData(oneData)
                return JsonResponse(searchData)
        if all([page, size]):
            _page = int(page)
            _size = int(size)
            pageStart = (_page - 1) * _size
            pageEnd = _page * _size
            getData =roleAllData[pageStart:pageEnd]
        else:
            getData = roleAllData
        #获取角色数据
        data = self.__class__().mapData(getData)
        return JsonResponse(data)


class RolesApi(View):
    """角色数据"""
    def filterOptionData(self,data):
        """角色与权限关系处理"""
        queryList=[]
        for one in data:
            result=re.match(r"optionid\d+",one)
            if result:
                re_optionId=re.compile(r"\d+$")
                numStr=re.search(re_optionId,result.group())
                num=eval(numStr.group())
                oneData=Options.objects.filter(id=num).first()
                if oneData:
                    queryList.append(oneData)
        return queryList

    def post(self,request):
        postData=request.POST.get("data")
        if postData and isinstance(postData,str):
            loadData=json.loads(postData)
            optionData=loadData["optiondata"]
            optionDataFilter=self.__class__().filterOptionData(optionData)
            filterRole=Roles.objects.filter(title=loadData["name"])
            if filterRole.exists():
                oneRole=filterRole.first()
                if optionDataFilter:
                    oneRole.option_role.clear()
                    oneRole.option_role.set(optionDataFilter)
            else:
                newRole=Roles.objects.create(title=loadData["name"])
                if optionDataFilter:
                    newRole.option_role.set(optionDataFilter)
        return JsonResponse({"code": 2000})


    def delete(self, reqeust):
        delDataList = reqeust.body.decode("utf-8")
        if delDataList and isinstance(json.loads(delDataList), list):
            for num in json.loads(delDataList):
                Roles.objects.filter(id=num).delete()
            return JsonResponse({"code": 2000})


class Logout(View):
    def post(self, request):
        cache.delete(request.user)
        request.session.flush()
        logout(request)
        return JsonResponse({'code': 200})
