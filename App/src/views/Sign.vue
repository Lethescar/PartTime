<template>
  <div class="container">
    <div style="text-align: left;">
      <a href="javascript:history.go(-1);">
        <van-icon name="arrow-left" class="next"/>
      </a>
    </div>
    <div class="sign-title">
      <p>我的申请</p>
    </div>
    <van-tabs v-model="active" class="active">
      <van-tab title="已报名">
        <van-list class="search-box" v-model="loading" :finished="finished" finished-text="没有更多了" @load="onLoad">
          <van-cell v-for="(item,index) in signlist" :key="index" :to="`/detail/${item.id}`">
            <div class="detail-first-box">
              <div class="title" v-text="item.rname"></div>
              <div class="salary" v-text="item.rsalary"></div>
            </div>
            <div class="detail-second-box">
              <div class="enterprise-name" v-text="item.enterprise_name"></div>
              <div class="salary-term" v-text="item.salary_term"></div>
            </div>
            <div class="detail-third-box">
              <div class="area-box">
                <p v-text="item.area"></p>
              </div>
            </div>
          </van-cell>
        </van-list>
      </van-tab>
      <van-tab title="已录用"></van-tab>
      <van-tab title="已到岗"></van-tab>
      <van-tab title="已结算"></van-tab>
    </van-tabs>
  </div>
</template>
<script>
export default {
  data() {
    return {
      active: 0,
      issignlist:[],
      signlist:[],
      relist:[],
      idlist:[],
      loading: false,
      finished: false,
      refreshing: false
    }
  },
  created() {
    this.getsign()
  },
  methods: {
    onLoad() {
      setTimeout(() => {
        if (this.refreshing) {
          this.refreshing = false;
        }
        this.loading = false;
        if (this.signlist.length >= this.signlist.length) {
          this.finished = true;
        }
      }, 1000);
    },
    getsign(){
      var ild=localStorage.getItem('ild');
      var url="user/sign";
      (async ()=>{
        var result=await this.axios.get(
          url,
          {params:{ild:ild}}
        );
        this.issignlist=result.data.issignlist;
        this.relist=result.data.relist;
        this.idlist=result.data.idlist;
        this.relist.forEach(item => {
          if (this.idlist.includes(item.id)) {
            this.signlist.push(item);
          };
        })
        console.log(this.signlist);
      })();
    },
  },
}
</script>
<style scoped>
.sign-title{
  margin-top: 15px;
}
.sign-title p{
  color: orange;
}
.next{
  width: 2.5rem;
  text-align: left;
  color:orange;
  position: absolute;
  top:1.2rem;
  left: 1rem;
}
</style>