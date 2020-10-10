<template>
  <div class="container">
    <div class="container-box">
      <van-row class="search-header" type="flex" justify="space-between">
        <van-col span="2" class="return-box">
          <a href="javascript:history.go(-1);">
            <van-icon name="arrow-left" class="next"/>
          </a>
        </van-col>
        <van-col span="22">
          <van-search id="inputvalue" v-model="value" placeholder="请输入商家或商品名称" show-action shape="round" @search="onSearch" @cancel="onCancel"/>
        </van-col>
      </van-row>  
      <!-- 热门搜索start --> 
      <div class="popular-search" :class="searchlistlen == 0 ? '':'hidden'">
          <div class="hot-search">热门搜索</div>
          <div class="label-box">
            <div class="lab-btn" @click="onClick" v-for="(item,index) in labellist" :key="index" v-text="item"></div>
          </div>
      </div>
    <!-- 查询列表 -->
      <van-list class="search-box" v-model="loading" :finished="finished" finished-text="没有更多了" @load="onLoad">
        <van-cell v-for="(item,index) in searchlist" :key="index" :to="`/detail/${item.id}`">
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
    </div>
  </div>
</template>
<script>
import { Toast } from 'vant';
export default {
  data() {
    return {
      value: '',
      labellist:['日结','家教','服务员','直招兼职'],
      datalist: [],
      searchlist: [],
      searchlistlen: 0,
      loading: false,
      finished: false,
      refreshing: false
    };
  },
  mounted() {
    this.getdata()
  },
  methods: {
    getdata(){
      var url="home/recruitlist";
      (async ()=>{
        var result=await this.axios.get(
          url,
        );
        this.datalist=result.data.data;
        console.log(this.datalist);
      })();
    },
    onClick(event) {
      var clickvalue = document.getElementById("inputvalue").value
      clickvalue = event.target.innerText
      var filter_datalist = this.datalist
      var search_value = clickvalue;
      filter_datalist = filter_datalist.filter(function(item){
        if(item.rname.indexOf(search_value) !== -1){
          return item;
        }
      })
      // 返回过来后的数组
      this.searchlist = filter_datalist
      this.searchlistlen = filter_datalist.length
      if(this.searchlistlen == 0){
        Toast('还没有相关职位哦！')
      }
      console.log(this.searchlist,this.searchlistlen)
    },
    onSearch() {
      var filter_datalist = this.datalist
      console.log(filter_datalist);
      var search_value = this.value;
      if(!search_value){
          return filter_datalist;
      }
      filter_datalist = filter_datalist.filter(function(item){
        if(item.rname.indexOf(search_value) !== -1){
          return item;
        }
      })
      // 返回过来后的数组
      this.searchlist = filter_datalist
      this.searchlistlen = filter_datalist.length
      if(this.searchlistlen == 0){
        Toast('还没有相关职位哦！')
      }
      console.log(this.searchlist,this.searchlistlen)
    },
    onCancel() {
      console.log('取消');
    },
    onLoad() {
      setTimeout(() => {
        if (this.refreshing) {
          this.refreshing = false;
        }
        this.loading = false;
        if (this.searchlist.length >= this.searchlist.length) {
          this.finished = true;
        }
      }, 1000);
    }
  },
}
</script>
<style scoped>
.container-box{
  padding-bottom: 50px;
  width: 343px;
  margin: 0 auto;
}
.next{
    width: 2.5rem;
    top:0.1rem;
    text-align: left;
    color:black;
    position: absolute;
    top:1.2rem;
    left: 1rem;
}
.popular-search{
  text-align: left;
}
.popular-search .hot-search{
  display: inline-block;
  font-size: 14px;
}
.popular-search .label-box{
  display: flex;
}
.popular-search .lab-btn{
  font-size: 13px;
  margin-right:10px;
  cursor: pointer;
  padding: 5px 10px;
  border-radius: 24px;
  background-color: #f5f5f5;
}
.hidden{
  display: none;
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

