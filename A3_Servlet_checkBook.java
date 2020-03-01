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

import java.util.ArrayList;


@WebServlet("/A3_Servlet_checkBook")
public class A3_Servlet_checkBook extends HttpServlet {
	private static final long serialVersionUTD = 1L;
	public A3_Servlet_checkBook() {
		super();
		System.out.println("in constructor");
	}
	public void init() throws ServletException{
		System.out.println("in init");
	}
	protected void service(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		String name = request.getParameter("name");
		String bookID = request.getParameter("bookID");
		
		response.setContentType("text/html");
		
		//String next = "/Details.jsp";		
		JDBC_Driver.connect();
		
		//User does not exist
		if(name != null) {
			if(JDBC_Driver.checkFavorite(name, bookID)) {				
				response.getWriter().write("Favorite");
			}
		}
		JDBC_Driver.close();
	}
}