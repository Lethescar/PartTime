<template>
  <div class="container">
    <div class="header">
      <div class="header-bg"></div>
      <div class="return-box">
        <a href="javascript:history.go(-1);">
            <van-icon name="arrow-left" class="next"/>
        </a>
      </div>
      <div class="box">
        <div class="headerimg" :style="{backgroundImage:'url('+'http://127.0.0.1:8000'+recruitlist.enterprise_icon+')'}"></div>
        <div class="ent-name" v-text="recruitlist.enterprise_name"></div>
      </div>
    </div>
    <van-tabs class="tab-box">
      <van-tab title="机构概况">
        <div class="box">
          <div class="title">相关简介</div>
          <div class="describe-info" v-text="recruitlist.enterprise_detail"></div>
        </div>
      </van-tab>
      <van-tab title="其他职位">
        <van-list v-model="loading" :finished="finished" finished-text="没有更多了" @load="onLoad">
          <van-cell v-for="(item,index) in enterpriselist" :key="index" :to="`/detail/${item.id}`">
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
    </van-tabs>
  </div>
</template>
<script>
export default {
  data(){
    return{
      recruitlist:[],
      infolabel:[],
      recrequire:[],
      enterpriselist:[],
      text:'',
      loading: false,
      finished: false,
      refreshing: false
    }
  },
  mounted() {
    this.getdetaillist(),
    this.getenterpricedetail()
  },
  methods: {
    getdetaillist(){
      (async ()=>{
        var result=await this.axios.get(
          "detail/detaillist",
          {params:{id:this.$route.params.id}
        })
        // console.log(result.data)
        this.recruitlist = result.data.recruitlist[0];
        this.infolabel = result.data.infolabel;
        this.recrequire = result.data.recrequire;
        this.text = result.data.recruitlist[0].position_detail.replace(/\n|\r\n/g,"<br/>")
      })();
    },
    getenterpricedetail(){
      (async ()=>{
        var result=await this.axios.get(
          "detail/enterpricedetail",
          {params:{name:this.$route.params.name}
        })
        console.log(result.data)
        this.enterpriselist = result.data;
      })();
    },
    onLoad() {
      setTimeout(() => {
        if (this.refreshing) {
          this.refreshing = false;
        }
        this.loading = false;
        // console.log(this.enterpriselist)
        if (this.enterpriselist.length >= this.enterpriselist.length) {
          this.finished = true;
        }
      }, 1000);
    }
  },
}
</script>
<style scoped>
.container{
  padding: 0;
  position: relative;
  text-align: left;
}
.next{
  width: 2.5rem;
  text-align: left;
  color:white;
  position: absolute;
  top:1.2rem;
  left: 1rem;
}
.header-bg{
  background-image: url('../../public/images/detailheader.png');
  width: 100%;
  height: 150px;
  background-size: cover;
}
.header{
  border-bottom: 4px solid #f5f5f5;
}
.header .box{
  text-align: center;
}
.headerimg{
  margin: -40px auto 0 auto;
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background-size: cover;
  background-repeat: no-repeat;
}
.ent-name{
  font-size: 15px;
  margin: 10px 0;
}
.tab-box .title{
  font-size: 15px;
  font-weight: 600;
  margin-top: 15px;
}
.tab-box .describe-info{
  margin-top: 10px;
  font-size: 15px;
} 
.tab-box .box{
  padding: 0 1rem;
}
</style>
<style>
.tab-box .van-tab--active{
  color: #ff6b31;
}
.tab-box .van-tabs__line{
  background-color: #ff6b31;
}
.detail-first-box,.detail-second-box,.detail-third-box{
  display: flex;
  color: #2c3e50;
  justify-content: space-between;
}
.detail-first-box div.title{
  display: inline-block;
  text-align: left;
  font-size: 15px;
  width: 245px;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
}
.detail-first-box div.salary{
  display: inline-block;
  text-align: right;
  color: red;
}
.detail-second-box{
  color: dimgray;
  font-size: 13px;
}
.detail-third-box div.area-box{
  background-color: lavender;
  transform: scale(0.83);
  margin-left: -5px;
}
.detail-third-box div.area-box p{
  transform: scale(0.90);
  color: dimgray;
  margin: 2px 4px;
}
</style>