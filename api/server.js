var express    = require('express');        // call express
var app        = express();                 // define our app using express
var bodyParser = require('body-parser');
var request = require("request");
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
var port = process.env.PORT || 8080;
var client = require('twilio')('key', 'secret');
var router = express.Router();
var google = require('google')
var systemrequirements ="";
var temporarycounter = 0;

var twilio = require('twilio');
var FB = require('fb');
FB.setAccessToken('token');

router.use(function(req, res, next) {
    // do logging
    console.log('Something is happening.');
    next(); // make sure we go to the next routes and don't stop here
});

router.get('/', function(req, res) {
    res.json({ message: 'hooray! welcome to our api!' });   
});
router.get('/api', function(req, res) {
    res.json({ message: 'hooray! welcome to us!' });   
});

router.route('/bears')
    .post(function(req, res) {
    	  var text = req.body.Body;
    	  var app = "";
    	  var k = 0;
    	  var message = "";
    	  while(text.substring(k, k+1)!=" "){
    	    console.log("first");
    	      app+= text.substring(k, k+1);
    	      k++;
    	  }
    	  console.log("|"+app+"|");
    	  if(app == "tweet"){
    	    //twitter
    	    sendTweet(text.substring(k+1, text.length));
    	  }
    	  else if(app == "show-feed"){
    	    //twitter
    	    
    	  }
    	  else if(app == "post-to-wall"){
    	    //facebook
    	    FB.api(
            "/me/feed",
            "POST",
            {
                "message": text.substring(k+1, text.length)
            },
            function (response) {
              if (response && !response.error) {
                
              }else{
                console.log(response.error);
              }
            }
          );
    	  }
    	  else if(app == "get-route"){
    	    //mapbox
    	    var places = text.substring(k+1, text.length);
    	    var start = "";
    	    var c = 0;
          while(places.substring(c, c+1)!="+"){
            start+= places.substring(c,c+1);
            c++;
          }
          var end = places.substring(c+1, places.length);
          getRoute(start, end);
    	  }
    	  else if(app == "search"){
    	    //google search
    	    console.log("HERE");
    	    var str = text.substring(k+1, text.length);
          google.resultsPerPage = 25
          var nextCounter = 0
          var fstr = "";
          google(str, function (err, next, links){
            if (err) console.error(err)
           
            for (var i = 0; i < 4; ++i) {
              fstr+=(i+1+". ");
              fstr+=(links[i].title+"\n") // link.href is an alias for link.link 
              fstr+=(links[i].description + "\n\n")
            }
            client.messages.create({ 
    	        to: "num", 
    	        from: "num2", 
    	        body: fstr,   
            }, function(err, message) { 
               if(!err){
    	          console.log(message.sid); 
               }
          });
          });
    	  }
    	  
    	  
    	  
    	  
    	  
    	  
       /* client.messages.create({ 
	        to: "7036091404", 
	        from: "+13238920251", 
	        body: "hello",   
        }, function(err, message) { 
           if(!err){
	          console.log(message.sid); 
           }
        }); */
    });
    
app.use('/', router);

function sendTweet(text){
  var url = "http://twitter-rsbballguy.c9users.io/sendTweet?text="+text;
  request(url, function(error, response, body) {
      
  });
}

function getRoute(beginning, end){
  var url = "http://twitter-rsbballguy.c9users.io/getRoute?start="+beginning+"&end="+end;
  request(url, function(error, response, body) {
    console.log(body);
        client.messages.create({ 
	        to: "7036091404", 
	        from: "+13238920251", 
	        body: body,   
        }, function(err, message) { 
           if(!err){
	          console.log(message.sid); 
           }
        });
  });
}

var server = app.listen(port, function () {})
console.log('Magic happens on port ' + port);