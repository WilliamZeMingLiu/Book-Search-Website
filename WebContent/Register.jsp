<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="java.util.ArrayList"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<script>
	function validate_user(){
		var xhttp = new XMLHttpRequest();
		xhhtp.open("GET", "A3_Servlet_Register?username=" + document.user_form.username.value + "&password=" + document.user_form.password.value + "&confirm_password="
				+ document.user_form.confirm_password, false);
		xhttp.send();
		if(xhttp.responseText.trim().length > 0){
			//document.getElementById("formerror").innerHTML = xhttp.responseText;
			return false;
		}
		return true;
	}
</script>
<style>
	body, html{
		height: 100%;
		margin: 0;
		padding: 0;
	}
	.header{
		width: 100%;
		height: 110px;
		border-bottom: 1px #e6e6e6 solid;
	}
	#bookworm{
		width: 100px;
		float: left;
		margin-left: 20%;
		margin-top: 10px;
	}
	.search_engine_body{
		float: left;
		width: 60%;
		height: 30px;
		margin: 0 auto;
		padding: 2%;
	}
	.radio_button1_div{
		float: left;
		margin-left: 50px;
	}
	.radio_button2_div{
		float: left;
		margin-left: 50px;
	}
	.radio_button{
		margin-bottom: 10px;
	}
	.radio_button:hover{
		margin-bottom: 10px;
		cursor:pointer;
	}
	.submit_button{
		margin-top: 7px;
		margin-left: 20px;
		width: 25px;
		box-shadow: 1px 1px 1px black;
		padding: 5px 15px;
		background: #a6a6a6;
		float: left;
		border-radius: 5px;
		text-align: center;
  		text-decoration: none;
  		display: inline-block;
	}
	.submit_button:hover{
		box-shadow: 1px 1px 3px black;
		background: #8c8c8c;
  		cursor:pointer;
	}
	.user_field{
		margin: 0 auto;
		margin-top: 60px;
		width: 80%;
	}
	.user_button{
		margin-top: 100px;
		margin: 0 auto;
		width: 100%;
		padding: 5px 15px;
		background: #a6a6a6;
		border-radius: 5px;
		text-align: center;
  		text-decoration: none;
  		display: inline-block;
  		color: white;
	}
	.user_button:hover{
		background: #8c8c8c;
  		cursor:pointer;
	}

	
</style>
</head>
<body>
	<!-- Header -->
	<div class="header">
		<a href="HomePage.jsp">
			<img id="bookworm" src="bookworm.png">
		</a>

		<div class="search_engine_body">
			<!-- Form  -->
			<form class="form" onsubmit="return validate()" method="GET" action="SearchResults.jsp">
				<p id="results" style="color: red; font-size: 15px; margin-top: -1%; margin-left: 6.5%;"></p>
				<input id="search_bar" style="width: 240px; height: 10px; font-size: 13px; padding: 5px; float: left; margin-left: 6%; margin-top: 10px;" type="text" placeholder="What book is on your mind?">
				<input class="submit_button" type="image" alt="submit" name="submit" src="magnifying_glass.png"/>
				
				<div class="radio_button1_div">
					<input id="name" name="radio_button" type="radio" class="radio_button" value="name"><label style="color: black;"> Name</label> <br>
					<input id="author" name="radio_button" type="radio" class="radio_button" value="author"><label style="color: black;"> Author</label>
				</div>
				<div class="radio_button2_div">
					<input id="isbn" name="radio_button" type="radio" class="radio_button" value="isbn"><label style="color: black;"> ISBN</label> <br>
					<input id="publisher" name="radio_button" type="radio" class="radio_button" value="publisher"><label style="color: black;"> Publisher</label>
				</div>
			</form>
			<!-- Form  -->
		</div>
	</div>
	<!-- /Header -->
	
	<!--  User Form -->
	<div class="user_field">
		<% if(session.getAttribute("register_error") == "password_match"){%>
		<p style="color: red;">Please ensure that your passwords match</p>
		<%}%><br/>
		<% if(session.getAttribute("register_error") == "user_exist"){%>
		<p style="color: red;">Username is already taken. Please select another one</p>
		<%}%><br/>
		<form class="user_form" onsubmit="return validate_user()" method="GET" action="A3_Servlet_Register">
			<h1 style="color: gray; font-size: 20px;">Username</h1>
			<input name="username" id="username" type="text" style="width: 100%; height: 20px; font-size: 15px; padding: 5px;">
			<h1 style="color: gray; font-size: 20px;">Password</h1>
			<input name="password" id="password" type="password" style="width: 100%; height: 20px; font-size: 15px; padding: 5px;">
			<h1 style="color: gray; font-size: 20px;">Confirm Password</h1>
			<input name="confirm_password" id="confirm_password" type="password" style="width: 100%; height: 20px; font-size: 15px; padding: 5px; margin-bottom: 40px;">
			<input name="submit" class="user_button" type="submit" value="Register"/>
		</form>
	</div>
	<!--  /User Form -->

	<script>
		function validate(){			
			var value = document.getElementById('search_bar').value;
			var xhttp = new XMLHttpRequest();
			//Radio button control flow
			if(document.getElementById('name').checked == true){ 
				xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q=intitle:" + value, false);
			}
			else if(document.getElementById('author').checked == true){
				xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q=inauthor:" + value, false);
			}
			else if(document.getElementById('isbn').checked == true){
				xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q=isbn:" + value, false);
			}
			else if(document.getElementById('publisher').checked == true){
				xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q=inpublisher:" + value, false);
			}
			else{
				xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q=" + value, false);
			}
			
			//AJAX calls
			xhttp.send();
			var text = xhttp.responseText;
			var data = JSON.parse(text);
			var database=[];
			
			//This if statement is for the case in which the user inputs nothing/there are no results
			if(value == "" || value == "null"){
				document.getElementById("results").innerHTML = "Please insert a search input";
				return false;
			}
			if(data.totalItems == 0){
				document.getElementById("results").innerHTML = "Sorry, no results found";
				return false;
			}
			
			//For loop for data array
			for(i=0; i < 10; i++){
				try{
					var book = {name : data.items[i].volumeInfo.title,
								author : data.items[i].volumeInfo.authors[0],
								summary: data.items[i].volumeInfo.description,
								publisher: data.items[i].volumeInfo.publisher,
								date : data.items[i].volumeInfo.publishedDate,
								isbn : data.items[i].volumeInfo.industryIdentifiers[0].identifier,
								rating : data.items[i].volumeInfo.averageRating,
								picture : data.items[i].volumeInfo.imageLinks.thumbnail,
								id : data.items[i].id}	
					database[i] = book;
				}
				catch(error){
					console.log("ERROR");
				}
			}
			
			//Session storage
			sessionStorage.setItem("database", JSON.stringify(database));
			sessionStorage.setItem("user_input", value + '"');
		}
	</script>
	
	

</body>
</html>