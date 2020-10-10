<template>
    <div class="container">
      <div class="header-box">
        <a href="javascript:history.go(-1);">
          <van-icon name="arrow-left" class="next"/>
        </a>
        <div class="head-title">我的简历</div>
      </div>
      <div class="part part-one">
        <router-link class="edit" to="/basicinfo">编辑</router-link>
        <div class="headerimg" :style="infolist.head_icon==null ? 'background-color: darkgrey;' : {backgroundImage:'url('+'http://127.0.0.1:8000'+infolist.head_icon+')'}"></div>
        <div v-show="infolist.iname==null" style="margin-top:10px;">未填写</div>
        <div v-show="infolist.iname!=null" style="margin-top:10px;">{{infolist.iname}}</div>
        <div class="box">
          <div v-show="infolist.isex==null" style="border-right:2px solid rgb(197, 197, 197);">未填写</div>
          <div v-show="infolist.isex!=null" style="border-right:2px solid rgb(197, 197, 197);">{{infolist.isex}}</div>
          <div v-show="infolist.ieducation==null" style="border-right:2px solid rgb(197, 197, 197);">未填写</div>
          <div v-show="infolist.ieducation!=null" style="border-right:2px solid rgb(197, 197, 197);">{{infolist.ieducation}}</div>
          <div v-show="infolist.iarea==null">未填写</div>
          <div v-show="infolist.iarea!=null">{{infolist.iarea}}</div>
        </div>
        <div style="font-size:13px;margin-top:5px;">手机：{{infolist.iphone}}</div>
      </div>
      <div class="part part-two">
        <div class="title">教育经历</div>
        <div class="edit">编辑</div>
        <div class="border-box">
          <div class="icon"></div>
          <div class="leftmargin">
            <div class="box">
              <div v-show="infolist.admission_date!=null">{{infolist.admission_date}}-{{infolist.graduation_date}}</div>
              <div v-show="infolist.admission_date==null">时间：</div>
            </div>
            <div v-show="infolist.ischool!=null">{{infolist.ischool}}</div>
            <div v-show="infolist.ischool==null">学校名称</div>
            <div>主修专业：
              <span v-text="infolist.imajor"></span>
            </div>
            <div>在校经历：
              <span v-text="infolist.association_activity"></span>
            </div>
          </div>
          
        </div>
      </div>
    </div>
</template>
<script>
export default {
  data(){
    return{
      infolist:[]
    }
  },
  mounted() {
    this.getinfolist()
  },
  methods: {
    getinfolist(){
      var ild=localStorage.getItem('ild');
      var url="user/infolist";
      (async ()=>{
        var result=await this.axios.get(
          url,
          {params:{ild:ild}}
        );
        this.infolist=result.data[0];
        console.log(this.infolist);
      })();
    }
  },
}
</script>
<style scoped>
.container{
  text-align: center;
}
.next{
  width: 2.5rem;
  text-align: left;
  color:orange;
  position: absolute;
  top:1.2rem;
  left: 1rem;
}
.head-title{
  margin-top: 1.2rem;
}
.headerimg{
  margin: auto;
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background-size: cover;
  background-repeat: no-repeat;
}
.part-one{
  margin-top: 10px;
}
.edit{
  position: absolute;
  right: 5px;
  color: orange;
}
.part-one .box{
  color: #888;
  margin-top: 5px;
  font-size: 13px;
  display: flex;
  justify-content: center;
}
.part-one .box div{
  padding: 0 5px;
}
.part{
  position: relative;
  margin-bottom: 20px;
  font-size: 15px;
  border: 1px solid orange;
  padding: 5px;
  border-radius: 5px;
}
.part-two .title{
  color: orange;
  text-align: left;
}
.part-two .edit{
  position: absolute;
  right: 5px;
  top: 5px;
  color: orange;
}
.part-two .border-box{
  margin-top: 5px;
  border-top: 1px solid rgb(197, 197, 197);
  padding-top: 5px;
  display: flex;
}
.part-two .icon{
  margin-top: 5px;
  width: 10px;
  height: 10px;
  background-color: orange;
  border-radius: 50%;
}
.part-two .border-box .box{
  display: flex;
}
.part-two .border-box .leftmargin{
  margin-left: 5px;
  text-align: left;
}
</style>