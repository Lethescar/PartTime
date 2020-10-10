const express=require("express");
const router=express.Router();
const pool=require("../pool");

router.get("/recruit_list",(req,res)=>{
  var sql="SELECT * FROM recruit_list";
  pool.query(sql,(err,result)=>{
    if(err){
      throw err;
    }else{
      res.send({code:1,msg:"查询成功",data:result});
    }
  });
})
router.get('/list',function(req,res){
	//5.1获取get请求的数据
	var obj=req.query;
	//5.2验证是否为空，为空的话设置默认值
  var pno=obj.pno;
  console.log(pno)
	if (!pno) pno=1;
	//5.3将值转为整型
	pno=parseInt(pno);
	//5.4计算开始的值=（页码-1）*大小
	var start=(pno-1)*5;
	//5.5执行SQL语句
	pool.query('select * from recruit_list limit ?,5',[start],function(err,result){
		if (err)
		{
			throw err;
		}
    res.send(result);
    console.log(result)
	});
});
router.get("/typelist",(req,res)=>{
  var obj = req.query.work_type
  // console.log(req.query.work_type)
  var sql="select * from recruit_list where work_type=?";
  pool.query(sql,[obj],(err,result)=>{
      if(err){
        throw err;
      }else{
        res.send({data:result});
      }
  });
})
router.get("/arealist",(req,res)=>{
  var obj = req.query.area
  var sql="select * from recruit_list where area=?";
  pool.query(sql,[obj],(err,result)=>{
      if(err){
        throw err;
      }else{
        res.send({data:result});
      }
  });
})
  
module.exports=router;