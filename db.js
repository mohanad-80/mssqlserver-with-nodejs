const sql = require("mssql");

async function connectDB() {
  const config = {
    server: process.env.SQLSERVER_HOST,
    user: process.env.SQLSERVER_USER,
    password: process.env.SQLSERVER_PASSWORD,
    database: process.env.SQLSERVER_DATABASE,
    options: {
      trustServerCertificate: true
    },
    port: 1433,
  };

  try {
    const pool = await sql.connect(config);
    console.log("connected successfully to the DB");
    // const result = await pool.request().query('SELECT * FROM TestTable')
    // console.log(result["recordset"]);
    return pool;
  } catch (error) {
    console.error("Database connection error:", error);
    throw error; // Re-throw the error for handling
  }
}

module.exports = connectDB;
