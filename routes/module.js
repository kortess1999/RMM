var express = require('express');
var router = express.Router();

let functions=function (){
    var socket=io.connect('http://localhost:3000');
    SendDataButton.onclick=function(){
        let Temperature=document.getElementById('Temperature').value;
        let BelowWaterLevel=document.getElementById('BelowWaterLevel').value;
        let UpperWaterLevel=document.getElementById('UpperWaterLevel').value;
            socket.emit('common_data',{
                temperature:Temperature,
                belowWaterLevel:BelowWaterLevel,
                upperWaterLevel:UpperWaterLevel
            });
    }
    SendPaymentButton.onclick=function(){
        let PaymentTime=document.getElementById('PaymentTime').value;
        let PaymentSum=document.getElementById('PaymentSum').value;
        let Tips=document.getElementById('Tips').value;
        socket.emit('payment_data',{
            PaymentTime:PaymentTime,
            PaymentSum:PaymentSum,
            Tips:Tips
        });
    }
};
/* GET users listing. */
router.get('/', function(req, res, next) {

    res.render('module',{functions:`${functions.toString()}`});
});
module.exports = router;