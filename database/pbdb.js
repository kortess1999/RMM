const pgp = require('pg-promise')({
    // Initialization Options
});
// Preparing the connection details:
const cn = 'postgres://postgres:gerard789@localhost:5432/rmm_database';
// Creating a new database instance from the connection details:
const db = pgp(cn);
module.exports={
    ///Выполнение запроса для PostgreSQL
    query: async (query)=>{
        return await db.any(query)
            .then(console.log(`Query '${query.substr(0,20)}...' executed`))
            .catch((e)=>{console.log(`Error of query:${query.substr(0,30)}\n${e}`)});
    },
}
