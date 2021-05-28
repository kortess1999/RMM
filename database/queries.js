const moment = require('moment');
const queries={
    modules:(obj= {})=>{return 'SELECT id,address FROM modules'},
    users:(obj= {})=>{return`SELECT * FROM users LEFT JOIN user_status ON users.status_id = user_status.id`},
    userStatuses:(obj= {})=>{return`SELECT name FROM user_status`},
    getUserStatus:(obj= {})=>{
        let {login = ''} = obj;
        return`SELECT name FROM users 
        LEFT JOIN user_status ON users.status_id = user_status.id
        WHERE log = '${login}'`},
    userInsert:(obj ={})=>{
        let {
            user_name = '',
            role = '',
            login = '',
            password = '',
        } = obj;
        return `INSERT INTO users 
    (user_name, status_id, log, password) VALUES 
    ('${user_name}', (SELECT id from user_status where name = '${role}'), '${login}', '${password}')`},
    userDelete:(obj ={})=>{
        let {login = ''} = obj;
        return `DELETE FROM users WHERE log = '${login}'`},
    userUpdate:(obj ={})=>{
        let {
            user_name = '',
            role = '',
            login = '',
            password = '',
        } = obj;
        return `UPDATE users SET
        user_name = '${user_name}',        
        password = '${password}',
        status_id = (SELECT id from user_status where name = '${role}')
         WHERE log = '${login}'`},
    moduleDataInsert:(obj = {})=>{
        let {
            module_id = 1,
            time = moment().format('YYYY-MM-DD HH:mm:ss.000000'),
            temperature = null,
            below_water_lvl = null,
            upper_water_lvl = null,
            visits = null
        } = obj;
        return `INSERT INTO module_data 
            (module_id, time, temperature, 
            below_water_lvl, upper_water_lvl, visits) 
            VALUES (${module_id},'${time}',${temperature},
            ${below_water_lvl},${upper_water_lvl},${visits})`},
    servicesInsert: (obj= {})=>{
        let {
            module_id = 1,
            user_id = 1,
            date = moment().format('YYYY-MM-DD HH:mm:ss.000000'),
            message = '',
            type = ''
        } = obj;
        return `INSERT INTO services (
        user_id, module_id, date, message, type
        ) VALUES (${user_id},${module_id},'${date}','${message}','${type}');`},
    visitsReport: (obj= {})=>{
        let {
            from = moment().subtract(1, 'week'),
            to = moment(),
            modules=[]
        } = obj;
        from = moment(from,'DD-MM-YYYY').startOf('day').format('YYYY-MM-DD HH:mm:ss.000000');
        to = moment(to,'DD-MM-YYYY').endOf("day").format('YYYY-MM-DD HH:mm:ss.000000');
        modules=modules.join(", ");
        return `SELECT 
            module_id as "ID модуля",
            to_char(time, 'DD-MM-YYYY HH24:MM:SS') as "Дата и время",
            visits as "Кол-во посещений"
        FROM module_data
        WHERE module_id IN (${modules})
        AND time BETWEEN '${from}' AND '${to}'`},
    servicesReport: (obj= {})=>{
        let {
            from = moment().subtract(1, 'week'),
            to = moment(),
            modules = [],
        } = obj;
        from = moment(from,'DD-MM-YYYY').startOf('day').format('YYYY-MM-DD HH:mm:ss.000000');
        to = moment(to,'DD-MM-YYYY').endOf("day").format('YYYY-MM-DD HH:mm:ss.000000');
        modules=modules.join(", ");
        return `SELECT 
        type as "Тип обслуживания",
        to_char(date, 'DD-MM-YYYY HH24:MM:SS') as "Дата обслуживания",
        message as "Дополнительная информация" 
        FROM services
        WHERE module_id IN (${modules})
        AND date BETWEEN '${from}' AND '${to}'`},
    alertReport: (obj= {})=>{
        console.log(obj);
        let {
            from = moment().subtract(1, 'week'),
            to = moment(),
            modules=[]
        } = obj;
        from = moment(from,'DD-MM-YYYY').startOf('day').format('YYYY-MM-DD HH:mm:ss.000000');
        to = moment(to,'DD-MM-YYYY').endOf("day").format('YYYY-MM-DD HH:mm:ss.000000');
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
