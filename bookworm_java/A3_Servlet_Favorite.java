package liu994_CSCI201L_Assignment3;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import java.net.*;
import javax.servlet.*;
import javax.servlet.http.*;

@WebServlet("/A3_Servlet_Favorite")
public class A3_Servlet_Favorite extends HttpServlet {
	private static final long serialVersionUTD = 1L;
	public A3_Servlet_Favorite() {
		super();
		System.out.println("in constructor");
	}
	public void init() throws ServletException{
		System.out.println("in init");
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		String bookID = request.getParameter("bookID");
		HttpSession session = request.getSession();
		
		response.setContentType("text/html");
		
		JDBC_Driver.connect();
		if(!String.valueOf(session.getAttribute("user_success")).equals(null)){
			if(JDBC_Driver.checkFavorite(String.valueOf(session.getAttribute("user_success")), bookID)) {
				response.getWriter().write("Remove");
			}
			else {
				response.getWriter().write("Favorite");
			}
		}
		JDBC_Driver.close();
	}
}