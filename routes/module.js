var express = require('express');
var router = express.Router();

let functions=function (){
    var socket=io.connect('http://localhost:3000');

    socket.on('restart',function(){alert('Перезапуск')});
    socket.on('relogin',function (){
        alert('Перелогин');
        let Login=document.getElementById('login').value;
        let Pass=document.getElementById('password').value;
        socket.emit('login_data',{
            login:Login,
            password:Pass,
        });
    });

    LoginButton.onclick=function(){
        let Login=document.getElementById('login').value;
        let Pass=document.getElementById('password').value;
        socket.emit('login_data',{
            login:Login,
            password:Pass,
        });
    }
    SendDataButton.onclick=function(){
        let Temperature=document.getElementById('Temperature').value;
        let BelowWaterLevel=document.getElementById('BelowWaterLevel').value;
        let UpperWaterLevel=document.getElementById('UpperWaterLevel').value;
        let visits=document.getElementById('visits').value;
            socket.emit('common_data',{
                temperature:Temperature,
                belowWaterLevel:BelowWaterLevel,
                upperWaterLevel:UpperWaterLevel,
                visits:visits
            });
    }
    SendServiceButton.onclick=function(){
        let user_id=document.getElementById('user_id').value;
        let type=document.getElementById('type').value;
        let message=document.getElementById('message').value;
        socket.emit('service_data',{
            user_id:user_id,
            type:type,
            message:message
        });
    }
};
/* GET users listing. */
router.get('/', function(req, res, next) {

    res.render('module',{functions:`${functions.toString()}`});
});
module.exports = router;
