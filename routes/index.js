var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  if(!req.session.logged)
  {
    res.redirect('/login');
    return
  }
  res.render('monitoring',req.session);
});
router.get('/quit', function(req, res, next) {
  console.log(req.session);
  req.session.logged=false;
  req.session.user={};
  res.redirect('/login');
})
module.exports = router;
