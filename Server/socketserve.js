// 聊天室
var http = require("http").createServer();
var io = require("socket.io")(http)
http.listen(3000)
console.log('服务器启动完成,端口号3000');
var clientcount = 0;
io.on("connection",(socket)=>{
  socket.on('sendMsgToServe',res=>{
    socket.emit('getMsgFromServe',res);
  })
})
