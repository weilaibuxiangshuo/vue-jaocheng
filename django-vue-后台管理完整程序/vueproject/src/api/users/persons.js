import request from '@/utils/request'

//获取用户数据
export function getRoleDataApi(paginationList) {
    const page=paginationList.page
    const size=paginationList.size
    return request({
        url:`/users/persons/all/${page}/${size}/`,
        method:"get",
        params:paginationList.showdata
    })
}


//添加用户数据
export function addRoleListApi(data){
    return request({
        url:"/users/persons/add/",
        method:"post",
        data:data
    })
}


//删除用户数据
export function delRoleListApi(id){
    return request({
        url:"/users/persons/delete/",
        method:"delete",
        data:id
    })
}