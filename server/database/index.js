const mysql = require("mysql")

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'stud-ai',
});

connection.connect(function(err) {
    if (err) {
      console.error('Error connecting to the database: ');
    }
    console.log("Database connected");
  });

  module.exports = connection