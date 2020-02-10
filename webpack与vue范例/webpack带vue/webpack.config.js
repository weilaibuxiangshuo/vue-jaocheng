// 引入node的path模块，处理文件路径的小工具
const path = require('path')
//引入插件
const HtmlWebpackPlugin = require('html-webpack-plugin');
//1.引入vue-loader插件
const VueLoaderPlugin = require('vue-loader/lib/plugin')
//导出一个webpack具有特殊属性配置的对象
module.exports = {
    // mode:"production",//生产环境打包的时候也不会报错，区别是bundle内容压缩
    mode: "development",//开发环境打包的时候也不会报错，区别是bundle内容不压缩
    // mode:"none",//指定为none打包的时候也不会报错,区别是bundle内容不压缩
    //入口
    entry: "./src/main.js",
    //出口
    output: {
        // path:"./dist/",
        path: path.join(__dirname, "./dist/"),//打包生成后的路径必须是绝对路径
        filename: "bundle.js",
    },
    //配置插件
    plugins: [
        new HtmlWebpackPlugin({
            //指定要打包的模版页面
            //就会将index.html打包到bundle.js同一级目录下面
            template: './index.html'
        }),
        // 3.请确保引入这个插件！
        new VueLoaderPlugin()
    ],
    module: {
        rules: [   //匹配转换规则
            {
                test: /\.css$/,  //注意，不要用引号，这个是正则表达式，匹配css文件
                use: [
                    'style-loader',
                    'css-loader'
                ]
            },
            {
                test: /\.(png|svg|jpg|gif)$/,
                use: [
                    'file-loader'
                ]
            },
            //解决兼容性问题
            {
                test: /\.js$/,
                exclude: /(node_modules|bower_components)/,  //排除目录
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['@babel/preset-env']   //转换规则
                    }
                }
            },
            //2.处理.vue单文件组件
            {
                test: /\.vue$/,
                loader: 'vue-loader'
            }
        ]
    },
    //解析完整版的VUE.js,使用main中使用render，就不需要开始此功能
    // resolve:{
    //     alias:{
    //         'vue$':'vue/dist/vue.js'
    //     }
    // }
}

