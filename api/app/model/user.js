//MONGO DB SETUP <---------------------------------------------------------------------------------------------------------------->
var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost:27017/mydatabase');

// grab the things we need
var Schema = mongoose.Schema;

// create a schema
var userSchema = new Schema({
  username: { type: String, required: true, unique: true },
  accesstoken: String,
  accesstokensecret: String
});


// the schema is useless so far
// we need to create a model using it
var User = mongoose.model('User', userSchema);

// make this available to our users in our Node applications
module.exports = User;

//--------------------------------------------------------------------
