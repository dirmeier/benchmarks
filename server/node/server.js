
var express = require('express');
var app = express();
var request = require('request');


var sqlite3 = require('sqlite3').verbose();

app.get('/', function (req, res) {
    res.send('Hello World!');
});

app.get('/db', function (req, res) {
	var db = new sqlite3.Database('/Users/simondi/PHD/data/data/target_infect_x/database/tix_index.db');
	db.all("SELECT * FROM meta", function(err, rows){
		res.send(rows);
	});
  	db.close();
});


app.listen(3000, function () {
    console.log('Example app listening on port 3000!');
});
