<template>
  <div class="container">
    <div style="text-align: left;">
      <a href="javascript:history.go(-1);">
        <van-icon name="arrow-left" class="next"/>
      </a>
    </div>
    <div class="login-title">
      <p>用户登录</p>
    </div>
    <div class="login-box">
      <div class="phone">
        <input class="phone-input" v-model="phone" placeholder="请输入手机号">
      </div>
      <div class="upwd">
        <input class="upwd-input" v-model="upwd" type="password" placeholder="请输入6-20位密码">
      </div>
      <div class="bottom">
        <router-link class="register" to="/register">立即注册</router-link>
      </div>
      <van-button color="linear-gradient(to right, rgb(255, 200, 75), rgb(246, 73, 153))" size="large" @click="login">登录</van-button>
    </div>
  </div>
</template>
<script>
import { Toast } from 'vant';
export default {
  data() {
    return {
      phone:'',
      upwd:'',
      islogin:0,
    }
  },
  methods: {
    login(){
      var phone=this.phone;
      var pwd=this.upwd;
      var phonereg = /^1[3-9]\d{9}$/;
      var upwdreg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/;
      if(!phonereg.test(phone)){
          this.$toast("手机号码格式不正确");
          return;
       }
       // 密码提示
       if(!upwdreg.test(pwd)){
         this.$toast("密码格式不正确,必须包含数字和英文");
         return;
       }
      var url="user/login";
      var obj={phone:phone,pwd:pwd};
      this.axios.get(url,{params:obj}).then(res=>{
        var code=res.data.code;
        if (code==-1) {
          Toast.fail('账号或密码不正确');
        } else {
          localStorage.setItem('login',res.data.code);
          localStorage.setItem('ild',res.data.ild)
          var islogin=localStorage.getItem('login');
          if(islogin){
            this.islogin=1;
            console.log(this.islogin);
          }
          console.log(res)
          setTimeout(() => {
              this.$router.push(`/person`)
          }, 1000);
          Toast.success('登录成功');
        }
      });
    },
  },
}
</script>
<style>
.container{
  text-align: center;
}
.login-title{
  margin-top: 100px;
}
.login-title p{
  font-size: 20px;
  font-weight: bold;
  color: orange;
}
.login-box{
  margin-top: 50px;
}
.phone,.upwd{
  border-bottom: 1px solid #eee;
  margin-bottom: 15px;
}
.phone-input,.upwd-input{
  width: 100%;
  height: 45px;
  padding: 0 10px;
  border: unset;
}
.bottom{
  margin: 0 10px 45px 10px;
  display: flex;
  justify-content: space-between;
}
.register{
  color: #757575;
}
.next{
  width: 2.5rem;
  text-align: left;
  color:orange;
  position: absolute;
  top:1.2rem;
}
</style>