var friends = require('./../server/controllers/friends.js');
module.exports = function(app) {
  app.get('/friends', function(req, res) {
    friends.index(req, res);
  });
}