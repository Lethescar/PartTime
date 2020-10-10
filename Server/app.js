//使用express构建web服务器
const express = require('express');
const bodyParser = require('body-parser');
const home=require("./routes/home");
const user=require("./routes/user");
const detail=require("./routes/detail");
const alllist=require("./routes/alllist");
const admin=require("./routes/admin");
const session = require("express-session");
const cors=require("cors");


/*引入路由模块*/
var app = express();

app.use(cors({
  origin:["http://127.0.0.1:8080","http://localhost:8080","http://localhost:8000"],
  credentials:true
}));//从此所有响应，自动带Access-Control-Allow-Origin
//万一客户端浏览器地址发生变化，只改这里origin一处即可！
//配置session
app.use(session({
  secret:"128位字符串",
  resave:true,
  saveUninitialized:true
}));

//使用body-parser中间件
app.use(bodyParser.urlencoded({extended:false}));
//托管静态资源到public目录下
app.use(express.static('public'));
/*使用路由器来管理路由*/
app.use("/home",home);
app.use("/user",user);
app.use("/detail",detail);
app.use("/alllist",alllist);
app.use("/admin",admin);

app.listen(8000);
console.log('服务器启动完成,端口号8000');


