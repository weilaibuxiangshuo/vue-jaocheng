import Cookies from 'js-cookie'

const TokenKey = 'vue_admin_template_token'
//设置路由cookies
const RouterKey = 'vueallnewrouter'


export function getAllRoutes(){
  console.log("内部get",Cookies.get(RouterKey))
  return Cookies.get(RouterKey)
}

export function setAllRoutes(data){
  console.log('set',data)
  // let dataType=JSON.stringify(data)
  return Cookies.set(RouterKey,data)
}

export function removeAllRoutes(){
  return Cookies.remove(RouterKey)
}

export function getToken() {
  return Cookies.get(TokenKey)
}

export function setToken(token) {
  return Cookies.set(TokenKey, token)
}

export function removeToken() {
  return Cookies.remove(TokenKey)
}
