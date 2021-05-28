let express = require('express');
let router = express.Router();
const DB = require('../database/pbdb');
const queries = require('../database/queries');
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
            let role = await DB.query(queries.getUserStatus({login:req.body.login}));
            req.session.user={
                login:req.body.login,
                password:req.body.pass,
                role: role[0].name
            };
            res.redirect('/');
            return
        }
    }
    req.session.log_err=true;
    res.redirect('/login');
});
module.exports = router;
