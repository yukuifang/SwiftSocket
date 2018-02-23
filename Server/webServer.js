
const http = require('http');

const socketIO = require('socket.io');

const webServer = http.createServer(function(req,res){
    console.log('客户端http请求');
    res.write('hello');
    res.end();
}).listen(6666);

const serverSocket = socketIO(webServer);

var rooms = [];

var feedbacks = ['呵呵哒','那你很棒棒哦','滚','红包这辈子是不可能','约你妹','']

//TCP三次握手协议（第二次步骤在服务器。第一次步骤和第三次步骤均发生在客户端）
serverSocket.on('connection',function(clientServer){
      console.log('有客户端已经联入');

      //监听客户端聊天事件
      clientServer.on('chat',function(msg){
        console.log(msg.userName + ":" + msg.text);
        serverSocket.emit('msg',feedbacks[Math.floor(Math.random()*(feedbacks.length-1))]);

      })

      //监听客户端进入房间事件
      clientServer.on('joinRoom',function(roomData){
                console.log('进入房间:' + roomData.roomName);

                //将进入的用户根据不同房间名称分组
                clientServer.join(roomData.roomName);

                //保存房间
                for(var i=0;i<rooms.length;i++){
                    let room = rooms[i];
                    if(room.roomName == roomData.roomName){
                        return;
                    }
                }
                rooms.push(roomData);
        });
        //监听客户端离开房间事件
        clientServer.on('leaveRoom',function(roomName){
            console.log('离开房间:' + roomName);
             //将退出的用户移除分组
            clientServer.leave(roomName);
            //移除房间
            var index = rooms.indexOf(roomName);
            if (index > -1) {
                rooms.splice(index, 1);
            }
            

        });

});



 

