const getters = {
  sidebar: state => state.app.sidebar,
  device: state => state.app.device,
  token: state => state.user.token,
  avatar: state => state.user.avatar,
  name: state => state.user.name,
  //用户
  
  //路由
  newRoutes:state=>state.permissions.newRoutes,
  menuRoutes:state=>state.permissions.menuRoutes,
  //菜单
  getAllMenuData:state=>state.menus.getAllMenuData,
  //权限
  getControlAllData:state=>state.controls.getControlAllData,
  //角色
  getRoleAllData:state=>state.roles.getRoleAllData,
  getRoleOptionData:state=>state.roles.getRoleOptionData,
}


export default getters
