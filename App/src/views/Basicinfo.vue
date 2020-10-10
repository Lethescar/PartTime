<template>
  <div class="container">
    <div class="head-box">
      <a href="javascript:history.go(-1);">
        <van-icon name="arrow-left" class="next"/>
      </a>
      <div class="head-title">基本信息</div>
    </div>
    <div class="part-one">
      <div class="box">
        <div>简历头像</div>
        <div class="headerimg" :style="infolist.head_icon==null ? 'background-color: darkgrey;' : {backgroundImage:'url('+'http://127.0.0.1:8000'+infolist.head_icon+')'}"></div>
        <van-uploader :before-read="beforeRead" :max-count="1">
          <van-button color="linear-gradient(to right, rgb(255, 200, 75), rgb(246, 73, 153))">上传</van-button>
        </van-uploader>
      </div>
    </div>
    <div class="part-two">
      <div class="name">
        <div class="phone">
          <input class="phone-input" v-model="iname" placeholder="请输入姓名">
        </div>
        <div class="age">
          <input class="phone-input" v-model="iage" placeholder="请输入年龄">
        </div>
        <div class="education">
          <input class="phone-input" v-model="ieducation" placeholder="请输入学历">
        </div>
        <div class="sex">
          <div>性别</div>
          <van-radio-group v-model="radio" direction="horizontal">
            <van-radio name="1" checked-color="orange">男</van-radio>
            <van-radio name="2" checked-color="orange">女</van-radio>
          </van-radio-group>
        </div>
        <div class="city">
          <van-cell is-link @click="showPopup">所在城市</van-cell>
          <div v-text="city" style="position: absolute;top: 10px;right: 34px;color: #323233;"></div>
          <van-popup v-model="show" position="bottom" :style="{ height: '30%' }">
            <van-picker :columns="citylist" @change="onChange" />
          </van-popup>
        </div>
        <van-button color="linear-gradient(to right, rgb(255, 200, 75), rgb(246, 73, 153))" size="large" @click="updateinfo">提交</van-button>
      </div>
    </div>
  </div>
</template>
<script>
import { Toast } from 'vant';
export default {
  data(){
    return{
      infolist:[],
      iconList: [],
      iname:'',
      iage:'',
      radio: '1',
      citylist: ['济南', '青岛', '淄博', '枣庄', '东营'],
      show: false,
      city:'济南',
      ieducation:'',
    }
  },
  mounted() {
    this.getinfolist()
  },
  methods: {
    showPopup() {
      this.show = true;
    },
    onChange(picker, value) {
      this.city=value;
      return this.city;
    },
    updateinfo() {
      var ild=localStorage.getItem('ild');
      var iarea = this.city;
      var ieducation= this.ieducation;
      if(this.radio==1){
        var isex = '男'
      }else{
        var isex = '女'
      }
      var iage = this.iage;
      var iname = this.iname;
      var url='user/updata';
      (async ()=>{
        var result=await this.axios.get(
          url,
          {
            params:
            {
              iarea:iarea,
              ild:ild,
              isex:isex,
              iage:iage,
              iname:iname,
              ieducation:ieducation
            }
          }
        );
        if (result.data.code==200) {
          Toast.success('提交成功');
        }
      })();
    },
    getinfolist(){
      var ild=localStorage.getItem('ild');
      var url="user/infolist";
      (async ()=>{
        var result=await this.axios.get(
          url,
          {params:{ild:ild}}
        );
        this.infolist=result.data[0];
        this.iname = this.infolist.iname;
        this.iage = this.infolist.iage;
        this.ieducation = this.infolist.ieducation;
        this.iarea = this.infolist.iarea;
        this.isex = this.infolist.isex;
        if(this.isex=='男'){
          this.radio = '1';
        }else{
          this.radio = '2';
        }
      })();
    },
    beforeRead(file,detail) {
      if (file.type !== 'image/png') {
        Toast('请上传 png 格式图片');
        return false;
      }
      console.log(file,detail)
      if(file.name){
        var head_icon =`/images/${file.name}`;
        var ild=localStorage.getItem('ild');
        var url='user/headicon';
        (async ()=>{
          var result=await this.axios.get(
            url,
            {params:{head_icon:head_icon,ild:ild}}
          );
          if (result.data.code==200) {
            Toast.success('上传成功');
          }
        })();
      }
      return true;
    },
    submit(){

    }
  },

}
</script>
<style scoped>
.container{
  color: #828282;
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
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background-size: cover;
  background-repeat: no-repeat;
}
.part-one .box{
  display: flex;
  line-height: 60px;
  justify-content: space-between;
  padding: 15px 10px 10px 10px;
}
.part-two .sex{
  padding: 0 10px;
  display: flex;
  justify-content: space-between;
}
.part-two .city{
  position: relative;
}
.phone,.age,.sex,.city,.education{
  border-bottom: 1px solid #eee;
  margin-bottom: 15px;
}
.sex{
  height: 45px;
  padding: 0 10px;
  line-height: 45px;
}
</style>
<style>
.part-one .box .van-button{
  height: 32px;
  line-height: 32px;
}
.part-two .city .van-cell{
  padding: 10px 10px;
  font-size: 16px;
}
.part-two .city .van-cell__value--alone{
  color: #828282;
}
</style>