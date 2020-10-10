<template>
  <div class="container">
    <div>
      <div style="text-align: left;">
        <a href="javascript:history.go(-1);">
          <van-icon name="arrow-left" class="next"/>
        </a>
      </div>
      <div class="chatroom-title">
        <p>工作咨询</p>
      </div>
    </div>
    <div class="chatbottom-box">
      <textarea cols="30" rows="3" class="chatinput" v-model="msg"></textarea>
      <a href="javascript:;" class="chatsend" @click="sendMsg">发送</a>
    </div>
    <div class="chatcontainer">
      <ul class="msgbox">
        <li class="msgitem" v-for="(item,index) in msgarr" :key="index">
          <div style="line-height: 45px;" v-if="item.isenterprise==1">企业回复：</div>
          <div class="person-icon" v-else :style="infolist.head_icon==null ? 'background-color: darkgrey;' : {backgroundImage:'url('+'http://127.0.0.1:8000'+infolist.head_icon+')'}"></div>
          <div class="msg" :style="{'background':rgb()}" v-text="item.msg"></div>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      infolist:[],
      msg:'',
      msgarr:[],
      islogin:0
    }
  },
  created() {
    this.getinfolist()
    this.getmsgarr()
    this.getislogin()
  },
  mounted() {
    
  },
  methods: {
    rgb(){
      var r = Math.floor(Math.random()*256);
      var g = Math.floor(Math.random()*256);
      var b = Math.floor(Math.random()*256);
      return `rgb(${r},${g},${b},0.30)`
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
        // console.log(this.infolist);
      })();
    },
    sendMsg(){
      var socket = io("ws://127.0.0.1:3000");
      socket.emit('sendMsgToServe',{
        msg:this.msg
      })
      this.msg='';
      socket.on('getMsgFromServe',msgObj=>{
        this.msgarr.push(msgObj)
        var riid=localStorage.getItem('ild');
        var id=this.$route.params.id;
        var isenterprise = 0;
        var msgitem=msgObj;
        var url="user/msgitem";
        (async ()=>{
          var result=await this.axios.get(
            url,
            {params:{riid:riid,id:id,msg:msgitem.msg,isenterprise:isenterprise}}
          );
        })();
      })
    },
    getmsgarr(){
      var url="user/msgarr";
      var riid=localStorage.getItem('ild');
      (async ()=>{
        var result=await this.axios.get(
          url,
          {params:{riid:riid,id:this.$route.params.id}}
        );
        if(result.data.length>0){
          this.msgarr = result.data;
          console.log(this.msgarr)
        }
      })();
    },
    getislogin(){
      var islogin=localStorage.getItem('login');
      if(islogin){
        this.islogin=1;
      }else{
        this.$message.error('您还没有登录！');
        setTimeout(() => {
          this.$router.push(`/person`)
        }, 1000);
      }
    }
  },
}
</script>
<style scoped>
.chatroom-title{
  margin-top: 15px;
}
.chatroom-title p{
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
.chatbottom-box{
  position: fixed;
  right: 0;
  bottom: 0;
  left: 0;
  display: flex;
  height: 40px;
  background-color: #fff;
  margin: 10px 1.2rem;
}
.chatinput{
  width: 80%;
  background: none;
  outline: none;
  border: 1px solid orange;
  border-radius: 20px;
  padding: 8px 15px 0 15px;
  resize:none;
  overflow:hidden;
}
.chatsend{
  width: 20%;
  line-height: 40px;
  display: inline-block;
  background: liner-rgadient;
  background-image: linear-gradient(to right, rgb(255, 200, 75,0.50), rgb(246, 73, 153,0.50));
  border-radius: 20px;
  text-decoration: none;
  color: tomato;
}
.chatsend:active{
  background-image: linear-gradient(to right, rgb(255, 200, 75,0.80), rgb(246, 73, 153,0.80));
}
.msgitem{
  display: flex;
}
.msgitem .person-icon{
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-size: cover;
  background-repeat: no-repeat;
}
.msgitem .msg{
  position: relative;
  word-break: break-word;
  text-align: left;
  max-width: 70%;
  line-height: 25px;
  display: inline-table;
  margin-top: 8px;
  margin-left: 16px;
  border-radius: 10px;
  padding: 2px 8px 2px 8px;
}
</style>