const express = require('express');
const fs = require('fs');
let router = express.Router();
let DB =require('../database/pbdb');

const reportsList = require('../constants/reportsList');
const modules = require('../bin/www');

router.get('/:filename', async function(req, res, next) {
    try{
        const root=__dirname.split('routes').join('');
        let file_path = `${root}reports/${req.params.filename}.csv`.split('\\').join('/');

        if(fs.existsSync(file_path))
            await res.download(file_path)
        else
            res.end();
    }catch (e) {
        console.log(`Ошибка:${e}`);
        res.end();
    }
});
router.get('/', async function(req, res, next) {
    try {
        if(!req.session.logged)
        {
            res.redirect('/login');
            return
        }
        const modulesList = await DB.query('SELECT id,address FROM modules');
        res.render('reports',{session:req.session,reports:reportsList,modules:modulesList});
    }catch (e) {
        console.log(`Ошибка:${e}`);
        res.end();
    }
});
module.exports = router;
