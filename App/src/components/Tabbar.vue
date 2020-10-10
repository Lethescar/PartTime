<template>
  <div class="tabbar-box">
    <van-tabbar v-model="active" route>
      <van-tabbar-item replace to="/" icon="home-o">
        首页
      </van-tabbar-item>
      <van-tabbar-item replace to="/alllist" icon="orders-o">
        全部兼职
      </van-tabbar-item>
      <van-tabbar-item replace to="/person" icon="contact">
        我的
      </van-tabbar-item>
    </van-tabbar>
  </div>
</template>
<script>
export default {
  data() {
    return {
      active: 1,
    }
  },
  methods: {
    
  },
}
</script>
<style scoped>
.van-tabbar{
  box-shadow: 0px 0px 5px #a5a5a5
}
</style>
