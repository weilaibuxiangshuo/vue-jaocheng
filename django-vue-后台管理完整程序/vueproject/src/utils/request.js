import axios from 'axios'
import { MessageBox, Message } from 'element-ui'
import store from '@/store'
import { getToken } from '@/utils/auth'
import router from '@/router'
import { Loading } from 'element-ui';


const loading={
  loadingInstance:null,  //loading 实例
  //打开加载
  open:function(){
    if(this.loadingInstance === null){
      this.loadingInstance = Loading.service({
        target:".app-main",
        text:"拼命加载中...",
        spinner:"el-icon-loading",
        background:"rgba(0, 0, 0, 0.5)"
      });
    }
  },
  //关闭加载
  close:function(){
    if(this.loadingInstance !== null){
      this.loadingInstance.close();
    }
    this.loadingInstance = null
  }
}


// create an axios instance
const service = axios.create({
  // baseURL: process.env.VUE_APP_BASE_API, // url = base url + request url
  baseURL: "/api",
  // withCredentials: true, // send cookies when cross-domain requests
  timeout: 5000 // request timeout
})

// request interceptor
service.interceptors.request.use(
  
  config => {
    // do something before request is sent
    //打开加载窗口
    loading.open()

    if (store.getters.token) {
      // let each request carry token
      // ['X-Token'] is a custom headers key
      // please modify it according to the actual situation
      config.headers['authorization'] = getToken()
    }
    return config
  },
  error => {
    loading.close()
    // do something with request error
    console.log(error) // for debug
    return Promise.reject(error)
  }
)

// response interceptor
service.interceptors.response.use(
  /**
   * If you want to get http information such as headers or status
   * Please return  response => response
  */

  /**
   * Determine the request status by custom code
   * Here is just an example
   * You can also judge the status by HTTP Status Code
   */
  response => {
    const res = response.data
    loading.close()
    if(res.code===500){
      router.push({path:'/404'})
    }else{
      return res
    }

    // if the custom code is not 20000, it is judged as an error.
    
  },
  error => {
    console.log('err' + error) // for debug
    Message({
      message: error.message,
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(error)
  }
)

export default service
