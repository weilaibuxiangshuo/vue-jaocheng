from django.test import TestCase

# Create your tests here.
import re
data=["9","menuid39","menuid40","optionid923423","optionid9223"]
data1={"d":3,"a":1,"9":2}

def temp(yy):
    # print(type(yy))
    # print(yy)
    return int(yy["order"])

# mm = sorted(data1,key=temp)
# print(mm)

# cc = map(temp,data1)
# print(list(cc))

from collections import OrderedDict


kkkkk= [{'id': 39, 'title': '管理系统', 'order': '8', 'children': [{'id': 39, 'title': '菜单管理1', 'order': '5'},{'id': 32, 'title': '菜单管理2', 'order': '12'}]}, {'id': 37, 'title': 'Form', 'order': '3'}]

# for one in kkkkk:
#     print(one)
#     bbcc=sorted(one,key=temp)
#     print("bbcc",bbcc)

# allData=OrderedDict()
# bbcc=sorted(kkkkk,key=temp)
# print("bbcc",bbcc)

# for one in bbcc:
#     isFunc=one.get("children")
#     if isFunc:
#         bbb=sorted(isFunc, key=temp)
#         # print("88",bbb)
#         one["children"]=bbb
#     pass

# print(bbcc)

class uuu(object):
    def sortedData(self,data):
        return int(data["order"])

    def ccc(self,p):
        num1=sorted(p,key=self.__class__().sortedData)
        for one in num1:
            oneChildren=one.get("children")
            if oneChildren:
                one["children"] = self.__class__().ccc(oneChildren)
        return num1


iii=uuu()
ooo=iii.ccc(kkkkk)
print(ooo,"000")