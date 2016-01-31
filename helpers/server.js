var express = require('express');
var passport = require('passport');
var Strategy = require('passport-twitter').Strategy;
var TwitterBot = require("node-twitterbot").TwitterBot;
var mongoose = require('mongoose');
var mongodb = require('mongodb');
var url = require('url');
var geocoderProvider = 'google';
var httpAdapter = 'https';
var request = require('request');
var User = require('./app/model/user');

// Configure the Twitter strategy for use by Passport.
//
// OAuth 1.0-based strategies require a `verify` function which receives the
// credentials (`token` and `tokenSecret`) for accessing the Twitter API on the
// user's behalf, along with the user's profile.  The function must invoke `cb`
// with a user object, which will be set at `req.user` in route handlers after
// authentication.
var app = express();
var atoken, atokenSecret, username = "";
passport.use(new Strategy({
    consumerKey: "**",
    consumerSecret: "*****",
    callbackURL: 'http://twitter-****.c9users.io/login/twitter/return'
  },
  function(token, tokenSecret, profile, cb) {
    // In this example, the user's Twitter profile is supplied as the user
    // record.  In a production-quality application, the Twitter profile should
    // be associated with a user record in the application's database, which
    // allows for account linking and authentication with other identity
    // providers.
    atoken = token;
    atokenSecret = tokenSecret;
    username = profile["username"];
    dothis();
    return cb(null, profile);
  }));
  //4271065281-t5C2l0sizooDvnbygPWPXTbur94GxqKhb5YYzI9
  //DfErEszyXJjXs13C3YbFiDodw2eEOPzmpBEdugIJV6eN1
  
  //
  //

// Configure Passport authenticated session persistence.
//
// In order to restore authentication state across HTTP requests, Passport needs
// to serialize users into and deserialize users out of the session.  In a
// production-quality application, this would typically be as simple as
// supplying the user ID when serializing, and querying the user record by ID
// from the database when deserializing.  However, due to the fact that this
// example does not have a database, the complete Twitter profile is serialized
// and deserialized.
passport.serializeUser(function(user, cb) {
  cb(null, user);
});

passport.deserializeUser(function(obj, cb) {
  cb(null, obj);
});


// Create a new Express application.


// Configure view engine to render EJS templates.
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');

// Use application-level middleware for common functionality, including
// logging, parsing, and session handling.
app.use(require('morgan')('combined'));
app.use(require('cookie-parser')());
app.use(require('body-parser').urlencoded({ extended: true }));
app.use(require('express-session')({ secret: 'keyboard cat', resave: true, saveUninitialized: true }));

// Initialize Passport and restore authentication state, if any, from the
// session.
app.use(passport.initialize());
app.use(passport.session());


// Define routes.
app.get('/',
  function(req, res) {
    res.render('home', { user: req.user });
  });

app.get('/login',
  function(req, res){
    res.render('login');
  });

app.get('/login/twitter',
  passport.authenticate('twitter'));

app.get('/login/twitter/return', 
  passport.authenticate('twitter', { failureRedirect: '/login' }),
  function(req, res) {
    res.redirect('/');
  });
app.get('/sendTweet', function(req, res){
    var url_parts = url.parse(req.url, true);
    var query = url_parts.query["text"];
    
     var Bot = new TwitterBot({
   "consumer_secret": "*//*",
   "consumer_key": "*\\*",
   "access_token": atoken,
   "access_token_secret": atokenSecret
    });
  Bot.tweet(query);
    
    res.send("success!");
});
app.get('/getRoute', function(req, res){
    var url_parts = url.parse(req.url, true);
    // var start = url_parts.query["beginning"];
    // var end = url_parts.query["end"];
    var myjson = url_parts.query;
    var start = myjson["start"];
    var end = myjson["end"];
    var finalstring = "";
    var extra = {
    	apiKey: '*****', // for Mapquest, OpenCage, Google Premier 
    	formatter: null         // 'gpx', 'string', ... 
	  };
	  var geocoder = require('node-geocoder')(geocoderProvider, httpAdapter, extra);
	  geocoder.geocode(start, function(err, red) {
	    if(err){console.log(err);}
    	//console.log(res);
    	var latitude = red[0]["latitude"];
    	var longitude = red[0]["longitude"];
    	//console.log(longitude);
    	//console.log(latitude);
    	geocoder.geocode(end, function(err, ref) {
    	  if(err){console.log(err);}
    	//console.log(res);
    		var latitude1 = ref[0]["latitude"];
    		var longitude1 = ref[0]["longitude"];
    		request('https://api.mapbox.com/v4/directions/mapbox.driving/'+longitude+','+latitude+';'+longitude1+','+latitude1+'.json?alternatives=false&instructions=text&geometry=false&steps=true&&access_token=pk.eyJ1IjoiYmhhcmF0aGMiLCJhIjoiY2lrMXFjbmltMDNidXR1bTBkZ3htaG9oaSJ9.dhdRjI2kdI8NBAqInpowig', function (error, response, body) {
  				if (!error && response.statusCode == 200) {
	     
		   		var obj = JSON.parse(body);
		    	var routes = obj["routes"][0]["steps"];
		    	for (var i = 0; i <routes.length; i++) {
		    		var instr = routes[i]["maneuver"]["instruction"];
		    		finalstring+=("\n"+instr);
		    	}
		    	res.send(finalstring);
  			}
		})
    	//console.log(longitude);
    	//console.log(latitude);
		});
	});
});
app.get('/profile',
  require('connect-ensure-login').ensureLoggedIn(),
  function(req, res){
    res.render('profile', { user: req.user });
  });

app.listen(process.env.PORT || 3000);

function dothis(){
var chris = new User({
  username: username, 
  accesstoken: atoken,
  accesstokensecret: atokenSecret
});

//chris["username"] ='asfkjaiofja';

// call the built-in save method to save to the database
chris.save(function(err) {
  if (err){
      console.log(err);
  }

  console.log('User saved successfully!');
});
}