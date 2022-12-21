import mysql from "mysql";

// create the connection to database
const db = mysql.createPool({
  host: "re-loader.com",
  user: "root",
  port: 3306,
  password: "adisak",
  database: "smart_hospital",
  connectionLimit: 10,
});

db.on("error", function (err) {
  console.log(err);
});

export default db;
