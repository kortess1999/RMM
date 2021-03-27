let express = require('express');
let router = express.Router();
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({extended: false});

/* GET home page. */
router.get('/', urlencodedParser,function(req, res, next) {
    res.render('login');
});
router.post('/auth',urlencodedParser, function(req, res, next) {
    console.log(`login:${req.body.login}\npass:${req.body.pass}`);
    console.log(req.body);
    res.end();
});
module.exports = router;
