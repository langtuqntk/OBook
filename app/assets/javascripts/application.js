// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require turbolinks
//= require_tree .

function formatAMPM(date) {
  var hours = date.getHours();
  var minutes = date.getMinutes();
  var ampm = hours >= 12 ? 'pm' : 'am';
  hours = hours % 12;
  hours = hours ? hours : 12; // the hour '0' should be '12'
  minutes = minutes < 10 ? '0'+minutes : minutes;
  var strTime = hours + ':' + minutes + ' ' + ampm;
  return strTime;
}

function countProperties(obj) {
    var count = 0;
    for(var prop in obj) {
        if(obj.hasOwnProperty(prop))
            ++count;
    }
    return count;
}

socketEvent.init();
socketEvent.loadNotification();

// Initialize Firebase
var config = {
    apiKey: "AIzaSyDmmbk7MrCmYsT4vQZonrYJxRsh8CcMyVU",
    authDomain: "obook-4c5cf.firebaseapp.com",
    databaseURL: "https://obook-4c5cf.firebaseio.com",
    projectId: "obook-4c5cf",
    storageBucket: "obook-4c5cf.appspot.com",
    messagingSenderId: "465909144656"
};
firebase.initializeApp(config);

var database = firebase.database();
