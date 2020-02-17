import router from './router'
import store from './store'
import { Message } from 'element-ui'
import NProgress from 'nprogress' // progress bar
import 'nprogress/nprogress.css' // progress bar style
import { getToken, getAllRoutes } from '@/utils/auth' // get token from cookie
import getPageTitle from '@/utils/get-page-title'
NProgress.configure({ showSpinner: false }) // NProgress Configuration

const whiteList = ['/login'] // no redirect whitelist

router.beforeEach(async (to, from, next) => {
  // start progress bar
  NProgress.start()

  // set page title
  document.title = getPageTitle(to.meta.title)

  const hasToken = getToken()
  if (hasToken) {
    if (to.path === '/login') {
      next({ path: '/' })
      NProgress.done()
    } else {
      const newJsonRoutes = JSON.parse(sessionStorage.getItem("NEW_ROUTER_DATA_TOW"))
      if (newJsonRoutes) {
        const newRoutes = store.getters.newRoutes
        if (newRoutes.length > 0) {
          next()
        } else {
          //获取后台菜单数据，重新生成一遍数据
          //如果使用生成的数据，使用JSON.string传递会丢失部分数据，导致报错
          let tempNewRoutes = await store.dispatch("permissions/getStoreageRouter")
          router.addRoutes(tempNewRoutes)
          next({ path: to.path })
        }
      } else {
        try{
          const accessRoutes = await store.dispatch("permissions/getRouterData")
          router.addRoutes(accessRoutes)
          next({ path: "/" ,replace:true})
        }catch{
          next(`/login?redirect=${to.path}`)
          NProgress.done()
        }
      }
    }
  } else {
    /* has no token*/

    if (whiteList.indexOf(to.path) !== -1) {
      // in the free login whitelist, go directly
      next()
    } else {
      // other pages that do not have permission to access are redirected to the login page.
      next(`/login?redirect=${to.path}`)
      NProgress.done()
    }
  }
})

router.afterEach(() => {
  // finish progress bar
  NProgress.done()
})
