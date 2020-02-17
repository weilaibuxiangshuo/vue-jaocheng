import { getMenuListApi, addMenuListApi,delMenuListApi } from "@/api/users/menus"

const defaultMenus = () => {
    return {
        getAllMenuData: ""
    }
}

const state = defaultMenus()

const mutations = {
    SET_ALL_MENU_DATA:(state,menuData)=>{
        state.getAllMenuData=menuData
    }
}
const actions = {
    //获取菜单数据
    getMenuList({ commit },paginationList) {
        return new Promise((resolve, reject) => {
            getMenuListApi(paginationList).then(response => {
                commit("SET_ALL_MENU_DATA",response)
                resolve(response)
            })
        })
    },
    //添加菜单数据
    addMenuList({ commit }, newdata) {
        return new Promise((resolve,reject)=>{
            addMenuListApi(newdata).then(response => {
                resolve(response)
            })
        })
    },
    //删除菜单
    delMenuList({commit},id){
        return new Promise((resolve,reject)=>{
            delMenuListApi(id).then(response=>{
                resolve(response)
            })
        })
    }
}

export default {
    namespaced: true,
    state, mutations, actions
}