//通过这种方式引入的vue模块不是完整版，没有编译功能和运行功能，它默认引入的是vue模块中的package.json中
// main选项中引入的  "main": "dist/vue.runtime.common.js",浏览器打会报错，引发警告不会显示
// import Vue from 'vue'

//第一种方式 引入完整版的正确方式是如下：
// import Vue from 'vue/dist/vue.js'
//第二种方式 使用此方式，要导入完整版需要到webpack.config.js中配置resolve
// import Vue from 'vue'

//第三种方式 最优的引入完整版方式，并使用render
import Vue from 'vue'

import App from './App.vue'

// new Vue({
//     el:"#app",
//     //template实际是没有编译与渲染功能，而当前的编译功能都是通过 vue-loader实现
//     //而渲染功能实际是通过 render函数，来进行渲染组件，所以直接使用render实现就可以
//     // template:'<App />',

//     //使用render，components可以省略
//     // render:function(h){    //h它是一个函数，这个函数用于要接收渲染的组件
//     //     return h(App)
//     // },
//     //最终简化版本
//     render:h=>h(App)
//     // components:{App:App}
// })

// 另外一种写法
new Vue({
    render:h=>h(App)
}).$mount('#app')
