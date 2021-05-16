const fs = require('fs');
const moment = require('moment');
const encoding = require('encoding');
function getHeaders(json){
    let headers=[];
    //Получение списка заголовков
    if(json.length)
        json.forEach(row=>{
            for(let col in row)
                if(!headers.includes(col)) headers.push(col);
        });
    return headers;
}
function buildTable(json,headers){
    let table = [];
    for(let i=0;i<=json.length;i++)
    {
        table.push([]);
        for(let j=0;j<headers.length;j++) table[i].push('');
    }
    ///Запись таблицы
    //Запись списка заголовков
    for(let i=0;i<headers.length;i++)
        table[0][i]=headers[i];
    //Запись значений в таблицу
    for(let i=0;i<json.length;i++)
        for(let col in json[i])
            table[i+1][headers.indexOf(col)]=json[i][col];
    return table;
}
function getCsvFile(table){
    for(let i=0;i<table.length;i++)
        table[i]=table[i].join(';');
    let result=table.join('\n');
    return result
}
///Принимает массив объектов с полями в формате [[header1:field1, header2:field2]]
function JsonToCsv(json={},path='reports'){
    path = `./reports/${path}.csv`;
    const headers = getHeaders(json);
    const table = buildTable(json,headers);
    let file_string = getCsvFile(table);
    //Исправление кодировки
    file_string = encoding.convert(file_string, 'WINDOWS-1251', 'UTF-8');
    fs.writeFileSync(path,file_string,{encoding:'utf8'});
    return path;
}
module.exports=JsonToCsv;
