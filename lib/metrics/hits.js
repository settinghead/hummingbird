// Hits
//
// Send back individual hits.  Warning: this will send
// a _lot_ of data if you have a high traffic site.

var Metric = require('../metric');

var hits = Object.create(Metric.prototype);

var config = require('../../config/config');
var mysql = require('mysql');
var pool  = mysql.createPool({
  host     : config.mysql_host,
  user     : config.mysql_user,
  password : config.mysql_password,
  database : config.mysql_dbname
});

hits.name = 'hits';
hits.initialData = [];
hits.interval = 200; // ms
hits.increment = function(request) {
  this.data.push({
    url:       request.headers && request.headers.referer,
    timestamp: new Date(),
    ip:        request.ip
  });

  pool.getConnection(function(err, connection) {
    if (err) throw err;

    if(config.debug){
      console.log(request.headers);
      console.log(request.params);
    }

    if(request.params.ref && request.params.url){
      insert_str = 
        "INSERT INTO `celeb_counter`.`hits` "
        + " (`url`, `referral_url`) "
        + " VALUES ('"
          +request.params.url+"', '"
          +request.params.ref+"');";

      if(config.debug){
        console.log(insert_str);
      }

      connection.query(insert_str, function(err, rows, fields) {
        if(config.debug){
          if(err) console.log("Error: " + err);
        }
      });
    }
  });
};

module.exports = hits;
