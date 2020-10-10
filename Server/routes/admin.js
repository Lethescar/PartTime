const express=require("express");
const router=express.Router();
const pool=require("../pool");

//用户登录
router.get("/login",(req,res)=>{
  //6.1:接收网页传递数据 用户名和密码
  console.log(req.query);
	var aname = req.query.aname;
  var apwd = req.query.apwd;
  console.log(aname);
  console.log(apwd);
	//6.2:创建sql
	var sql = "SELECT * FROM admin_list WHERE aname = ? AND apwd = ?";
	//6.3:执行sql语句并且获取返回结果
	pool.query(sql,[aname,apwd],(err,result)=>{
		//6.4:判断登录是否成功
		if(err)throw err;
		//6.5:将结果返回网页
		if(result.length==0){
			console.log(result);
			res.send({code:-1})
		}else{
		  //获取当前登录用户id
			var aid=result[0].id;
			//将用户id保存session对象中
			// id当前登录：用户凭证
			req.session.aid=aid;
			console.log(req.session)
			res.send({code:1,aid:aid});
		}
	});
})
router.get("/addpost",(req,res)=>{
	var obj=req.query;
	pool.query('insert into recruit_list set ?',[obj],function(err,result){
		if (err) throw err;
		if (result.affectedRows>0)
		{
			res.send({code:200});
		}
	});
})
router.get("/tabledata",(req,res)=>{
	var sql = "SELECT * FROM resume_info";
	pool.query(sql,(err,result)=>{
		if(err)throw err;
		res.send(result);
	});
})
router.get("/tabledatapost",(req,res)=>{
	var sql = "SELECT * FROM recruit_list";
	pool.query(sql,(err,result)=>{
		if(err)throw err;
		res.send(result);
	});
})
router.get("/delete",(req,res)=>{
  var ild = req.query.ild;
	var sql = "delete FROM resume_info where ild = ?";
	pool.query(sql,[ild],(err,result)=>{
		if(err)throw err;
		if (result.affectedRows>0)
		{
			res.send({code:200});
		}else{
			res.send({code:201});
		}
	});
})
router.get("/deletepost",(req,res)=>{
  var rlid = req.query.rlid;
	var sql = "delete FROM recruit_list where rlid = ?";
	pool.query(sql,[rlid],(err,result)=>{
		if(err)throw err;
		if (result.affectedRows>0)
		{
			res.send({code:200});
		}else{
			res.send({code:201});
		}
	});
})
router.get('/updata',(req,res)=>{
	var	iage=req.query.iage;
	var	iname=req.query.iname;
	var	iarea=req.query.iarea;
	var	ieducation=req.query.ieducation;
	var	iphone=req.query.iphone;
	var	ischool=req.query.ischool;
	var	imajor=req.query.imajor;
	var ild=req.query.ild;
	var sql = 'update resume_info set iage=?,iname=?,iarea=?,ieducation=?,iphone=?,ischool=?,imajor=? where ild=?'
	pool.query(sql,[iage,iname,iarea,ieducation,iphone,ischool,imajor,ild],(err,result)=>{
		if(err) throw err;
		if(result.affectedRows>0){
			res.send({code:200})
		}
  })
})
router.get('/updatapost',(req,res)=>{
	var	rname=req.query.rname;
	var	enterprise_name=req.query.enterprise_name;
	var	area=req.query.area;
	var	rsalary=req.query.rsalary;
	var	work_type=req.query.work_type;
	var	start_time=req.query.start_time;
	var	end_time=req.query.end_time;
	var rlid=req.query.rlid;
	var sql = 'update recruit_list set rname=?,enterprise_name=?,area=?,rsalary=?,work_type=?,start_time=?,end_time=? where rlid=?'
	pool.query(sql,[rname,enterprise_name,area,rsalary,work_type,start_time,end_time,rlid],(err,result)=>{
		if(err) throw err;
		if(result.affectedRows>0){
			console.log('成功')
			res.send({code:200})
		}
  })
})
router.get('/list',function(req,res){
	var count=req.query.count;
	var pno=req.query.pno;
	if (!count) count=10;
	if (!pno) pno=1;
	//将值转为整型
	count=parseInt(count);
	pno=parseInt(pno);
	//计算开始的值=（页码-1）*大小
	var start=(pno-1)*count;
	//执行SQL语句
	var sql = "SELECT * FROM resume_info limit ?,?";
	pool.query(sql,[start,count],(err,result)=>{
		if(err)throw err;
		res.send(result);
	});
});
router.get('/listpost',function(req,res){
	var count=req.query.count;
	var pno=req.query.pno;
	if (!count) count=10;
	if (!pno) pno=1;
	//将值转为整型
	count=parseInt(count);
	pno=parseInt(pno);
	//计算开始的值=（页码-1）*大小
	var start=(pno-1)*count;
	//执行SQL语句
	var sql = "SELECT * FROM recruit_list limit ?,?";
	pool.query(sql,[start,count],(err,result)=>{
		if(err)throw err;
		res.send(result);
	});
});
module.exports=router;