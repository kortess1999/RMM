var express = require('express');
var router = express.Router();
let DB =require('../database/pbdb');
/* GET home page. */
router.get('/', async function(req, res, next) {
  if(!req.session.logged)
  {
    res.redirect('/login');
    return
  }
  let modules=require('../bin/www');
  let Logs = await DB.query('SELECT id,address FROM modules');
  console.log(Logs);
  res.render('monitoring',{session:req.session,modules:modules,modules_list:Logs});
});
router.get('/quit', function(req, res, next) {
  console.log(req.session);
  req.session.logged=false;
  req.session.user={};
  res.redirect('/login');
})
module.exports = router;
