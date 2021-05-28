var express = require('express');
var router = express.Router();
const DB = require('../database/pbdb');
const queries = require('../database/queries');
/* GET users listing. */
router.get('/', async function(req, res, next) {
  if(!req.session.logged || session.user.role !== 'Администратор')
  {
    res.redirect('/login');
    return
  }
  const users = await DB.query(queries.users());
  const roles = await DB.query(queries.userStatuses());
  //console.log(users);
  res.render('users',{roles:roles, users:users,session:req.session});
  req.session.UsersError="";
});
router.post('/add', async function(req, res, next) {
  if(!req.session.logged)
  {
    res.redirect('/login');
    return
  }
  req.session.UsersError="";
  console.log(req.body);
  const users = await DB.query(queries.users());
  let error = false;
  users.forEach(user=>{
    if(user.log === req.body.login)
      error = true;
  });
  if(!error)
    await DB.query(queries.userInsert(req.body));
  else
    req.session.UsersError=`Пользователь с логином ${req.body.login} уже существует!`;
  res.redirect('/users');
});
router.post('/delete', async function(req, res, next) {
  if(!req.session.logged)
  {
    res.redirect('/login');
    return
  }
  req.session.UsersError="";
  console.log(req.body);
  if(req.body.login)
    await DB.query(queries.userDelete(req.body));
  res.redirect('/users');
});
router.post('/change', async function(req, res, next) {
  if(!req.session.logged)
  {
    res.redirect('/login');
    return
  }
  req.session.UsersError="";
  const users = await DB.query(queries.users());
  for(let i=0;i<users.length;i++)
  {
    let obj = {};
    if(users[i].log === req.body.login)
    {
      obj = {
        login:req.body.login,
        password: req.body.password === '' ? users[i].password:req.body.password,
        user_name: req.body.user_name === '' ? users[i].user_name:req.body.user_name,
        role: req.body.role === 'Не менять' ? users[i].name:req.body.role,
      };
      break;
    }
    if(JSON.stringify(obj)!=='{}')
      await DB.query(queries.userUpdate(obj));
  }

  await DB.query(queries.userUpdate(req.body));
  res.redirect('/users');
});
module.exports = router;
