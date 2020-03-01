<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Details</title>
<link href="https://use.fontawesome.com/releases/v5.0.1/css/all.css" rel="stylesheet">
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
	#name_h1{
		font-size: 30px;
		padding-left: 80px;
	}
	#author_ital{
		font-size: 20px;
		padding-left: 80px;
	}
	#para_publisher{
		font-size: 17.5px;
		padding-left: 80px;
	}
	#para_date{
		font-size: 17.5px;
		padding-left: 80px;
	}
	#para_date{
		font-size: 17.5px;
		padding-left: 80px;
	}
	#para_isbn{
		font-size: 17.5px;
		padding-left: 80px;
	}
	#summary_para{
		font-size: 15px;
		padding-left: 80px;
	}
	#bold_star{
		font-size: 15px;
		padding-left: 80px;
	}
	table { 
        border-collapse: collapse; 
        border-top: 1px #e6e6e6 solid;
    }
	td:nth-child(2){
		vertical-align: top;
	}
	#book_table{
		width:80%; 
    	margin-left:10%; 
    	margin-right:10%;
    	border-collapse: separate;
    	border-spacing: 0 25px;
	}
	td{
		border-bottom: 1px #e6e6e6 solid;
		padding-bottom: 25px;
	}
	.stars-outer {
	  display: inline-block;
	  position: relative;
	  font-family:'Font Awesome 5 Free';
	}
	 
	.stars-outer::before {
	  content: "\f005 \f005 \f005 \f005 \f005";
	  color: gray;
	}
	 
	.stars-inner {
	  position: absolute;
	  top: 0;
	  left: 0;
	  white-space: nowrap;
	  overflow: hidden;
	  width: 0;
	}
	 
	.stars-inner::before {
	  content: "\f005 \f005 \f005 \f005 \f005";
	  color: #f8ce0b;
	  font-weight: 900;
	}
	#favorite_button{
		margin: auto;
		display: block;
		margin-top: 10px;
		width: 20;
	}
	#favorite_button:hover{
		box-shadow: 0.5px 0.5px 3px black;
  		cursor:pointer;
	}
	#error{
		text-align: center;
		margin-top: 10px;
		font-size: 15px;
		color: red;
	}
</style>
</head>
<body>
	<!-- Header -->
	<div class="header">
		<a href="HomePage.jsp">
			<img id="bookworm" src="bookworm.png">
		</a>
		<% if(session.getAttribute("user_success") != null){%>		
		<a href="Favorites.jsp">
		<img src="logo_icon.jpg" alt="Profile" style="width: 50px; margin-top: 23px;">
		</a>
		<%}%>
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
	
	<!-- Book Table -->
		<table id="book_table" border="0">
		</table>
		
	<!-- /Book Table -->
	<script>		
		var data = JSON.parse(sessionStorage.getItem("database"));
		var book_raw = sessionStorage.getItem("book_raw");
		var table = document.getElementById("book_table");
		book_raw = book_raw.substring(11);
		book_raw = book_raw.substring(0,12);
		
		
		var xhttp = new XMLHttpRequest();
		xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes/" + book_raw, false);
		xhttp.send();
		var text = xhttp.responseText;
		var single = JSON.parse(text);
		var book = {name : single.volumeInfo.title,
				author : single.volumeInfo.authors[0],
				summary: single.volumeInfo.description,
				picture : single.volumeInfo.imageLinks.thumbnail,
				publisher: single.volumeInfo.publisher,
				date : single.volumeInfo.publishedDate,
				isbn : single.volumeInfo.industryIdentifiers[0].identifier,
				rating : single.volumeInfo.averageRating,
				id : single.id}	
		
		var database = JSON.stringify(book);
		single = JSON.parse(database);
		
		var newRow = table.insertRow(table.length);
		for(j=0; j < 2; j++){
			var cell = newRow.insertCell(j);
			if(j==0){			
				var error = document.createElement("p");
				error.setAttribute("id", "error");
				
				//Favorite/remove button
				var button = document.createElement("button");
				button.setAttribute("type", "button");
				button.setAttribute("id", "favorite_button");
				button.setAttribute("name", single['id']);
				
				
				//validate_favorite(data[i]['id']);
				<% String error = String.valueOf(session.getAttribute("user_success"));%>
				var error_check = "<%=error%>"
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function(){
					if(this.readyState == 4 && this.status == 200){
						button.innerHTML = "⭑ " + this.responseText;
						if(button.innerHTML == "⭑ Favorite"){
							button.setAttribute("onclick", "addBook(this)")
						}
						else{
							button.setAttribute("onclick", "deleteBook(this)")
						}
						if(error_check == "null"){
							button.setAttribute("onclick", "printError(this)");
						}		
					}
				}
				xhttp.open("GET", "A3_Servlet_Favorite?bookID=" + single['id'], true);
				xhttp.send();
				
				
				var img = document.createElement("img");
				var link = document.createElement("a");
				link.setAttribute("onclick", "linkTag(this)");
				img.setAttribute('name', single['id']);
				link.setAttribute("href", "SearchResults.jsp");
				img.setAttribute('src', single['picture']);
				
				img.setAttribute('width', "180");
				link.appendChild(img);
				cell.appendChild(link);
				cell.appendChild(button);
				cell.appendChild(error);
			}
			else{					
				//Name
				var h1 = document.createElement("h1");
				h1.setAttribute('id', 'name_h1');
				h1.append(single['name'] + '\n');
				
				
				//Author
				var ital = document.createElement("i");
				ital.setAttribute('id', 'author_ital');
				ital.append("Author: " + single['author'] + '\n');

				//Publisher
				var ital_publisher = document.createElement("i");
				ital_publisher.setAttribute('id', 'ital_publisher');					
				ital_publisher.append("Publisher: ");
				
				var para_publisher = document.createElement("p");
				para_publisher.setAttribute('id', 'para_publisher');		
				para_publisher.appendChild(ital_publisher);
				para_publisher.append(single['publisher'] + '\n');
				
				
				//Date
				var ital_date = document.createElement("i");
				ital_date.setAttribute('id', 'ital_date');					
				ital_date.append("Published Date: ");
				
				var para_date = document.createElement("p");
				para_date.setAttribute('id', 'para_date');		
				para_date.appendChild(ital_date);
				para_date.append(single['date'] + '\n');
				
				
				//ISBN
				var ital_isbn = document.createElement("i");
				ital_isbn.setAttribute('id', 'ital_isbn');					
				ital_isbn.append("ISBN: ");
				
				var para_isbn = document.createElement("p");
				para_isbn.setAttribute('id', 'para_isbn');		
				para_isbn.appendChild(ital_isbn);
				para_isbn.append(single['isbn'] + '\n');
				
				//Summary
				var bold_summary = document.createElement("b");
				bold_summary.setAttribute('id', 'bold_summary');					
				bold_summary.append("Summary: ");
				
				var para = document.createElement("p");
				para.setAttribute('id', 'summary_para');		
				para.appendChild(bold_summary);
				if(single['summary'] == null){
					para.append("There is no summary for given book." + '\n');
				}
				else{
					para.append(single['summary'].replace( /(<([^>]+)>)/ig, '') + '\n');
				}
				
				//Star
				var bold_star = document.createElement("b");
				bold_star.setAttribute('id', 'bold_star');
				bold_star.append("Rating: ");
				if(single['rating'] == null){
					var rating_no = document.createElement("p");
					rating_no.setAttribute('id', 'rating_no');		
					rating_no.appendChild(bold_star);
					rating_no.append("There is no rating for given book." + '\n');
				}
				else{
					var star_out = document.createElement("div");
					star_out.setAttribute('class', "stars-outer");
					var star_in = document.createElement("div");
					star_in.setAttribute('class', "stars-inner");
					star_in.setAttribute('id', "stars");
					star_out.appendChild(star_in);
					bold_star.appendChild(star_out);
				}
				 
				//Appending everything to cell
				cell.appendChild(h1);
				cell.appendChild(ital);
				cell.appendChild(para_publisher);
				cell.appendChild(para_date);
				cell.appendChild(para_isbn);
				cell.appendChild(para);
				
				if(single['rating'] == null){
					cell.appendChild(rating_no);
				}
				else{
					cell.appendChild(bold_star);
					const starPercentage = (single['rating'] / 5) * 100;
					document.querySelector("div.stars-inner").style.width = starPercentage + '%'; 
				}
			}		
		}

		function checkBook(book_raw, callback){
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "A3_Servlet_checkBook?name=" + "<%=session.getAttribute("user_success")%>" + "&bookID=" 
					+ book_raw,true);
			xhttp.send();
			xhttp.onreadystatechange = function(){
				if(this.readyState == 4 && this.status == 200){
					bool = xhttp.responseText;
				}
			}
		}
		
		function printError(button){
			document.getElementById("error").innerHTML = "Error, please log in";
		}
		function addBook(button){
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function(){
				if(this.readyState == 4 && this.status == 200){
					button.innerHTML = "⭑ " + this.responseText;
					button.setAttribute("onclick", "deleteBook(this)");
				}
			}
			xhttp.open("GET", "A3_Servlet_addBook?name=" + "<%=session.getAttribute("user_success")%>" + "&bookID=" 
					+ button.name,true);
			xhttp.send();
		}
		function deleteBook(button){
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function(){
				if(this.readyState == 4 && this.status == 200){
					button.innerHTML = "⭑ " + this.responseText;
					button.setAttribute("onclick", "addBook(this)");
				}
			}
			xhttp.open("GET", "A3_Servlet_deleteBook?name=" + "<%=session.getAttribute("user_success")%>" + "&bookID=" 
					+ button.name,true);
			xhttp.send();
		}
		
		function linkTag(a){
			sessionStorage.setItem("book_raw", a.innerHTML);
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