const express = require("express");
const bodyParser = require("body-parser");
require("dotenv/config");
const sql = require("mssql");

const connectDB = require("./db.js");

const app = express();
const PORT = 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));

// listening on the port after connecting to MongoDB
connectDB().then(() => {
  app.listen(PORT, () => {
    console.log(`listening on port ${PORT}`);
  });
});
