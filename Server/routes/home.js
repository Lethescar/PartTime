const express=require("express");
const router=express.Router();
const pool=require("../pool");

router.get("/swiper_pic",(req,res)=>{
  var sql="SELECT * FROM swiper_pic";
  pool.query(sql,(err,result)=>{
    if(err){
      throw err;
    }else{
      res.send({code:1,msg:"查询成功",data:result});
    }
  });
})
router.get("/recruit_list",(req,res)=>{
  var typeid = req.query.typeid
  var sql="SELECT * FROM recruit_list where typeid=?";
  pool.query(sql,[typeid],(err,result)=>{
    if(err){
      throw err;
    }else{
      res.send({code:1,msg:"查询成功",data:result});
    }
  });
})
router.get("/recruitlist",(req,res)=>{
  var sql="SELECT * FROM recruit_list";
  pool.query(sql,(err,result)=>{
    if(err){
      throw err;
    }else{
      res.send({code:1,msg:"查询成功",data:result});
    }
  });
})
router.get("/info_label",(req,res)=>{
  var sql="select rlid,lcontent,rname,is_bgcolor from info_label inner join recruit_list on ilid=id";
  pool.query(sql,(err,result)=>{
    if(err){
      throw err;
    }else{
      res.send({code:1,msg:"查询成功",data:result});
    }
  });
})

module.exports=router;