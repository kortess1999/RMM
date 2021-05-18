let moment = require('moment');
let DB =require('../database/pbdb');
let queries = require('../database/queries');
const jsonToCsv = require('../methods/JsonToCsv');
///Возвращает имя файла с отчётом.
async function GetReportByQuery(obj) {
    switch (obj.repType) {
        case 'По посещениям':
            return jsonToCsv(await DB.query(queries.visitsReport(obj)),'visitsReport');
            break;
        case "По обслуживанию модулей":
            return jsonToCsv(await DB.query(queries.servicesReport(obj)),'servicesReport');
            break;
        case "По авариям":
            return jsonToCsv(await DB.query(queries.alertReport(obj)),'alertReport');
            break;
        default:
            return [];
    }
}
module.exports = GetReportByQuery;
