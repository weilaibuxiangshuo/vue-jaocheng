import { login, logout, getLoginApi } from '@/api/user'
import { getToken, setToken, removeToken } from '@/utils/auth'
import { resetRouter } from '@/router'
import store from "@/store"
const getDefaultState = () => {
  return {
    token: getToken(),
    name: '',
  }
}

const state = getDefaultState()

const mutations = {
  RESET_STATE: (state) => {
    Object.assign(state, getDefaultState())
  },
  SET_TOKEN: (state, token) => {
    state.token = token
  },
  SET_NAME: (state, name) => {
    state.name = name
  },
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar
  }
}

const actions = {
  // user login
  login({ commit }, userInfo) {
    const { username, password,captcha } = userInfo
    return new Promise((resolve, reject) => {
      let newData=new FormData()
      let sha256=require("js-sha256").sha256
      let newPassword=sha256(password)
      newData.append("username",username.trim())
      newData.append("password",newPassword)
      newData.append("captcha",captcha.trim())
      login(newData).then(response => {
        commit('SET_TOKEN', response.token)
        setToken(response.token)
        commit('SET_NAME', response.user)
        commit('SET_AVATAR', "admin")
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  getLogin(){
    return new Promise((resolve,reject)=>{
      getLoginApi().then(response=>{
        // console.log(response)
        resolve(response)
      })
    })
  },

  // get user info
  // getInfo({ commit, state }) {
  //   return new Promise((resolve, reject) => {
  //     getInfo(state.token).then(response => {
  //       const { data } = response

  //       if (!data) {
  //         reject('Verification failed, please Login again.')
  //       }

  //       const { name, avatar } = data

  //       commit('SET_NAME', name)
  //       commit('SET_AVATAR', avatar)
  //       resolve(data)
  //     }).catch(error => {
  //       reject(error)
  //     })
  //   })
  // },

  // user logout
  logout({ commit, state }) {
    return new Promise((resolve, reject) => {
      logout(state.token).then(() => {
        removeToken() // must remove  token  first
        store.commit("permissions/SET_ROUTER_DATA",[])
        sessionStorage.removeItem("NEW_ROUTER_DATA_TOW")
        resetRouter()
        commit('RESET_STATE')
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  // remove token
  resetToken({ commit }) {
    return new Promise(resolve => {
      removeToken() // must remove  token  first
      commit('RESET_STATE')
      resolve()
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

