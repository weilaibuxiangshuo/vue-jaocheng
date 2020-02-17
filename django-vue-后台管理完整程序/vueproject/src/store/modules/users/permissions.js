import Layout from '@/layout'
import { constantRoutes } from '@/router'
import { getRouterDataApi } from '@/api/users/permissions'
import path from 'path'
import { deepCopyData } from "@/utils/users"
import {asyncConstantRoutes} from "@/router"

const stateFunc = () => {
  return {
    newRoutes: [],
    menuRoutes: [],
  }
}

const state = stateFunc()

const mutations = {
  SET_ROUTER_DATA: (state, data) => {
    state.newRoutes = data,
    state.menuRoutes = constantRoutes.concat(data)
  },
}


const mergeMenuData = (data, basePath = "/", num = 0) => {
  let numId = num + 1
  let numList = []
  for (let tt of data) {
    let ttPath = tt.path.substring(1)
    let routerpath = path.resolve(basePath, ttPath)
    let _dict1 = null
    if (numId == 1) {
      _dict1 = {
        path: routerpath,
        component: Layout,
      }
      if (tt.children && tt.children.length > 0) {
        if (tt.children.length === 0) { delete tt.children } else if (tt.children.length === 1) {
          if (tt.path.trim() === "/") {
            let onlyPath = path.resolve(routerpath, tt.children[0].path.substring(1))
            _dict1.redirect = onlyPath
            _dict1.children = [{
              path: tt.children[0].path.substring(1),
              component: resolve => require([`@/views${onlyPath}/index`], resolve),
              meta: {
                title: tt.title,
                icon: tt.icon
              }              
            }]
            if(tt.children[0].btnpermission){_dict1.children[0].meta.btnpermission=tt.children[0].btnpermission}
          } else {
            _dict1.meta = {
              title: tt.title,
              icon: tt.icon
            }
            if(tt.btnpermission){_dict1.meta.btnpermission=tt.btnpermission}
            _dict1.children = mergeMenuData(tt.children, routerpath, numId)
          }
        } else {
          _dict1.meta = {
            title: tt.title,
            icon: tt.icon
          }
          if(tt.btnpermission){_dict1.meta.btnpermission=tt.btnpermission}
          _dict1.children = mergeMenuData(tt.children, routerpath, numId)
        }
      } else {
        _dict1.children = [{
          path: "index",
          component: resolve => require([`@/views${routerpath}/index`], resolve),
          meta: {
            title: tt.title,
            icon: tt.icon
          }
        }]
        if(tt.btnpermission){_dict1.children[0].meta.btnpermission=tt.btnpermission}
      }
    } else {
      _dict1 = {
        path: ttPath,
        component: resolve => require([`@/views${routerpath}`], resolve),
        meta: {
          title: tt.title,
          icon: tt.icon
        }
      }
      if(tt.btnpermission){_dict1.meta.btnpermission=tt.btnpermission}
      if (tt.children && tt.children.length > 0) {
        if (tt.children.length === 0) {
          delete tt.children
        } else{
          _dict1.children = mergeMenuData(tt.children, routerpath, numId)
        }
      }
    }
    numList.push(_dict1)
  }
  return numList
}


const actions = {
  getStoreageRouter({commit}){
    return new Promise((resolve,reject)=>{
      //获取后台传入菜单原始结构，用于刷新用，重新生成，防止数据丢失报错
      let newData=JSON.parse(sessionStorage.getItem("NEW_ROUTER_DATA_TOW"))
      let newDeepData = deepCopyData(newData)
      let tempData = mergeMenuData(newDeepData).concat(asyncConstantRoutes)
      commit("SET_ROUTER_DATA", tempData)
      resolve(tempData)
    })
  },


  getRouterData({ commit }) {
    return new Promise((resolve, reject) => {
      getRouterDataApi().then((response) => {
        let roterList = deepCopyData(response.data)
        let tempData = mergeMenuData(roterList).concat(asyncConstantRoutes)
        commit("SET_ROUTER_DATA", tempData)
        sessionStorage.setItem("NEW_ROUTER_DATA_TOW",JSON.stringify(response.data))
        resolve(tempData)
      })
    })
  },
}

export default {
  namespaced: true,
  state, mutations, actions
}