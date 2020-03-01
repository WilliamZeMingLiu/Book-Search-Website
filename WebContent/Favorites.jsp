<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Favorites</title>
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
	.results_for{
		text-align: center;
		font-size: 35px;
		color: grey;
		float: left;
		margin-left: 17.5%;
	}
	#name_h1{
		font-size: 30px;
		padding-left: 80px;
	}
	#author_ital{
		font-size: 20px;
		padding-left: 80px;
	}
	#summary_para{
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
	#empty{
		font-size: 30px;
		text-align: center;		
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
	
	<h1 id="results_for"style="font-size:30px; color: gray; text-align: center;"></h1>
	<!-- Book Table -->
		<table id="book_table" border="0">
		</table>
		<h1 id="empty">
		</h1>
		
	<!-- /Book Table -->

	<script>
		//Results for "" code
		var user_input = sessionStorage.getItem("user_input");
		document.getElementById("results_for").innerText += "<%=session.getAttribute("user_success")%>" + "'s favorites";
		
		var table = document.getElementById("book_table");		
		
		var xhttp = new XMLHttpRequest();
		var array;
		xhttp.onreadystatechange = function(){
			if(this.readyState == 4 && this.status == 200){	
				var string = this.responseText;
				array = string.split(",");
				for(i=0; i < array.length; i++){
					var xhttp = new XMLHttpRequest();
					xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes/" + array[i], false);
					xhttp.send();
					var text = xhttp.responseText;
					var data = JSON.parse(text);
					var book = {name : data.volumeInfo.title,
							author : data.volumeInfo.authors[0],
							summary: data.volumeInfo.description,
							picture : data.volumeInfo.imageLinks.thumbnail,
							id : data.id}	
					
					var database = JSON.stringify(book);
					data = JSON.parse(database);
					
					var newRow = table.insertRow(table.length);
					newRow.setAttribute("id", array[i]);
					for(j=0; j < 2; j++){
						var cell = newRow.insertCell(j);
						if(j==0){
							var img = document.createElement("img");
							var link = document.createElement("a");
							
							link.setAttribute("href", "Details.jsp");
							link.setAttribute("onclick", "linkTag(this)");	
							
							img.setAttribute('name', data['id']);
							img.setAttribute("src", "Details.jsp");
							img.setAttribute('src', data['picture']);
							img.setAttribute('width', "180");
							link.appendChild(img);
							cell.appendChild(link);
						}
						else{
							//Favorite/remove button
							var button = document.createElement("button");
							button.setAttribute("type", "button");
							button.setAttribute("id", "favorite_button");
							button.setAttribute("name", data['id']);
							
							//validate_favorite(data[i]['id']);
							var xhttp = new XMLHttpRequest();
							xhttp.onreadystatechange = function(){
								button.innerHTML = "⭑ Remove";
								button.setAttribute("onclick", "deleteBook(this)");	
							}
							xhttp.open("GET", "A3_Servlet_Favorite?bookID=" + data['id'], true);
							xhttp.send();
							
							//Title
							var h1 = document.createElement("h1");
							h1.setAttribute('id', 'name_h1');
							h1.append(data['name'] + '\n');
							
							//Author
							var ital = document.createElement("i");
							ital.setAttribute('id', 'author_ital');
							ital.append(data['author'] + '\n');
							
							//Summary				
							var bold_summary = document.createElement("b");
							bold_summary.setAttribute('id', 'bold_summary');					
							bold_summary.append("Summary: ");
							
							var para = document.createElement("p");
							para.setAttribute('id', 'summary_para');		
							para.appendChild(bold_summary);
							
							if(data['summary'] == null){
								para.append("There is no summary for given book." + '\n');
							}
							else{
								para.append(data['summary'].replace( /(<([^>]+)>)/ig, '') + '\n');
							}
							
							//Appending to cell
							cell.appendChild(h1);
							cell.appendChild(ital);
							cell.appendChild(para);
							cell.append(button);
						}
					}
				}
			}
		}
		xhttp.open("GET", "A3_Servlet_printAll?name=" + "<%=session.getAttribute("user_success")%>", true);
		xhttp.send();
		
		function deleteBook(button){
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function(){
				if(this.readyState == 4 && this.status == 200){
					var tableRows = table.getElementsByTagName('tr');
					for(i=0; i < tableRows.length; i++){
						if(tableRows[i].id == button.name){
							table.deleteRow(i);
						}
					}
					//button.innerHTML = "⭑ " + this.responseText;
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