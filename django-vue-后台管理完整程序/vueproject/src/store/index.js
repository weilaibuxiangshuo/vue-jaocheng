import Vue from 'vue'
import Vuex from 'vuex'
import getters from './getters'
import app from './modules/app'
import settings from './modules/settings'
import user from './modules/user'
import menus from './modules/users/menus'
import controls from './modules/users/controls'
import roles from './modules/users/roles'
import permissions from './modules/users/permissions'
import persons from './modules/users/persons'
Vue.use(Vuex)

const store = new Vuex.Store({
  modules: {
    app,
    settings,
    user,
    menus,
    controls,
    roles,
    permissions,
    persons,
  },
  getters
})

export default store
