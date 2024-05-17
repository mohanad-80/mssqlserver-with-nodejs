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

app.get("/airplane", async (req, res) => {
  try {
    const result = await sql.query`SELECT * FROM AIRPLANE`;
    res.json(result.recordset);
  } catch (error) {
    console.error("Error fetching records:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.post("/airplane", async (req, res) => {
  const { serial, model, capacity } = req.body;
  try {
    await sql.query`INSERT INTO AIRPLANE (Serial, Model, Capacity)
    VALUES(${serial}, ${model}, ${capacity});`;
    res.status(201).json({ message: "Record inserted successfully" });
  } catch (error) {
    console.error("Error inserting record:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

/*

1. `POST /api/users/signup`: Signing up a new user
2. `PUT /api/users/:userId`: Updating a user's details
3. `POST /api/aircrafts`: Adding an aircraft (by admin)
4. `PUT /api/aircrafts/:aircraftId`: Updating an aircraft's details (by admin)
5. `POST /api/flights`: Adding a flight (by admin)
6. `PUT /api/flights/:flightId`: Updating a flight's details (by admin)
7. `GET /api/flights`: Showing a list of available flights
8. `POST /api/flights/:flightId/book`: Performing operations on flights: booking
9. `DELETE /api/flights/:flightId/bookings/:bookingId`: Performing operations on flights: cancelling
10. `PUT /api/flights/:flightId/bookings/:bookingId`: Performing operations on flights: changing flight class

*/
