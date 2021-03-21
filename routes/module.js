var express = require('express');
var router = express.Router();

let functions=function (){
    var socket=io.connect('http://localhost:3000');
};
/* GET users listing. */
router.get('/', function(req, res, next) {

    res.render('module',{functions:`${functions.toString()}`});
});
module.exports = router;
