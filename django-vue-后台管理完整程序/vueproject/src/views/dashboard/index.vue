<template>
  <div class="dashboard-container">
    <div class="dashboard-text" >name: {{ name }}</div>
    <div><span isbtnpermission="add" v-has>测试has是否启用</span></div>
    <el-button type="primary" v-has>编辑</el-button>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Dashboard',
  methods:{
    ceshi(){
      // console.log(this.$store.getters.ceshi)
    }
  },
  computed: {
    ...mapGetters([
      'name'
    ])
  },
  created(){
  }
}
</script>

<style lang="scss" scoped>
.dashboard {
  &-container {
    margin: 30px;
  }
  &-text {
    font-size: 30px;
    line-height: 46px;
  }
}
</style>
