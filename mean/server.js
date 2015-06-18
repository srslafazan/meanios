var express = require('express');
var path = require('path');
var app = express();
// body-parser
var bodyParser = require('body-parser');
// we have to use the json version since we are posting json data
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({'extended': true}));

app.use(express.static(path.join(__dirname, './client')));
require('./config/mongoose.js');
require('./config/routes.js')(app);
app.listen(8000, function() {
  console.log('cool stuff on: 8000');
});