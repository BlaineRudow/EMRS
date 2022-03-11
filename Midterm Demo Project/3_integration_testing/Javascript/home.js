/**************************************
 TITLE: eventsAndButtons.js
 AUTHOR: Blaine Rudow (BR)
***************************************/
/***

***/
$(document).ready(function(){
	var username = document.getElementById('uName').value;
	//var userPassword = document.getElementById("uPass").value;
	var elButton = document.getElementById("bLogin");
	
	//Event Listener method
	
	elButton.addEventListener("click", function(){ 
		checkLogin(username);
		}, 
		false);
	
	// Purpose: to create a function that outputs a sentence to an html page using java script.
	// Parameters: strTagID - name of element id  numCrewSize - integer, the size of the crew
	// Parameters: strCaptainName - string the name of the captain, strShipName - string the name of the ship
	// Return: n/a
	function checkLogin(user){
		alert(user);
		
	}
	
});