import {getRoleALLApi,addRoleListApi,delRoleListApi} from "@/api/users/roles"

const defaultRoleAllData=()=>{
    return {
        getRoleAllData:"",
        getRoleOptionData:"",
    }
}

const state=defaultRoleAllData
const mutations={
    SET_ROLE_OPTION_DATA:(state,data)=>{
        state.getRoleOptionData=data
    }
}
const actions={
    getRoleALL({commit},paginationList){
        return new Promise((resolve,reject)=>{
            getRoleALLApi(paginationList).then(response=>{
                commit("SET_ROLE_OPTION_DATA",response.optiondata) 
                resolve(response)
            })
        })
    },
    addRoleList({commit},roleFormData){
        return new Promise((resolve,reject)=>{
            addRoleListApi(roleFormData).then(response=>{
                resolve(response)
            })
        })
    },
    delRoleList({commit},id){
        return new Promise((resolve,reject)=>{
            delRoleListApi(id).then(response=>{
                resolve(response)
            })
        })
    }
}
export  default  {
    namespaced:true,
    state,mutations,actions
}