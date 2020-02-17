import request from "@/utils/request"

//获取角色数据
export function getRoleALLApi(paginationList){
    const page=paginationList.page
    const size=paginationList.size
    return request({
        url:`/users/roles/all/${page}/${size}/`,
        method:"get",
        params:paginationList.showdata
    })
}

//获取角色与权限
export function addRoleListApi(data){
    return request({
        url:"/users/roles/add/",
        method:"post",
        data:data
    })
}

//删除角色请求
export function delRoleListApi(id){
    return request({
        url:"/users/roles/delete/",
        method:"delete",
        data:id
    })
}