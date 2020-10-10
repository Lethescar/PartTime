<template>
  <div class="container-box">
    <vue-particles
        color="#ffbe85"
        :particleOpacity="0.7"
        :particlesNumber="60"
        shapeType="circle"
        :particleSize="4"
        linesColor="#ffbe85"
        :linesWidth="1"
        :lineLinked="true"
        :lineOpacity="0.4"
        :linesDistance="150"
        :moveSpeed="2"
        :hoverEffect="true"
        hoverMode="grab"
        :clickEffect="true"
        clickMode="push"
        class="grain"
      >
    </vue-particles>
    <div class="loginBox" v-show="adminlogin==0">
      <div class="login-title">
        <p>管理员登录</p>
      </div>
      <div class="login-box">
        <div class="aname">
          <input class="name-input" v-model="aname" placeholder="请输入用户名">
        </div>
        <div class="apwd">
          <input class="pwd-input" v-model="apwd" type="password" placeholder="请输入密码">
        </div>
        <van-button color="linear-gradient(to right, rgb(255, 200, 75), rgb(246, 73, 153))" size="large" @click="login">登录</van-button>
      </div>
    </div>
    <div class="contBox" v-show="adminlogin==1">
      <div class="headerBox">
        <div class="titleBox">
          <span class="title">兼职招聘APP后台管理系统</span>
          <div class="quit" @click="logout">退出</div>
        </div>
      </div>
      <el-tabs tab-position="left" style="height: 90vh;">
        <el-tab-pane label="用户管理">
          <div class="searchBox">
            <input class="searchName" v-model="searchname" placeholder="请输入用户名">
            <div class="searchBtn" @click="onSearchname">搜索</div>
          </div>
          <div class="userlistBox">
            <el-table
              :data="pageTableData"
              style="width: 100%">
              <el-table-column type="expand">
                <template slot-scope="props">
                  <el-form label-position="left" inline class="demo-table-expand">
                    <el-form-item label="姓名">
                      <span>{{ props.row.iname == null ? "未填写" : props.row.iname }}</span>
                    </el-form-item>
                    <el-form-item label="年龄">
                      <span>{{ props.row.iage == null ? 0 : props.row.iage }}</span>
                    </el-form-item>
                    <el-form-item label="所在地区">
                      <span>{{ props.row.iarea == null ? "未填写" : props.row.iarea }}</span>
                    </el-form-item>
                    <el-form-item label="手机号">
                      <span>{{ props.row.iphone }}</span>
                    </el-form-item>
                    <el-form-item label="学校">
                      <span>{{ props.row.ischool == null ? "未填写" : props.row.ischool }}</span>
                    </el-form-item>
                    <el-form-item label="专业">
                      <span>{{ props.row.imajor == null ? "未填写" : props.row.imajor }}</span>
                    </el-form-item>
                    <el-form-item label="学历">
                      <span>{{ props.row.ieducation == null ? "未填写" : props.row.ieducation }}</span>
                    </el-form-item>
                  </el-form>
                </template>
              </el-table-column>
              <el-table-column label="姓名" prop="iname" width="180" min-width="140" :formatter="formatname"></el-table-column>
              <el-table-column label="年龄" prop="iage" width="180" min-width="140" :formatter="formatage"></el-table-column>
              <el-table-column label="所在地区" prop="iarea" min-width="160" :formatter="formatarea"></el-table-column>
              <el-table-column label="手机号" prop="iphone" min-width="160"></el-table-column>
              <el-table-column label="操作" width="160" min-width="160">
                <template slot-scope="scope">
                  <el-button
                    size="mini"
                    @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                  <el-button
                    size="mini"
                    type="danger"
                    @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                </template>
              </el-table-column>
            </el-table>
            <el-pagination
              @size-change="handleSizeChange"
              @current-change="handleCurrentChange"
              :page-sizes="[10, 20, 50, 100]"
              :page-size="10"
              layout="total, sizes, prev, pager, next, jumper"
              :total="totalnum">
            </el-pagination>
            <el-dialog title="修改信息" :visible.sync="dialogFormVisible">
              <el-form :model="form">
                <el-form-item label="姓名" :label-width="formLabelWidth">
                  <el-input v-model="form.iname" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="年龄" :label-width="formLabelWidth">
                  <el-input v-model="form.iage" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="所在地区" :label-width="formLabelWidth">
                  <el-input v-model="form.iarea" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="手机号" :label-width="formLabelWidth">
                  <el-input v-model="form.iphone" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="学校" :label-width="formLabelWidth">
                  <el-input v-model="form.ischool" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="专业" :label-width="formLabelWidth">
                  <el-input v-model="form.imajor" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="学历" :label-width="formLabelWidth">
                  <el-input v-model="form.ieducation" autocomplete="off"></el-input>
                </el-form-item>
              </el-form>
              <div slot="footer" class="dialog-footer">
                <el-button @click="onCancel">取 消</el-button>
                <el-button type="primary" @click="onDefine">确 定</el-button>
              </div>
            </el-dialog>
          </div>
        </el-tab-pane>
        <el-tab-pane label="兼职管理">
          <div class="searchBox">
            <input class="searchName" v-model="searchpost" placeholder="请输入职位名称">
            <div class="searchBtn" @click="onSearchpost">搜索</div>
            <div class="addBtn" @click="addPost">添加职位</div>
          </div>
          <div class="userlistBox">
            <el-table
              :data="pageTableDataPost"
              style="width: 100%">
              <el-table-column type="expand">
                <template slot-scope="props">
                  <el-form label-position="left" inline class="demo-table-expand">
                    <el-form-item label="职位名称">
                      <span>{{ props.row.rname == null ? "未填写" : props.row.rname }}</span>
                    </el-form-item>
                    <el-form-item label="企业名称">
                      <span>{{ props.row.enterprise_name == null ? 0 : props.row.enterprise_name }}</span>
                    </el-form-item>
                    <el-form-item label="所在地区">
                      <span>{{ props.row.area == null ? "未填写" : props.row.area }}</span>
                    </el-form-item>
                    <el-form-item label="工资">
                      <span>{{ props.row.rsalary == null ? "未填写" : props.row.rsalary }}</span>
                    </el-form-item>
                    <el-form-item label="职位类型">
                      <span>{{ props.row.work_type == null ? "未填写" : props.row.work_type }}</span>
                    </el-form-item>
                    <el-form-item label="开始时间">
                      <span>{{ props.row.start_time == null ? "未填写" : props.row.start_time }}</span>
                    </el-form-item>
                    <el-form-item label="结束时间">
                      <span>{{ props.row.end_time == null ? "未填写" : props.row.end_time }}</span>
                    </el-form-item>
                  </el-form>
                </template>
              </el-table-column>
              <el-table-column label="职位名称" prop="rname" width="300" min-width="280" :formatter="formatnamepost"></el-table-column>
              <el-table-column label="企业名称" prop="enterprise_name" width="240" min-width="220" :formatter="formatagepost"></el-table-column>
              <el-table-column label="所在地区" prop="area" min-width="160" :formatter="formatareapost"></el-table-column>
              <el-table-column label="工资" prop="rsalary" min-width="160" :formatter="formatsalarypost"></el-table-column>
              <el-table-column label="操作" width="160" min-width="160">
                <template slot-scope="scopepost">
                  <el-button
                    size="mini"
                    @click="handleEditPost(scopepost.$index, scopepost.row)">编辑</el-button>
                  <el-button
                    size="mini"
                    type="danger"
                    @click="handleDeletePost(scopepost.$index, scopepost.row)">删除</el-button>
                </template>
              </el-table-column>
            </el-table>
            <el-pagination
              @size-change="handleSizeChangePost"
              @current-change="handleCurrentChangePost"
              :page-sizes="[10, 20, 50, 100]"
              :page-size="10"
              layout="total, sizes, prev, pager, next, jumper"
              :total="totalnumpost">
            </el-pagination>
            <el-dialog title="修改信息" :visible.sync="dialogFormVisiblePost">
              <el-form :model="formpost">
                <el-form-item label="职位名称" :label-width="formLabelWidth">
                  <el-input v-model="formpost.rname" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="企业名称" :label-width="formLabelWidth">
                  <el-input v-model="formpost.enterprise_name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="所在地区" :label-width="formLabelWidth">
                  <el-input v-model="formpost.area" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="工资" :label-width="formLabelWidth">
                  <el-input v-model="formpost.rsalary" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="职位类型" :label-width="formLabelWidth">
                  <el-input v-model="formpost.work_type" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="开始时间" :label-width="formLabelWidth">
                  <el-input v-model="formpost.start_time" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="结束时间" :label-width="formLabelWidth">
                  <el-input v-model="formpost.end_time" autocomplete="off"></el-input>
                </el-form-item>
              </el-form>
              <div slot="footer" class="dialog-footer">
                <el-button @click="onCancelPost">取 消</el-button>
                <el-button type="primary" @click="onDefinePost">确 定</el-button>
              </div>
            </el-dialog>
            <el-dialog title="修改信息" :visible.sync="dialogFormVisibleAdd">
              <el-form :model="formadd">
                <el-form-item label="职位编号" :label-width="formLabelWidth">
                  <el-input disabled v-model="formadd.id" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="职位名称" :label-width="formLabelWidth">
                  <el-input v-model="formadd.rname" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="企业名称" :label-width="formLabelWidth">
                  <el-input v-model="formadd.enterprise_name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="所在地区" :label-width="formLabelWidth">
                  <el-input v-model="formadd.area" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="工资" :label-width="formLabelWidth">
                  <el-input v-model="formadd.rsalary" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="工资结算期限" :label-width="formLabelWidth">
                  <el-input v-model="formadd.salary_term" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="职位详情" :label-width="formLabelWidth">
                  <el-input type="textarea" autosize v-model="formadd.position_detail" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="企业联系人" :label-width="formLabelWidth">
                  <el-input v-model="formadd.contacts" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="职位类型" :label-width="formLabelWidth">
                  <el-input v-model="formadd.work_type" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="开始时间" :label-width="formLabelWidth">
                  <el-input v-model="formadd.start_time" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="结束时间" :label-width="formLabelWidth">
                  <el-input v-model="formadd.end_time" autocomplete="off"></el-input>
                </el-form-item>
              </el-form>
              <div slot="footer" class="dialog-footer">
                <el-button @click="onCancelAdd">取 消</el-button>
                <el-button type="primary" @click="onDefineAdd">确 定</el-button>
              </div>
            </el-dialog>
          </div>
        </el-tab-pane>
        <el-tab-pane label="消息管理" class="infoBox">
          <div class="searchBox">
            <input class="searchName" v-model="searchpost" placeholder="请输入职位名称">
            <div class="searchBtn" @click="onSearchpost">搜索</div>
          </div>
          <div class="userlistBox">
            <el-table
              :data="pageTableDataPost"
              style="width: 100%">
              <el-table-column type="expand">
                <template slot-scope="props">
                  <el-form label-position="left" inline class="demo-table-expand">
                    <el-form-item label="职位名称">
                      <span>{{ props.row.rname == null ? "未填写" : props.row.rname }}</span>
                    </el-form-item>
                    <el-form-item label="企业名称">
                      <span>{{ props.row.enterprise_name == null ? 0 : props.row.enterprise_name }}</span>
                    </el-form-item>
                    <el-form-item label="所在地区">
                      <span>{{ props.row.area == null ? "未填写" : props.row.area }}</span>
                    </el-form-item>
                    <el-form-item label="工资">
                      <span>{{ props.row.rsalary == null ? "未填写" : props.row.rsalary }}</span>
                    </el-form-item>
                    <el-form-item label="职位类型">
                      <span>{{ props.row.work_type == null ? "未填写" : props.row.work_type }}</span>
                    </el-form-item>
                    <el-form-item label="开始时间">
                      <span>{{ props.row.start_time == null ? "未填写" : props.row.start_time }}</span>
                    </el-form-item>
                    <el-form-item label="结束时间">
                      <span>{{ props.row.end_time == null ? "未填写" : props.row.end_time }}</span>
                    </el-form-item>
                  </el-form>
                </template>
              </el-table-column>
              <el-table-column label="职位名称" prop="rname" width="300" min-width="280" :formatter="formatnamepost"></el-table-column>
              <el-table-column label="企业名称" prop="enterprise_name" width="240" min-width="220" :formatter="formatagepost"></el-table-column>
              <el-table-column label="所在地区" prop="area" min-width="160" :formatter="formatareapost"></el-table-column>
              <el-table-column label="工资" prop="rsalary" min-width="160" :formatter="formatsalarypost"></el-table-column>
              <el-table-column label="操作" width="160" min-width="160">
                <template slot-scope="scopemsg">
                  <el-button size="mini" @click="handleEditmsg(scopemsg.$index, scopemsg.row)">消息</el-button>
                </template>
              </el-table-column>
            </el-table>
            <el-pagination
              @size-change="handleSizeChangePost"
              @current-change="handleCurrentChangePost"
              :page-sizes="[10, 20, 50, 100]"
              :page-size="10"
              layout="total, sizes, prev, pager, next, jumper"
              :total="totalnumpost">
            </el-pagination>
            <el-dialog title="消息" :visible.sync="dialogFormVisibleMsg">
              <el-tabs tab-position="left" class="minheight" @tab-click="handleClick">
                <el-tab-pane :label="item.iname" v-for="(item,index) in tableData" :key="index">
                  <div class="chatbottom-box">
                    <textarea cols="30" rows="3" class="chatinput" v-model="msg"></textarea>
                    <a href="javascript:;" class="chatsend" @click="sendMsg">发送</a>
                  </div>
                  <div class="chatcontainer">
                    <ul class="msgbox">
                      <li class="msgitem" v-for="(msg,index) in msgarr" :key="index">
                        <div style="line-height: 45px;" v-if="msg.isenterprise==1">企业回复：</div>
                        <div class="person-icon" v-else :style="item.head_icon==null ? 'background-color: darkgrey;' : {backgroundImage:'url('+'http://127.0.0.1:8000'+item.head_icon+')'}"></div>
                        <div class="msg" :style="{'background':rgb()}" v-text="msg.msg"></div>
                      </li>
                    </ul>
                  </div>
                </el-tab-pane>
              </el-tabs>
            </el-dialog>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>
<script>
export default {
  inject:['reload'],
  data() {
    return {
      aname:'',
      apwd:'',
      msgname:'',
      searchname: '',
      searchpost:'',
      adminlogin:0,
      totalnum: 0,
      totalnumpost: 0,
      tableData: [],
      tableDatapost:[],
      pageTableData:[],
      pageTableDataPost:[],
      dialogFormVisible: false,
      dialogFormVisiblePost: false,
      dialogFormVisibleAdd: false,
      dialogFormVisibleMsg: false,
      count:10,
      pno:1,
      postcount: 0 ,
      form:{
        iname:'',
        iage:'',
        iarea:'',
        iphone:'',
        ischool:'',
        imajor:'',
        ieducation:'',
      },
      formpost:{
        rname:'',
        enterprise_name:'',
        area:'',
        rsalary:'',
        work_type:'',
        start_time:'',
        end_time:'',
      },
      formadd:{
        id:'',
        rname:'',
        enterprise_name:'',
        area:'',
        rsalary:'',
        work_type:'',
        start_time:'',
        end_time:'',
        contacts:'',
        position_detail:'',
        salary_term:''
      },
      rowitem:[],
      rowitemPost:[],
      rowitemMsg:[],
      formLabelWidth: '120px',
      msg:'',
      msgarr:[],
      ild:'',
      isenterprise:1
    };
  },
  created() {
    this.isadminlogin();
    this.gettableData();
    this.gettableDataPost();
    this.getpagelist();
    this.getpagelistpost();
    this.getmsgarr();
  },
  methods: {
    login(){
      var aname=this.aname;
      var apwd=this.apwd;
      var url="admin/login";
      (async ()=>{
        var res=await this.axios.get(
          url,
          {params:{aname:aname,apwd:apwd}}
        );
        var code=res.data.code;
        if (code==-1) {
          this.$message.error('账号或密码不正确');
        } else {
          localStorage.setItem('adminlogin',res.data.code);
          localStorage.setItem('adminid',res.data.aid)
          var adminlogin=localStorage.getItem('adminlogin');
          if(adminlogin){
            this.adminlogin=1;
          }
          setTimeout(() => {
              this.$router.push(`/admin`)
          }, 1000);
          this.$message({
            message: '登录成功',
            type: 'success'
          });
        }
      })();
    },
    isadminlogin(){
      var adminlogin=localStorage.getItem('adminlogin');
      if(adminlogin){
        this.adminlogin = adminlogin;
      }
    },
    logout(){
      localStorage.removeItem('adminid');
      localStorage.removeItem('adminlogin');
      this.adminlogin=0;
    },
    addPost(){
      this.dialogFormVisibleAdd = true;
    },
    rgb(){
      var r = Math.floor(Math.random()*256);
      var g = Math.floor(Math.random()*256);
      var b = Math.floor(Math.random()*256);
      return `rgb(${r},${g},${b},0.30)`
    },
    formatname(row, column){
      return row.iname == null ? "未填写" : row.iname;
    },
    formatnamepost(row, column){
      return row.rname == null ? "未填写" : row.rname;
    },
    formatage(row, column){
      return row.enterprise_name == null ? 0 : row.enterprise_name;
    },
    formatagepost(row, column){
      return row.enterprise_name == null ? 0 : row.enterprise_name;
    },
    formatarea(row, column){
      return row.iarea == null ? "未填写" : row.iarea;
    },
    formatareapost(row, column){
      return row.area == null ? "未填写" : row.area;
    },
    formatsalarypost(row, column){
      return row.rsalary == null ? "未填写" : row.rsalary;
    },
    handleOpen(key, keyPath) {
      console.log(key, keyPath);
    },
    handleClose(key, keyPath) {
      console.log(key, keyPath);
    },
    handleEdit(index, row) {
      this.dialogFormVisible=true;
      var iname = row.iname == null ? "未填写" : row.iname;
      var iage = row.iage == null ? 0 : row.iage;
      var iarea = row.iarea == null ? "未填写" : row.iarea;
      var ieducation = row.ieducation == null ? "未填写" : row.ieducation;
      var ischool = row.ischool == null ? "未填写" : row.ischool;
      var imajor = row.imajor == null ? "未填写" : row.imajor;
      this.form.iname = iname;
      this.form.iage = iage;
      this.form.iarea = iarea;
      this.form.ieducation = ieducation;
      this.form.iphone = row.iphone;
      this.form.ischool = ischool;
      this.form.imajor = imajor;
      this.rowitem = row;
    },
    handleEditPost(index, row) {
      this.dialogFormVisiblePost=true;
      var rname = row.rname == null ? "未填写" : row.rname;
      var enterprise_name = row.enterprise_name == null ? 0 : row.enterprise_name;
      var area = row.area == null ? "未填写" : row.area;
      var rsalary = row.rsalary == null ? "未填写" : row.rsalary;
      var work_type = row.work_type == null ? "未填写" : row.work_type;
      var start_time = row.start_time == null ? "未填写" : row.start_time;
      var end_time = row.end_time == null ? "未填写" : row.end_time;
      this.formpost.rname = rname;
      this.formpost.enterprise_name = enterprise_name;
      this.formpost.area = area;
      this.formpost.rsalary = rsalary;
      this.formpost.work_type = work_type;
      this.formpost.start_time = start_time;
      this.formpost.end_time = end_time;
      this.rowitemPost = row;
    },
    handleEditmsg(index, row){
      this.dialogFormVisibleMsg=true;
      this.msgname=this.tableData[0].iname;
      this.ild = this.tableData[0].ild;
      console.log('ild',this.ild);
      this.rowitemMsg = row;
      this.getmsgarr();
    },
    onCancel(){
      this.dialogFormVisible=false;
    },
    onCancelPost(){
      this.dialogFormVisiblePost=false;
    },
    onCancelAdd(){
      this.dialogFormVisibleAdd=false;
    },
    onDefine(){
      var ild=this.rowitem.ild;
      var iname = this.form.iname;
      var iage = this.form.iage;
      var iarea = this.form.iarea;
      var ieducation = this.form.ieducation;
      var iphone = this.form.iphone;
      var ischool = this.form.ischool;
      var imajor = this.form.imajor;
      var url='admin/updata';
      (async ()=>{
        var result=await this.axios.get(
          url,
          {
            params:
            {
              iage:iage,
              iname:iname,
              iarea:iarea,
              ieducation:ieducation,
              iphone:iphone,
              ischool:ischool,
              imajor:imajor,
              ild:ild
            }
          }
        );
        if (result.data.code==200) {
          this.$message.success('修改成功');
          this.dialogFormVisible=false;
        }
      })();
      this.reload();
    },
    onDefinePost(){
      var rname=this.formpost.rname;
      var enterprise_name=this.formpost.enterprise_name;
      var area=this.formpost.area;
      var rsalary=this.formpost.rsalary;
      var work_type=this.formpost.work_type;
      var start_time=this.formpost.start_time;
      var end_time=this.formpost.end_time;
      var rlid=this.rowitemPost.rlid;
      var url='admin/updatapost';
      (async ()=>{
        var result=await this.axios.get(
          url,
          {
            params:
            {
              rname:rname,
              enterprise_name:enterprise_name,
              area:area,
              rsalary:rsalary,
              work_type:work_type,
              start_time:start_time,
              end_time:end_time,
              rlid:rlid
            }
          }
        );
        if (result.data.code==200) {
          this.$message.success('修改成功');
          this.dialogFormVisiblePost=false;
        }else{
          this.$message.error('修改失败');
          this.dialogFormVisiblePost=true;
        }
      })();
      this.reload();
    },
    onDefineAdd(){
      var id = this.formadd.id;
      var rname=this.formadd.rname;
      var enterprise_name=this.formadd.enterprise_name;
      var area=this.formadd.area;
      var rsalary=this.formadd.rsalary;
      var salary_term = this.formadd.salary_term;
      var position_detail = this.formadd.position_detail;
      var contacts = this.formadd.contacts;
      var work_type=this.formadd.work_type;
      var start_time=this.formadd.start_time;
      var end_time=this.formadd.end_time;
      var url='admin/addpost';
      (async ()=>{
        var result=await this.axios.get(
          url,
          {
            params:
            {
              id:id,
              rname:rname,
              enterprise_name:enterprise_name,
              area:area,
              rsalary:rsalary,
              work_type:work_type,
              start_time:start_time,
              end_time:end_time,
              salary_term:salary_term,
              position_detail:position_detail,
              contacts:contacts
            }
          }
        );
        if (result.data.code==200) {
          this.$message.success('添加成功');
          this.dialogFormVisiblePost=false;
        }else{
          this.$message.error('添加失败');
          this.dialogFormVisiblePost=true;
        }
      })();
      this.reload();
    },
    handleDelete(index, row) {
      var url="admin/delete";
      (async ()=>{
        var res=await this.axios.get(
          url,
          {params:{ild:row.ild}}
        );
        if(res.data.code==200){
          this.$message.success('删除成功');
        }else{
          this.$message.error('删除失败');
        }
      })();
      this.reload();
    },
    handleDeletePost(index, row) {
      var url="admin/deletepost";
      (async ()=>{
        var res=await this.axios.get(
          url,
          {params:{rlid:row.rlid}}
        );
        if(res.data.code==200){
          this.$message.success('删除成功');
        }else{
          this.$message.error('删除失败');
        }
      })();
      this.reload();
    },
    handleSizeChange(val) {
      this.count = val;
      this.getpagelist();
      // console.log(`每页 ${val} 条`);
    },
    handleSizeChangePost(val){
      this.count = val;
      this.getpagelistpost();
    },
    handleCurrentChange(val) {
      this.pno = val;
      this.getpagelist();
      // console.log(`当前页: ${val}`);
    },
    handleCurrentChangePost(val) {
      this.pno = val;
      this.getpagelistpost();
    },
    // 用户搜索
    onSearchname(){
      var filterList = this.tableData
      var searchValue = this.searchname;
      if(!searchValue){
        return filterList;
      }
      filterList = filterList.filter(function(item){
        if(item.iname == searchValue){
          return item;
        }
      })
      // 返回过来后的数组
      this.pageTableData = filterList
    },
    // 职位搜索
    onSearchpost(){
      var filterList = this.tableDatapost;
      var searchValue = this.searchpost;
      console.log(searchValue);
      if(searchValue==null){
        return filterList;
      }else{
        filterList = filterList.filter(function(item){
          if(item.rname.indexOf(searchValue) !== -1){
            return item;
          }
        })
      }
      // 返回过来后的数组
      this.pageTableDataPost = filterList
    },
    // 用户分页
    getpagelist(){
      var count = this.count;
      var pno = this.pno;
      var url="admin/list";
      (async ()=>{
        var res=await this.axios.get(
          url,
          {params:{count:count,pno:pno}}
        );
        this.pageTableData = res.data;
      })();
    },
    // 职位分页
    getpagelistpost(){
      var count = this.count;
      var pno = this.pno;
      var url="admin/listpost";
      (async ()=>{
        var res=await this.axios.get(
          url,
          {params:{count:count,pno:pno}}
        );
        this.pageTableDataPost = res.data;
      })();
    },
    // 用户信息
    gettableData(){
      var url="admin/tabledata";
      (async ()=>{
        var res=await this.axios.get(
          url,
        );
        this.tableData = res.data;
        this.totalnum = res.data.length;
      })();
    },
    // 职位信息
    gettableDataPost(){
      var url="admin/tabledatapost";
      (async ()=>{
        var res=await this.axios.get(
          url,
        );
        this.tableDatapost = res.data;
        this.totalnumpost = res.data.length;
        this.formadd.id = new Date().getTime();
      })();
    },
    handleClick(tab, event) {
      this.msgname = tab.label;
      console.log(tab.label);
      var filterList = this.tableData
      var searchValue = this.msgname;
      if(!searchValue){
        return filterList;
      }
      filterList = filterList.filter(function(item){
        if(item.iname == searchValue){
          return item;
        }
      })
      // 返回过来后的数组
      this.ild = filterList[0].ild;
      console.log('ild',filterList[0].ild);
      this.getmsgarr();
    },
    sendMsg(){
      var socket = io("ws://127.0.0.1:3000");
      socket.emit('sendMsgToServe',{
        msg:this.msg
      })
      this.msg='';
      socket.on('getMsgFromServe',msgObj=>{
        this.msgarr.push(msgObj)
        var riid=this.ild;
        var id=this.rowitemMsg.id;
        var isenterprise = 1;
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
      var riid=this.ild;
      console.log('getmsgarr',riid);
      (async ()=>{
        var result=await this.axios.get(
          url,
          {params:{riid:riid,id:this.rowitemMsg.id}}
        );
        console.log(result.data);
        this.msgarr = result.data;
        console.log('msgarr',this.msgarr);
      })();
    },
  }
}
</script>
<style scoped>
.grain{
  position: absolute;
  width: 100%;
  height: 99vh;
}
.container-box {
  width: 100%;
  margin-right: auto;
  margin-left: auto;
}
.container-box .iconSize{
  font-size: 30px;
  height: 96vh;
}
.container-box .el-menu-vertical-demo{
  height: 100vh;
}
.loginBox{
  margin: auto;
  width: 20%;
  min-width: 460px;
  position:absolute;
  left:50%; top:45%;
  transform:translate(-50%,-50%);
  display: inline-table;
  box-shadow: -15px 15px 15px rgba(253, 217, 176, 0.7);
  background: linear-gradient(230deg, rgba(185, 255, 249, 0.44) 0%, rgb(243, 210, 187) 100%);
  padding: 100px 40px 40px 40px;
}
.loginBox .login-title{
  margin: 0;
  text-align: center;
}
.loginBox .login-title p{
  font-size: 30px;
  font-weight: bold;
  color: orange;
}
.login-box{
  margin-top: 50px;
}
.aname,.apwd{
  border-bottom: 1px solid #eee;
  margin-bottom: 50px;
}
.name-input,.pwd-input{
  width: 100%;
  height: 45px;
  padding: 0 10px;
  border: unset;
  background-color: #fff0f000;
}
.container-box .headerBox{
  width: 100%;
  height: 10vh;
  background-image: linear-gradient(to right,rgba(58, 55, 248, 0.3),rgba(255, 201, 75,0.30));
}
.container-box .headerBox .titleBox{
  display: flex;
  justify-content: space-between;
}
.container-box .headerBox .titleBox .title{
  font-size:25px;
  line-height: 10vh;
  margin-left: 70px;
}
.container-box .headerBox .titleBox .quit{
  line-height: 10vh;
  font-size: 20px;
  margin-right: 70px;
  cursor: pointer;
  z-index: 999;
}
.searchBox{
  margin: 10px auto 10px auto;
  /* text-align: center; */
  justify-content: center;
  display: flex;
}
.searchBox .searchName{
  width: 30%;
  height: 48px;
  padding: 0 10px;
  border-radius: 5px;
  border: 1px solid #eee;
}
.searchBox .searchBtn{
  line-height: 48px;
  margin-left: 15px;
  width: 65px;
  background-color: bisque;
  text-align: center;
  border-radius: 10px;
  cursor: pointer;
}
.searchBox .searchBtn:active{
  background-color: rgb(255, 210, 155);
}
.addBtn{
  line-height: 48px;
  margin-left: 15px;
  width: 100px;
  background-color: bisque;
  text-align: center;
  border-radius: 10px;
  cursor: pointer;
}
.addBtn:active{
  background-color: rgb(255, 210, 155);
}
.userlistBox{
  margin: 10px 20px;
}
.demo-table-expand {
  font-size: 0;
}
.demo-table-expand label {
  width: 90px;
  color: #99a9bf;
}
.demo-table-expand .el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 50%;
}
.infoBox .chatbottom-box{
  position: fixed;
  top: 72vh;
  margin-bottom: 41px;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  height: 40px;
  background-color: #fff;
  margin: 10px 1.2rem;
  width: 34vw;
}
.infoBox .chatinput{
  width: 80%;
  background: none;
  outline: none;
  border: 1px solid orange;
  border-radius: 20px;
  padding: 8px 15px 0 15px;
  resize:none;
  overflow:hidden;
}
.infoBox .chatsend{
  width: 20%;
  line-height: 40px;
  display: inline-block;
  background-color: wheat;
  background-image: unset;
  border-radius: 20px;
  text-decoration: none;
  color: tomato;
  text-align: center;
}
.infoBox .chatsend:active{
  background-image: linear-gradient(to right, rgb(255, 200, 75,0.80), rgb(246, 73, 153,0.80));
}
.infoBox .msgitem{
  display: flex;
}
.infoBox .msgitem .person-icon{
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-size: cover;
  background-repeat: no-repeat;
}
.infoBox .msgitem .msg{
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
<style>
.container-box .el-tabs__nav-wrap::after{
  content:unset;
}
.container-box .el-tabs__header{
  background-image: linear-gradient(to bottom,rgba(58, 55, 248, 0.3),rgba(255, 201, 75,0.30));
  width: 200px;
}
.container-box .el-tabs__active-bar{
  background-color: orange;
}
.container-box .el-tabs__item:hover {
  color: #ffffff;
}
.container-box .el-tabs__item.is-active {
  color: #ffffff;
}
.container-box .el-tabs--left .el-tabs__item.is-left {
  text-align: center;
}
.container-box .el-tabs__item{
  font-size: 18px;
  height: 60px;
  line-height: 60px;
}
.userlistBox .el-pagination{
  position: absolute;
  bottom: 20px;
  left:50%;
  transform:translate(-50%,0);
}
.contBox .el-tabs__content{
  height: 88vh;
}
.contBox .el-form-item__content{
  margin: 0 50px;
}
.infoBox .minheight{
  min-height: 50vh;
  max-height: 55vh;
}
.infoBox .el-tabs__content{
  height: unset;
}
.infoBox .el-tabs__header{
  background-color: wheat;
  background-image: unset;
  width: 150px;
  min-height: 50vh;
}
.infoBox .el-tabs--left{
  overflow-y: auto;
}
.infoBox .el-tabs--left::-webkit-scrollbar{
  width: 2px;
}
</style>