import request from "@/utils/request"

//获取权限信息
export function getContrlALLApi(paginationList) {
    const page=paginationList.page
    const size=paginationList.size
     return request({
        url:`/users/controls/all/${page}/${size}/`,
        method:"get",
        params:paginationList.showdata
    })
}

//添加权限
export function addCtrolListApi(data){
    return request({
        url:"/users/controls/add/",
        method:"post",
        data:data
    })
}


//添加权限
export function delCtrolListApi(data){
    return request({
        url:"/users/controls/delete/",
        method:"delete",
        data:data
    })
}