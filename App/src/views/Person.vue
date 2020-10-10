<template>
  <div class="container">
    <div class="part-one" v-if="islogin==0">
      <router-link to="/login">
        <div class="unlogin">立即登录</div>
      </router-link>
    </div>
    <div class="part-one" v-else>
      <div class="left-box">
        <div class="box">
          <div class="name-box">
            <span v-show="infolist.iname==null">未填写</span>
            <span v-show="infolist.iname!==null" v-text="infolist.iname"></span>
          </div>
          <span v-text="infolist.iphone"></span>
        </div>
      </div>
      <div class="right-box">
        <div class="person-icon" :style="infolist.head_icon==null ? 'background-color: darkgrey;' : {backgroundImage:'url('+'http://127.0.0.1:8000'+infolist.head_icon+')'}"></div>
      </div>
    </div>
    <div class="part-two">
      <div class="box">
        <div class="resume">我的简历</div>
        <router-link to="/resume">
          <van-icon name="arrow" class="next-page"/>
        </router-link>
      </div>
    </div>
    <div class="part-three">
      <div>我的兼职</div>
      <div class="box">
        <router-link class="item" to="/sign">
          <van-icon name="orders-o" size="26" color="orange"/>
          <div>已报名</div>
        </router-link>
        <router-link class="item" to="/sign">
          <van-icon name="user-o" size="26" color="orange"/>
          <div>已录用</div>
        </router-link>
        <router-link class="item" to="/sign">
          <van-icon name="certificate" size="26" color="orange"/>
          <div>已到岗</div>
        </router-link>
        <router-link class="item" to="/sign">
          <van-icon name="balance-pay" size="26" color="orange"/>
          <div>已结算</div>
        </router-link>
      </div>
    </div>
    <van-button color="linear-gradient(to right, rgb(255, 200, 75), rgb(246, 73, 153))" size="large" @click="logout">退出登录</van-button>
    <Tabbar></Tabbar>
  </div>
</template>
<script>
export default {
  data(){
    return{
      infolist:[],
      islogin:0
    }
  },
  mounted(){
    this.getinfolist(),
    this.get_islogin()
  },
  methods: {
    get_islogin(){
      var islogin=localStorage.getItem('login');
      if(islogin){
        this.islogin=1;
      }
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
        console.log(this.infolist);
      })();
    },
    logout(){
      localStorage.removeItem('login');
      localStorage.removeItem('ild');
      this.islogin=0;
    }
  }
}
</script>
<style scoped>
.part-one{
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
  padding-bottom: 20px;
  border-bottom: 1px solid #eeeeee;
}
.part-one .box>span{
  display: block;
  color: #828282;
}
.name-box>span{
  font-size: 20px;
  color: orange;
}
.left-box .box{
  margin-top: 40px;
}
.person-icon{
  width: 90px;
  height: 90px;
  border-radius: 50%;
  background-size: cover;
  background-repeat: no-repeat;
}
.part-two{
  margin-top: 20px;
  color: orange;
  position: relative;
  border-bottom: 1px solid #eee;
}
.part-two .box{
  width: 100%;
  text-align: left;
}
.next-page{
  color:orange;
  position: absolute;
  top: 5px;
  right: 2px !important;
}
.resume{
  padding-bottom: 15px;
}
.part-three{
  color: orange;
  text-align: left;
  padding: 15px 0;
}
.part-three .box{
  display: flex;
  margin-top: 10px;
  justify-content: space-around;
}
.part-three .box .item{
  text-align: center;
  text-decoration: none;
}
.part-three .box .item>div{
  color: #676767;
}
.van-button{
  margin-top: 45px;
}
.unlogin{
  font-size: 20px;
  color: #888;
}
</style>