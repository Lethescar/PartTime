<template>
  <div class="container">
    <div class="headtitle">全部兼职</div>
    <van-dropdown-menu>
      <van-dropdown-item v-model="value1" :options="option1" @change="selecttype"/>
      <van-dropdown-item v-model="value2" :options="option2" @change="selectarea"/>
      <van-dropdown-item v-model="value3" :options="option3"/>
      <van-dropdown-item title="筛选" ref="item">
        <div class="selected-label" v-if="currlabelarr.length">
          <label>已选标签：</label>
          <div class="selected">
            <span v-for="(item,index) in currlabelarr" :key="index" v-text="activeLabel[item]" @click="dellabel(item)"></span>
          </div>
          <span class="delall" @click="delall">全部删除</span>
        </div>
        <div class="select-label">
          <div class="label labelsex">性别要求</div>
          <div class="labelreq">
            <span @click="addLabel('sex_require','不限')" :class="{'active':activeLabel.sex_require == '不限'}">不限</span>
            <span @click="addLabel('sex_require','男')" :class="{'active':activeLabel.sex_require == '男'}">男</span>
            <span @click="addLabel('sex_require','女')" :class="{'active':activeLabel.sex_require == '女'}">女</span>
          </div>
          <div class="label labeltime">上班时段</div>
          <div class="labelreq">
            <span @click="addLabel('time_interval','不限')" :class="{'active':activeLabel.time_interval == '不限'}">不限</span>
            <span @click="addLabel('time_interval','上午')" :class="{'active':activeLabel.time_interval == '上午'}">上午</span>
            <span @click="addLabel('time_interval','下午')" :class="{'active':activeLabel.time_interval == '下午'}">下午</span>
            <span @click="addLabel('time_interval','晚上')" :class="{'active':activeLabel.time_interval == '晚上'}">晚上</span>
          </div>
          <div class="label labelperiod">工作周期</div>
          <div class="labelreq">
            <span @click="addLabel('work_cycle','不限')" :class="{'active':activeLabel.work_cycle == '不限'}">不限</span>
            <span @click="addLabel('work_cycle','长期')" :class="{'active':activeLabel.work_cycle == '长期'}">长期</span>
            <span @click="addLabel('work_cycle','短期')" :class="{'active':activeLabel.work_cycle == '短期'}">短期</span>
            <span @click="addLabel('work_cycle','周末')" :class="{'active':activeLabel.work_cycle == '周末'}">周末</span>
          </div>
        </div>
      </van-dropdown-item>
    </van-dropdown-menu>
    <van-list v-model="loading" :finished="finished" finished-text="没有更多了" @load="onLoad">
      <van-cell v-for="(item,index) in currentlist" :key="index" :to="`/detail/${item.id}`">
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
    <Tabbar></Tabbar>
  </div>
</template>
<script>
export default {
  data(){
    return{
      loading: false,
      finished: false,
      refreshing: false,
      poslist: [],
      currentlist: [],
      infolabel: [],
      filterlabel: [],
      typelist: [],
      value1: 0,
      value2: 0,
      value3: 0,
      option1: [
        { text: '全部', value: 0 },
        { text: '派单', value: 1 },
        { text: '销售', value: 2 },
        { text: '服务员', value: 3 },
        { text: '礼仪', value: 4 },
        { text: '家教导师', value: 5 },
      ],
      option2: [
        { text: '区域', value: 0 },
        { text: '历下区', value: 1 },
        { text: '市中区', value: 2 },
        { text: '槐荫区', value: 3 },
        { text: '天桥区', value: 4 },
        { text: '历城区', value: 5 },
        { text: '长清县', value: 6 },
        { text: '平阴县', value: 7 },
        { text: '济阳县', value: 8 },
        { text: '商河县', value: 9 },
        { text: '章丘市', value: 10 },
        { text: '高新区', value: 11 },
      ],
      option3: [
        { text: '综合排序', value: 0 },
        { text: '最新发布', value: 1 },
      ],
      activeLabel:{
        sex_require:'',
        time_interval:'',
        work_cycle:''
      },
      pno:1
    }
  },
  mounted(){
    this.getposlist()
    this.getinfolabel()
    this.getCheck()
    this.selecttype()
  },
  computed: {
    currlabelarr(){
      return Object.keys(this.activeLabel).filter(str=>{
        if(this.activeLabel[str] !== ''){
          return true
        }
      })
    }
  },
  methods: {
    addLabel(type,value){
      this.activeLabel[type] = value
      this.filterList()
    },
    dellabel(key){
      this.activeLabel[key] = ''
      this.filterList()
    },
    delall(){
      this.currlabelarr.forEach(item => {
        this.activeLabel[item] = ''
      });
      this.filterList()
    },
    getposlist(){
      var url="alllist/recruit_list";
      (async ()=>{
        var result=await this.axios.get(
          url,
        );
        this.poslist=result.data.data;
        this.currentlist = result.data.data;
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
    getCheck(id){
      var filterlabel=this.filterlabel;
      var infolabel=this.infolabel;
      filterlabel = infolabel.filter(item=>{
        return item.rlid == id;
      })
      return filterlabel;
    },
    filterList(){
      this.currentlist = this.poslist.filter(pos => {
        return this.currlabelarr.every(item =>{
          return this.activeLabel[item] == pos[item]
        })
      })
    },
    selecttype(){
      //1.创建url地址
      var url="alllist/typelist"
      if(this.value1==0){
        this.getposlist()
        this.currentlist = this.poslist
      }else if(this.value1==1){ 
        var obj={work_type:'派单'}
      }else if(this.value1==2){
        var obj={work_type:'销售'}
      }else if(this.value1==3){
        var obj={work_type:'服务员'}
      }else if(this.value1==4){
        var obj={work_type:'礼仪'}
      }else if(this.value1==5){
        var obj={work_type:'家教导师'}
      }
      //2.发送ajax请求获取数据
      this.axios.get(url,{params:obj}).then(res=>{
        //3.将数据保存在data中
        this.currentlist=res.data.data;
        if(this.value1==0)
          this.currentlist=this.poslist
        // this.list=rows;
      })
    },
    selectarea(){
      //1.创建url地址
      var url="alllist/arealist"
      if(this.value2==0){
        this.getposlist()
        this.currentlist = this.poslist
      }else if(this.value2==1){
        var obj={area:'历下区'}
      }else if(this.value2==2){
        var obj={area:'市中区'}
      }else if(this.value2==3){
        var obj={area:'槐荫区'}
      }else if(this.value2==4){
        var obj={area:'天桥区'}
      }else if(this.value2==5){
        var obj={area:'历城区'}
      }else if(this.value2==6){
        var obj={area:'长清县'}
      }else if(this.value2==7){
        var obj={area:'平阴县'}
      }else if(this.value2==8){
        var obj={area:'济阳县'}
      }else if(this.value2==9){
        var obj={area:'商河县'}
      }else if(this.value2==10){
        var obj={area:'章丘市'}
      }else if(this.value2==11){
        var obj={area:'高新区'}
      }
      //2.发送ajax请求获取数据
      this.axios.get(url,{params:obj}).then(res=>{
        //3.将数据保存在data中
        console.log(res.data.data)
        this.currentlist=res.data.data;
        if(this.value2==0)
          this.currentlist=this.poslist
        // this.list=rows;
      })
    },
    onLoad() {
      setTimeout(() => {
        if (this.refreshing) {
          this.refreshing = false;
        }
        this.loading = false;
        // console.log(this.enterpriselist)
        if (this.currentlist.length >= this.currentlist.length) {
          this.finished = true;
        }
      }, 1000);
    }
  }
}
</script>
<style scoped>
.container{
  padding: 0;
}
.headtitle{
  font-size: 16px;
  margin: 20px 0;
  text-align: center;
}
.label{
  text-align: left;
  font-size: 14px;
  color: #888;
  margin-top: 10px;
  margin-left: 1rem;
}
.labelreq{
  margin-top: 5px;
  display: flex;
  margin-left: 1rem;
}
.labelreq>span{
  font-size: 14px;
  background-color: #f5f5f5;
  width: 64px;
  border: 1px solid #e5e5e5;
  border-radius: 5px;
  padding: 3px 0px;
  margin-right: 1rem;
}
span.active{
  background-color: #ff6b3142;
  border: 1px solid tomato;
}
.select-label{
  margin-bottom: 20px;
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
.selected-label{
  text-align: left;
  margin: 15px 1rem;
}
.selected-label>label{
  display: block;
  font-size: 14px;
  color: #888;
}
.selected-label .selected{
  display: inline-block;
}
.selected-label .selected>span{
  font-size: 14px;
  display: inline-block;
  text-align: center;
  background-color: #ff6b3142;
  border: 1px solid tomato;
  width: 64px;
  border-radius: 5px;
  padding: 3px 0px;
  margin-right: 1rem;
}
.delall{
  color: red;
  font-size: 14px;
}
.van-list{
  margin-bottom: 50px;
}
</style>