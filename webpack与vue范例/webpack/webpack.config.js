// 引入node的path模块，处理文件路径的小工具
const path = require('path')
//html打包需引入插件，教程地址如下
// https://www.webpackjs.com/guides/output-management/#%E8%AE%BE%E5%AE%9A-htmlwebpackplugin
const HtmlWebpackPlugin = require('html-webpack-plugin');
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
        })
    ],
    module: {
        //css安装教程网址https://www.webpackjs.com/guides/asset-management/#%E5%8A%A0%E8%BD%BD-css
        //图片安装教程https://www.webpackjs.com/guides/asset-management/#%E5%8A%A0%E8%BD%BD%E5%9B%BE%E7%89%87
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
            //解决兼容性问题(浏览器8以下可以使用)，需要安装babel-loader
            //npm install babel-loader@8.0.0-beta.0 @babel/core @babel/preset-env
            // 教程地址：https://www.webpackjs.com/loaders/babel-loader/
            {
                test: /\.js$/,
                exclude: /(node_modules|bower_components)/,  //排除目录
                use: {
                  loader: 'babel-loader',
                  options: {
                    presets: ['@babel/preset-env']   //转换规则
                  }
                }
            }
        ]
    }
}

