import request from "@/utils/request"

export function getRouterDataApi(){
    return request({
        url:"/index/router/",
        method:"get"
    })
}