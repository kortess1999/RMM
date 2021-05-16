const moment = require('moment');
const queries={
    modules:(obj= {})=>{return 'SELECT id,address FROM modules'},
    visitsReport: (obj= {})=>{return ``},
    waterSpendReport: (obj= {})=>{return ``},
    alertReport: (obj= {})=>{
        console.log(obj);
        let {
            from = moment().subtract(1, 'week'),
            to = moment(),
            modules=[]
        } = obj;
        from = moment(from,'DD-MM-YYYY').format('YYYY-MM-DD HH:mm:ss.000000');
        to = moment(to,'DD-MM-YYYY').format('YYYY-MM-DD HH:mm:ss.000000');
        modules=modules.join(", ");
        return `SELECT 
            module_id as "ID модуля",
            err_type as "Авария",
            to_char(create_at, 'DD-MM-YYYY HH24:MM:SS') as "Время возникновения",
            to_char(solve_at, 'DD-MM-YYYY HH24:MM:SS') as "Время решения"
        FROM modules_errors 
        WHERE module_id IN (${modules})
        AND create_at BETWEEN '${from}' AND '${to}'`;
    },
};
module.exports = queries
