import Vue from "vue"

//权限指令
const has = Vue.directive('has',{
    inserted:function(el,binding,vnode){
        // console.log('vnode',vnode.context.$route.meta.btnpermission)
        if (!Vue.prototype.$_has(el,vnode)){
            el.parentNode.removeChild(el)
        }
    }
})

Vue.prototype.$_has = function(el,vnode){
    let listData=vnode.context.$route.meta.btnpermission
    let elData=el.getAttribute('isbtnpermission')
    if(listData.includes(elData)){return true}else{return false}
}

export {has}

