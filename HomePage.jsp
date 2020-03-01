<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HomePage</title>
	
<style>
	body, html{
		height: 100%;
		margin: 0;
		padding: 0;
	}
	.header{
		width: 100%;
		height: 130px;
	}
	#bookworm{
		width: 150px;
		float: left;
		margin-left: 40px;
		margin-top: 10px;
	}
	.search_engine_background{
  		background-size: cover;
		height: 83%;
		background-image: url('background.jpg');
		background-repeat: no-repeat;
	}
	.search_engine_body{
		width: 80%;
		margin: 0 auto;
		padding-top: 5%;
	}
	.radio_button1_div{
		float: left;
		padding-top: 20px;
	}
	.radio_button2_div{
		float: left;
		margin-left: 40%;
		padding-top: 20px;
	}
	.radio_button{
		margin-bottom: 10px;
	}
	.radio_button:hover{
		margin-bottom: 10px;
		cursor:pointer;
	}
	.submit_button{
		float: right;
		padding: 5px 10px;
		font-size: 20px;
		margin-top: 10%;
		background: linear-gradient(#1a1a1a,#000000);
		border: 0.5px solid grey;
		border-radius: 3px;
		text-align: center;
  		text-decoration: none;
  		display: inline-block;
  		color: white;
	}
	.submit_button:hover{
		background: linear-gradient(#333333,#262626);
  		cursor:pointer;
	}
	#results{
		float: left;
	}
	.login_register{
		float: right;
		color: black;
		font-size: 20px;
		margin-right: 6%;
		margin-top: 50px;
		text-decoration: none;
	}
	
</style>
</head>
<body>
	<!-- Header -->
	<div class="header">
		<a href="HomePage.jsp">
		<img id="bookworm" src="bookworm.png">
		</a>
		<% if(session.getAttribute("user_success") == null){%>
		<a href="Register.jsp"><p class="login_register">Register</p></a>
		
		<a href="Login.jsp"><p class="login_register" style="margin-right: 20px;">Login</p></a>
		<%}%>
		
		<% if(session.getAttribute("user_success") != null){%>
		<a class="login_register" href="A3_Servlet_SignOut">Sign Out</a>
		
		<a href="Favorites.jsp">
		<p class="login_register" style="margin-right: 20px;">Profile</p>
		</a>
		
		<%}%>
	</div>
	<!-- /Header -->
	
	<!-- Search Engine Body  -->
	<div class="search_engine_background">
		<div class="search_engine_body">
			<h1 style="color: white;">BookWorm: Just a Mini Program... Happy Days!</h1>
			<p id="results" style="color: red; font-size: 20px; margin-top: -20px;"></p>
			<!-- Form  -->
			<form class="form" onsubmit="return validate()" method="GET" action="SearchResults.jsp">
				<input name="search" id="search_bar" style="width: 100%; height: 20px; font-size: 15px; padding: 5px;" type="text" placeholder="Search for you favorite book!">
				<div class="radio_button1_div">
					<input id="name" name="radio_button" type="radio" class="radio_button" value="name"><label style="color: white;"> Name</label> <br>
					<input id="author" name="radio_button" type="radio" class="radio_button" value="author"><label style="color: white;"> Author</label>
				</div>
				<div class="radio_button2_div">
					<input id="isbn" name="radio_button" type="radio" class="radio_button" value="isbn"><label style="color: white;"> ISBN</label> <br>
					<input id="publisher" name="radio_button" type="radio" class="radio_button" value="publisher"><label style="color: white;"> Publisher</label>
				</div>
				<input name="submit" class="submit_button" type="submit" value="Search!"/>
			</form>
			<!-- Form  -->
		</div>
	</div>
	<!-- /Search Engine Body  -->
	<script>
		function validate_signout(){
			var xhttp = new XMLHttpRequest();
			xhhtp.open("GET", "A3_Servlet_SignOut?", false);
			xhttp.send();
			if(xhttp.responseText.trim().length > 0){
				//document.getElementById("formerror").innerHTML = xhttp.responseText;
				return false;
			}
			return true;
		}
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