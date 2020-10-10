<template>
  <div class="container">
    <div class="container-box">
      <van-pull-refresh v-model="refreshing" @refresh="onRefresh">
        <van-row class="home-header" type="flex" justify="space-between">
          <van-col span="6" class="loc-box">
            <van-icon name="location" color="#ffba17" class="loc-icon"/>
            <div class="loc-city">{{LocationCity}}</div>
          </van-col>
          <van-col span="18">
            <router-link to="/search">
              <van-search v-model="value" shape="round" placeholder="请输入搜索关键词"/>
            </router-link>
          </van-col>
        </van-row>
        <!-- swiper 轮播图 -->
        <van-swipe :autoplay="6000">
          <van-swipe-item v-for="(image, index) in images" :key="index">
            <img :src="'http://127.0.0.1:8000'+image.pic_url" alt="">
          </van-swipe-item>
        </van-swipe>
        <van-grid class="home-grid" clickable :border="false" :column-num="4">
          <van-grid-item icon="home-o" text="企业直招" to="/" />
          <van-grid-item icon="search" text="附近兼职" to="/" />
          <van-grid-item icon="home-o" text="技能兼职" to="/" />
          <van-grid-item icon="search" text="更多" to="/" />   
        </van-grid>
        <div class="pos-title">
          <p>职位推荐</p>
        </div>
        <van-list v-model="loading" :finished="finished" finished-text="没有更多了" @load="onLoad">
          <van-cell v-for="(item,index) in poslist" :key="index" :to="`/detail/${item.id}`">
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
            <div class="detail-fourth-box" v-if="item">
              <div v-for="(item2,index2) in getCheck(item.id)" :key="index2" class="info-label-box">
                <div class="info-label" v-text="item2.lcontent" :class="item2.is_bgcolor==1?'bgcolor':''"></div>
              </div>
            </div>
          </van-cell>
        </van-list>
      </van-pull-refresh>
    </div>
    <Tabbar></Tabbar>
  </div>
</template>

<script>
import BMap from 'BMap'

export default {
  data(){
    return{
      value: '',
      active: '',
      LocationCity:"正在定位",    //给渲染层定义一个初始值
      images: [],
      poslist: [],
      infolabel: [],
      filterlabel: [],
      loading: false,
      finished: false,
      refreshing: false
    }
  },
  mounted(){
    this.city()    //触发获取城市方法
    this.getSwiper()
    this.getposlist()
    this.getinfolabel()
    this.getCheck()
  },
  methods:{
    getCheck(id){
      var filterlabel=this.filterlabel;
      var infolabel=this.infolabel;
      filterlabel = infolabel.filter(item=>{
        return item.rlid == id;
      })
      return filterlabel;
    },
    city(){    //定义获取城市方法
      const geolocation = new BMap.Geolocation();
      var _this = this
      geolocation.getCurrentPosition(function getinfo(position){
        let city = position.address.city;             //获取城市信息
        let province = position.address.province;     //获取省份信息
        let district=position.address.district;       //县
        let street=position.address.street;           //街道
        // _this.LocationCity =province+city+district+street;
        _this.LocationCity = city;    //赋值
        _this.success = true;
      }, function(e) {
        _this.LocationCity = "定位失败"
      }, {provider: 'baidu'});	
    },
    getSwiper(){
      var url="home/swiper_pic";
      (async ()=>{
        var result=await this.axios.get(
          url,
        );
        this.images=result.data.data;
      })();
    },
    getposlist(){
      var url="home/recruit_list";
      (async ()=>{
        var result=await this.axios.get(
          url,
          {params:{typeid:'200'}}
        );
        this.poslist=result.data.data;
      })();
    },
    getinfolabel(){
      var url="home/info_label";
      (async ()=>{
        var result=await this.axios.get(
          url,
        );
        this.infolabel=result.data.data;
      })();
    },
    onLoad() {
      setTimeout(() => {
        if (this.refreshing) {
          this.refreshing = false;
        }
        this.loading = false;
        if (this.poslist.length >= this.poslist.length) {
          this.finished = true;
        }
      }, 1000);
    },
    onRefresh() {
      // 清空列表数据
      this.finished = false;
      // 重新加载数据
      // 将 loading 设置为 true，表示处于加载状态
      this.loading = true;
      this.onLoad();
    },
  },
}
</script>

<style scoped>
.container-box{
  padding-bottom: 50px;
  width: 100%;
  margin: 0 auto;
}
.home-header{
  height: 50px;
}
.home-header .loc-box{
  display: inline-block;
  line-height: 50px;
}
.home-header .loc-box .loc-icon{
  vertical-align: text-top;
}
.home-header .loc-box .loc-city{
  font-size: 14px;
  display: inline-block;
  margin-left: 5px;
}
.van-search{
  padding: 10px 2px;
}
/* swiper */
.van-swipe{
  height: 147px;
  border-radius: 8px;
}
.van-swipe .van-swipe-item img{
  width: 100%;
}
/* 职位推荐 */
.pos-title{
  height: 30px;
  font-size: 13px;
  font-weight: bold;
  line-height: 30px;
}
.pos-title p{
  margin: 0;
  float: left;
  padding-left: 10px;
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
.detail-fourth-box{
  font-size: 13PX;
}
.detail-fourth-box .info-label-box,.info-label{
  display: inline;
}
.detail-fourth-box .info-label-box{
  margin-right: 5px;
}
.detail-fourth-box .info-label{
  padding: 2px;
  color: red;
  border: 1px solid red;
  border-radius: 2px;
}
.bgcolor{
  border: unset !important;
  background-image: linear-gradient(to right, rgb(255, 224, 0), rgba(253, 98, 44, 0.73));
}
</style>
<style>
.home-grid{
  justify-content: space-between;
}
.home-grid .van-grid-item__text{
  color: #2c3e50;
  font-weight: bold;
}
.home-grid .van-grid-item{
  flex-basis: 20% !important;
}
</style>