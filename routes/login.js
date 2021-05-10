let express = require('express');
let router = express.Router();
let DB=require('../database/pbdb');
async function checkPassword(login){
    let result=await DB.query(`SELECT password FROM users where log='${login}';`);
    return result;
}
/* GET home page. */
router.get('/', function(req, res, next) {
    //Если уже авторизован
    if(req.session.logged)
    {
        res.redirect('/');
        return;
    }
    res.render('login',req.session);
    req.session.log_err=false;
});
router.post('/', async function(req, res, next) {
    if(req.body.login==='')
    {
        req.session.log_err=true;
        res.redirect('/login');
        return;
    }
    let password=await checkPassword(req.body.login,req.body.pass);
    if(password.length)
    {
        if(password[0].password===req.body.pass)
        {
            req.session.logged=true;
            req.session.user={
                login:req.body.login,
                password:req.body.pass
            };
            res.redirect('/');
            return
        }
    }
    req.session.log_err=true;
    res.redirect('/login');
});
module.exports = router;
