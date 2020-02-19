import request from '@/utils/request'

export function login(data) {
  return request({
    url: '/login/',
    method: 'post',
    data:data
  })
}


export function getLoginApi() {
  return request({
    url: '/getcaptcha/',
    method: 'get'
  })
}


// export function getInfo(token) {
//   return request({
//     url: '/vue-admin-template/user/info',
//     method: 'get',
//     params: { token }
//   })
// }

export function logout() {
  return request({
    url: '/logout/',
    method: 'post'
  })
}
