const express = require('express');
const fs = require('fs');
let router = express.Router();

const jsonToCsv = require('../methods/JsonToCsv');

router.get('/:filename', async function(req, res, next) {
    try{
        const root=__dirname.split('routes').join('');
        let file_path = `${root}reports/${req.params.filename}.csv`.split('\\').join('/');

        console.log(fs.existsSync(file_path),file_path);
        if(fs.existsSync(file_path))
            await res.download(file_path)
        else
            res.end();
    }catch (e) {
        console.log(`Ошибка:${e}`);
        res.end();
    }

});
module.exports = router;
