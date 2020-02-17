import {getContrlALLApi,addCtrolListApi,delCtrolListApi} from "@/api/users/controls"

const defaultControlfunc=()=>{
    return {
        getControlAllData:"",
    }
}

const state=defaultControlfunc()

const mutations={
    SET_CONTROL_DATA:(state,data)=>{
        state.getControlAllData=data
    }
}

const actions={
    getContrlALL({commit},paginationList){
        return new Promise((resolve,reject)=>{
            getContrlALLApi(paginationList).then(response=>{
                commit("SET_CONTROL_DATA",response)
                resolve(response)
            })
        })
    },
    addCtrolList({commit},newdata){
        return new Promise((resolve,reject)=>{
            addCtrolListApi(newdata).then(response=>{
                resolve(response)
            })
        })
    },
    delCtrolList({commit},deldata){
        return new Promise((resolve,reject)=>{
            delCtrolListApi(deldata).then(response=>{
                resolve(response)
            })
        })
    }
}

export default {
    namespaced:true,state,mutations,actions
}