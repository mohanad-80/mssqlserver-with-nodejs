const express = require("express");
const bodyParser = require("body-parser");
require("dotenv/config");
const sql = require("mssql");

const connectDB = require("./db.js");

const app = express();
const PORT = 3000;
let connectionPool;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));

// listening on the port after connecting to ms sql server
connectDB().then((pool) => {
  app.listen(PORT, () => {
    console.log(`listening on port ${PORT}`);
  });
  connectionPool = pool;
});

// get all records
app.get("/api/testtable", async (req, res) => {
  try {
    const result = await connectionPool
      .request()
      .query("SELECT * FROM TestTable");
    res.json(result.recordset);
  } catch (error) {
    console.error("Error fetching records:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

// get certain record with some id
app.get("/api/testtable/:id", async (req, res) => {
  const value = req.params.id;
  try {
    // method 1
    const result = await connectionPool
      .request()
      .input("ID", sql.Int, value)
      .query("SELECT * FROM TestTable WHERE ID = @ID");

    // method 2
    // const result = await sql.query`SELECT * FROM TestTable WHERE ID = ${value}`

    res.json(result.recordset);
  } catch (error) {
    console.error("Error fetching records:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

// add a new record
app.post("/api/testtable", async (req, res) => {
  const { ID, Name, Age } = req.body;
  try {
    await connectionPool
      .request()
      .input("ID", sql.Int, ID)
      .input("Name", sql.NVarChar(50), Name)
      .input("Age", sql.Int, Age)
      .query("INSERT INTO TestTable (ID, Name, Age) VALUES (@ID, @Name, @Age)");
    res.status(201).json({ message: "Record inserted successfully" });
  } catch (error) {
    console.error("Error inserting record:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});
