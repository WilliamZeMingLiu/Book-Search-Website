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


@WebServlet("/A3_Servlet_Register")
public class A3_Servlet_Register extends HttpServlet {
	private static final long serialVersionUTD = 1L;
	public A3_Servlet_Register() {
		super();
		System.out.println("in constructor");
	}
	public void init() throws ServletException{
		System.out.println("in init");
	}
	protected void service(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirm_password = request.getParameter("confirm_password");
		
		String next = "/HomePage.jsp";
		HttpSession session = request.getSession();
		
		JDBC_Driver.connect();
		session.setAttribute("register_error", null);
		
		//User does not exist
		if(!JDBC_Driver.checkUser(username)) {
			//If confirm password == password
			if(password.equals(confirm_password)) {
				JDBC_Driver.addUser(username, password);
				session.setAttribute("user_success", username);
			}
			//If it does not
			else {
				next = "/Register.jsp";
				session.setAttribute("register_error", "password_match");
			}
			
		}
		//User does exist
		else {
			next = "/Register.jsp";
			session.setAttribute("register_error", "user_exist");
		}
		
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		dispatch.forward(request, response);
		JDBC_Driver.close();
	}
}