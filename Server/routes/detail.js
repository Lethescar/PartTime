const express=require("express");
const router=express.Router();
const pool=require("../pool");

router.get("/detaillist",(req,res)=>{
  var id = req.query.id
  var output={
    recruitlist:[],
    infolabel:[],
    recrequire:[]
  }
	var sql1="select * from recruit_list where id=?";
	pool.query(sql1,[id],(err,result)=>{
    if (err) throw err;
    output.recruitlist=result;
    var sql2="select * from info_label where ilid=?";
    pool.query(sql2,[id],(err,result)=>{
      if (err) throw err;
      output.infolabel=result;
      var sql3="select * from rec_require where rrid=?";
      pool.query(sql3,[id],(err,result)=>{
        if (err) throw err;
        output.recrequire=result;
        res.send(output);
      })
    })
  })
})
router.get("/enterpricedetail",(req,res)=>{
  var name = req.query.name
  var sql="select * from recruit_list where enterprise_name=?";
	pool.query(sql,[name],(err,result)=>{
    if (err) throw err;
    res.send(result)
  })
})
router.get("/issign",(req,res)=>{
  var obj = req.query;
  var sql="insert into sign_list set ? ";
	pool.query(sql,[obj],(err,result)=>{
    if (err)
		{
			throw err;
    }
		if (result.affectedRows>0)
		{
			res.send({code:200});
		}
  })
})
router.get("/sign",(req,res)=>{
  var ild= req.query.ild;
  var sql="select * from sign_list where riid=?";
	pool.query(sql,[ild],(err,result)=>{
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