<template>
  <div class="container">
    <div class="return-box">
      <a href="javascript:history.go(-1);">
        <van-icon name="arrow-left" class="next"/>
      </a>
    </div>
    <div class="login-title">
      <p>用户注册</p>
    </div>
    <div class="login-box">
      <div class="phone">
        <input class="phone-input" v-model="phone" placeholder="请输入手机号">
      </div>
      <div class="upwd">
        <input class="upwd-input" v-model="upwd" type="password" placeholder="请输入6-20位密码">
      </div>
      <van-button color="linear-gradient(to right, rgb(255, 200, 75), rgb(246, 73, 153))" size="large" @click="register">立即注册</van-button>
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
    };
  },
  methods: {
    register(){
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
      var url="user/vali";
      var phone=this.phone;
      var obj={iphone:phone};
      this.axios.get(url,{params:obj}).then(res=>{
        console.log(res);
        var code=res.data.code;
        if (code==0) {
          Toast.fail('该手机号已被注册');
        }
        if(code == 1){
          var url="user/register";
          var obj={iphone:phone,ipwd:pwd};
          this.axios.get(url,{params:obj}).then(res=>{
            var code=res.data.code;
            if (res.data.code==200) {
              setTimeout(() => {
                  this.$router.push("/login")
              }, 3000);
              Toast.success('注册成功,正在跳转...');
            } 
          })
        }
      });
    },
  },
}
</script>
<style scoped>
.upwd{
  margin-bottom: 45px;
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