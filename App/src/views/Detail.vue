<template>
    <div class="container">
      <div class="header">
        <div class="header-bg"></div>
        <div class="return-box">
          <a href="javascript:history.go(-1);">
            <van-icon name="arrow-left" class="next"/>
          </a>
        </div>
        <div class="header-info">
          <div v-text="recruitlist.rname" class="info-title"></div>
          <div class="second-box">
            <div v-text="recruitlist.rsalary" class="price"></div>
            <div class="label-box">
              <div v-for="(label, index) in infolabel" :key="index" v-text="label.lcontent"></div>
            </div>
          </div>
          <div v-text="recruitlist.area" class="area"></div>
        </div>
      </div>
      <div class="part-one">
        <div class="one-title">招聘要求</div>
        <div :class="recrequirelen==0 ? '':'hidden'">没有招聘要求哦</div>
        <div class="req-box">
          <div v-for="(req, index) in recrequire" :key="index" v-text="req.rcontent"></div>
        </div>
      </div>
      <div class="part-two">
        <div class="title-box">
          <i></i>
          <div class="title">职位详情</div>
        </div>
        <div class="detail" v-text="text" v-html="text"></div>
      </div>
      <div class="part-three">
        <div class="title-box">
          <i></i>
          <div class="title">工作时间</div>
        </div>
        <div class="time-box">
          <div class="box">
            <span>开始时间：</span>
            <i></i>
            <span v-text="recruitlist.start_time" style="vertical-align: middle;margin-left: 5px;"></span>
          </div>
          <div class="middle-box">
            <i></i>
            <span>不限</span>
          </div>
          <div class="box">
            <span>结束时间：</span>
            <i></i>
            <span v-text="recruitlist.end_time" style="vertical-align: middle;margin-left: 5px;"></span>
          </div>
        </div>
      </div>
      <div class="part-four">
        <div class="title-box">
          <i></i>
          <div class="title">工作地点</div>
        </div>
        <div v-text="recruitlist.enterprise_address" class="address"></div>
        <div class="baidumap" id="allmap"></div>
      </div>
      <div class="part-five">
        <div class="title-box">
          <i></i>
          <div class="title">机构信息</div>
        </div>
        <router-link :to="`/enterprise/${recruitlist.id}/${recruitlist.enterprise_name}`">
          <div class="contacts-box">
            <div class="headerimg" :style="{backgroundImage:'url('+'http://127.0.0.1:8000'+recruitlist.enterprise_icon+')'}"></div>
            <div class="box">
              <span v-text="recruitlist.enterprise_name"></span>
              <span>
                联系人：
                <span v-text="recruitlist.contacts"></span>
              </span>
            </div>
            <van-icon name="arrow" class="todetail"/>
          </div>
        </router-link>
      </div>
      <div class="dbottom">
        没有更多了
      </div>
      <div class="tabbar-box">
        <van-goods-action>
          <van-goods-action-icon icon="chat-o" text="咨询" :to="`/chatroom/${this.$route.params.id}`"/>
          <van-goods-action-button v-if="issign==0" type="danger" text="立即报名" style="border-radius: 20px;" @click="onClickButton"/>
          <van-goods-action-button v-else disabled type="danger" style="background: linear-gradient(to right,#d0d0d0,#9a9a9a);border-radius: 20px;" text="已报名"/>
        </van-goods-action>
      </div>
    </div>
</template>
<script>
import { Toast } from 'vant';
export default {
  data(){
    return{
      recruitlist:[],
      infolabel:[],
      recrequire:[],
      recrequirelen:0,
      text:'',
      issign:0,
      signlist:[]
    }
  },
  created() {
    this.getdetaillist()
    this.getissgn()
  },
  methods: {
    getdetaillist(){
      (async ()=>{
        var result=await this.axios.get(
          "detail/detaillist",
          {params:{id:this.$route.params.id}
          }
        )
        // console.log(result.data)
        this.recruitlist = result.data.recruitlist[0];
        this.infolabel = result.data.infolabel;
        this.recrequire = result.data.recrequire;
        this.recrequirelen = result.data.recrequire.length;
        this.text = result.data.recruitlist[0].position_detail.replace(/\n|\r\n/g,"<br/>")
        var map = new BMap.Map('allmap') // 创建地图实例
        var point = new BMap.Point(result.data.recruitlist[0].longitude,result.data.recruitlist[0].latitude) // 创建点坐标
        map.centerAndZoom(point, 15) // 初始化地图，设置中心点坐标和地图级别
        map.enableScrollWheelZoom(true) //开启鼠标滚轮缩放
        map.addControl(new BMap.NavigationControl())
        map.addControl(new BMap.ScaleControl())
        map.addControl(new BMap.OverviewMapControl())
        map.addControl(new BMap.MapTypeControl())
        //map.setMapStyle({ style: 'midnight' }) //地图风格
        var marker = new window.BMap.Marker(point) // 创建标注
        map.addOverlay(marker) // 将标注添加到地图中
        //提示信息
        var infoWindow = new BMap.InfoWindow('提示信息')
        // 鼠标移上标注点要发生的事
        marker.addEventListener('mouseover', function() {
          this.openInfoWindow(infoWindow)
        })
        // 鼠标移开标注点要发生的事
        marker.addEventListener('mouseout', function() {
          this.closeInfoWindow(infoWindow)
        })
      })();
    },
    onClickButton() {
      if(this.issign==0){
        this.issign=1;
      }
      var url="detail/issign";
      var ild=localStorage.getItem('ild');
      (async ()=>{
        var result=await this.axios.get(
          url,
          {params:{riid:ild,id:this.$route.params.id,issign:1}}
        );
        console.log(result);
        if (result.data.code==200) {
          Toast.success('报名成功');
        }
      })();
    },
    getissgn(){
      var url="detail/sign";
      var ild=localStorage.getItem('ild');
      (async ()=>{
        var result=await this.axios.get(
          url,
          {params:{ild:ild,id:this.$route.params.id}}
        );
        if(result.data.length>0){
          this.issign = result.data.issign;
        }
      })();
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
.hidden{
  display: none;
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
  height: 170px;
  background-size: cover;
}
.header-info{
  text-align: left;
  padding: 0 1rem;
  position: absolute;
  top: 3rem;
}
.header-info .info-title{
  color: white;
  font-size: 20px;
  font-weight: 300;
}
.header-info .second-box{
  display: flex;
}
.header-info .second-box .price{
  color: #ff6b31;
  padding: 7px 0px;
  font-size: 17px;
}
.header-info .second-box .label-box{
  display: flex;
  padding: 7px;
}
.header-info .second-box .label-box>div{
  padding: 3px 7px 1px 7px;
  border: 1px solid #ff6b31;
  margin-left: 7px;
  font-size: 12px;
  color: #ff6b31;
  border-radius: 3px;
}
.header-info .area{
  color: white;
}
.part-one,.part-two,.part-three,.part-four,.part-five{
  margin-top: 15px;
  padding: 0 1.2rem;
  border-bottom: 3px solid #f5f5f5;
}
.part-one .one-title{
  font-size: 13px;
  color: #888;
  padding-bottom: 5px;
}
.part-one .req-box{
  display: flex;
  margin-bottom: 15px;
}
.part-one .req-box>div{
  padding: 3px 7px 1px 7px;
  border: 1px solid #ff6b31;
  margin-right: 7px;
  font-size: 12px;
  color: #ff6b31;
  background-color: #ff670026;
  border-radius: 3px;
}
.title{
  font-size: 16px;
  font-weight: 600;
  margin-left: 10px;
}
.title-box{
  display: flex;
}
.title-box>i{
  display: inline-block;
  width: 4px;
  height: 22px;
  border-radius: 0px 8px 0px 8px;
  background-color: tomato;
}
.part-two .detail{
  margin-top: 10px;
  font-size: 14px;
  line-height: 23px;
  padding-bottom: 15px;
}
.part-three .time-box{
  margin: 10px 0;
}
.part-three .time-box .box>i{
  display: inline-block;
  vertical-align: middle;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  border: 4px solid #ff6b31;
}
.part-three .time-box .middle-box>i{
  display: inline-block;
  vertical-align: middle;
  width: 2px;
  margin-left: 87px;
  height: 46px;
  background-color: #ff6b31;
}
.part-three .time-box .middle-box>span{
  margin-left: 10px;
  font-size: 15px;
}
.headerimg{
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background-size: cover;
  background-repeat: no-repeat;
}
.contacts-box{
  position: relative;
  display: flex;
  margin-top: 10px;
  background-color: #eee;
  padding: 10px;
  border-radius: 5px;
  margin-bottom: 15px;
}
.contacts-box .box{
  color: #2c3e50;
  margin-top: 10px;
  margin-left: 10px;
}
.contacts-box .box>span{
  display: block;
}
.todetail{
  line-height: 60px;
  right: 10px;
  position: absolute;
}
.dbottom{
  text-align: center;
  font-size: 13px;
  padding: 15px 15px 25px 15px;
  background-color: #f5f5f5;
}
.part-four{
  position: relative;
  height: 230px;
}
.part-four .address{
  margin-top: 10px;
}
.baidumap {
  width: 90%;
  margin: auto;
  height: 150px;
  border: 1px solid red;
  position: absolute;
  bottom: 15px;
}
</style>
<style>
/* 去除百度地图版权那行字 和 百度logo */
.BMap_scaleCtrl {
  height: 0 !important;
}
.baidumap div.anchorBL{
  display: none;
}
</style>