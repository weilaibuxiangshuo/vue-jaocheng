import request from "@/utils/request"

//获取菜单所有信息请求
export function getMenuListApi(paginationList){
    const page=paginationList.page
    const size=paginationList.size
    return request({
        url:`/users/menus/all/${page}/${size}/`,
        method:"get",
        params:paginationList.showdata
    })
}

//添加菜单请求
export function addMenuListApi(data){
    return request({
        url:"/users/menus/add/",
        method:"post",
        data:data
    })
}

//删除菜单请求
export function delMenuListApi(id){
    return request({
        url:"/users/menus/delete/",
        method:"delete",
        data:id
    })
}