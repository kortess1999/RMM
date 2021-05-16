var express = require('express');
var router = express.Router();
let moment = require('moment');

let DB =require('../database/pbdb');
const queries = require('../database/queries');
const getReportByQuery = require('../methods/getReportByQuery');

/* GET home page. */
router.get('/', async function(req, res, next) {
  if(!req.session.logged)
  {
    res.redirect('/login');
    return
  }
  let modules=require('../bin/www');
  const moduleList = await DB.query(queries.modules());
  console.log(moduleList);
  res.render('monitoring',{session:req.session,modules:modules,modules_list:moduleList});
});
router.get('/quit', function(req, res, next) {
  console.log(req.session);
  req.session.logged=false;
  req.session.user={};
  res.redirect('/login');
})
router.post('/produce_report', async function (req, res, next) {
  try {
    const moduleList = await DB.query(queries.modules());
    console.log(req.body);
    let {
      repType = 'По посещениям',
      date = `${moment().format('DD-MM-YYYY')} - ${moment().subtract(1,"day").format('DD-MM-YYYY')}`,
      modules = []
    } = req.body;
    let [from, to] = date.split(' - ');
    let path = await getReportByQuery({repType:repType,from:from,to:to,modules:modules});
    await res.redirect(`/${path.split('.csv').join('')}`);
  }catch (e) {
    console.log(e);
    res.end();
  }
})

module.exports = router;
