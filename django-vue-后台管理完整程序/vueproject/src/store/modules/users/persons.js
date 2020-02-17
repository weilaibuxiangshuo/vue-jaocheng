import {getRoleDataApi,addRoleListApi,delRoleListApi} from "@/api/users/persons"


const defaultPersonData=()=>{
    return {
        
    }
}

const state=defaultPersonData()

const mutations={}

const actions={
    //获取用户信息
    getRoleData({commit},paginationList){
        return new Promise((resolve,reject)=>{
            getRoleDataApi(paginationList).then(response=>{
                resolve(response)
            })
        })
    },
    //添加用户
    addRoleList({commit},data){
        return new Promise((resolve,reject)=>{
            addRoleListApi(data).then(response=>{
                resolve(response)
            })
        })
    },
    //删除用户
    delRoleList({commit},id){
        return new Promise((resolve,reject)=>{
            delRoleListApi(id).then(response=>{
                resolve(response)
            })
        })
    }
}

export default {
    namespaced:true,
    state,mutations,actions
}