const express=require("express");
const router=express.Router();
const pool=require("../pool");


router.get("/register",(req,res)=>{
	//1、获取get请求的数据
	var obj = req.query;
	console.log(obj);
	//3、执行SQL语句
	var sql="insert into resume_info set ? ";
	pool.query(sql,[obj],(err,result)=>{
		if (err)
		{
			throw err;
		}
		//console.log(result);
		//如果插入成功
		if (result.affectedRows>0)
		{
			res.send({code:200,msg:'注册成功'});
		}
	});
});

//2、用户登录
router.get("/login",(req,res)=>{
	//6.1:接收网页传递数据 用户名和密码
	var phone = req.query.phone;
	var pwd = req.query.pwd;
	//6.2:创建sql
	var sql = "SELECT * FROM resume_info WHERE iphone = ? AND ipwd = ?";
	//6.3:执行sql语句并且获取返回结果
	pool.query(sql,[phone,pwd],(err,result)=>{
		//6.4:判断登录是否成功
		if(err)throw err;
		//6.5:将结果返回网页
		if(result.length==0){
			console.log(result);
			res.send({code:-1})
		}else{
		  //获取当前登录用户id
			var id=result[0].ild;
			//将用户id保存session对象中
			// id当前登录：用户凭证
			req.session.ild=id;
			console.log(req.session)
			res.send({code:1,ild:id});
		}
	});
})
  
// 验证手机号是否重复
router.get('/vali',(req,res)=>{
	var iphone = req.query.iphone;
	console.log(iphone);
    var sql = 'SELECT * FROM resume_info WHERE iphone = ?'
    pool.query(sql,[iphone],(err,result)=>{
		if(err) throw err;
		console.log(result);
    if(result.length>0){
      res.send({code:0})
    }else{
      res.send({code:1})
    }
  })
})

// 获取个人信息
router.get('/infolist',(req,res)=>{
	var ild = req.query.ild;
	console.log(ild);
    var sql = 'SELECT * FROM resume_info WHERE ild = ?'
    pool.query(sql,[ild],(err,result)=>{
    if(err) throw err;
    else{
      console.log(result);
      res.send(result)
    }
		
  })
})
// 头像上传
router.get('/headicon',(req,res)=>{
	var head_icon = req.query.head_icon;
	var ild = req.query.ild;
	console.log(head_icon);
	var sql = 'update resume_info set head_icon=? where ild=?'
	pool.query(sql,[head_icon,ild],(err,result)=>{
	if(err) throw err;
	console.log(result)
	if(result.affectedRows>0){
		res.send({code:200})
	}
	console.log(result);
  })
})
// 数据更新
router.get('/updata',(req,res)=>{
	var iarea=req.query.iarea;
	var isex=req.query.isex;
	var iage=req.query.iage;
	var iname=req.query.iname;
	var ieducation=req.query.ieducation;
	var ild = req.query.ild;
	var sql = 'update resume_info set iarea=?,isex=?,iage=?,iname=?,ieducation=? where ild=?'
	pool.query(sql,[iarea,isex,iage,iname,ieducation,ild],(err,result)=>{
	if(err) throw err;
	if(result.affectedRows>0){
		res.send({code:200})
	}
	console.log(result);
  })
})

router.get('/sign',(req,res)=>{
	var riid=req.query.ild;
	var output={
    issignlist:[],
		relist:[],
		idlist:[]
	}
	var sql1 = 'SELECT * FROM sign_list WHERE riid = ?'
	pool.query(sql1,[riid],(err,result)=>{
		if(err) throw err;
		output.issignlist = result;
		output.issignlist.forEach(i => {
			output.idlist.push(i.id)
		})
		var sql2 = 'SELECT * FROM recruit_list'
			pool.query(sql2,(err,result)=>{
				if(err) throw err;
				output.relist=result;
				res.send(output)
			})
		})
})
router.get('/msgitem',(req,res)=>{
	var obj=req.query;
	console.log(obj)
	var sql = 'insert into msg_list set ? '
	pool.query(sql,[obj],(err,result)=>{
		if(err) throw err;
		if(result.affectedRows>0){
			res.send({code:200})
		}
  })
})
router.get("/msgarr",(req,res)=>{
  var riid= req.query.riid;
  var sql="select * from msg_list where riid=?";
	pool.query(sql,[riid],(err,result)=>{
    if (err)
		{
			throw err;
    }
    function checkAdult(resdata) {
      return resdata.id == req.query.id;
    }
    res.send(result.filter(checkAdult))
    console.log(result.filter(checkAdult));
  })
})
module.exports=router;