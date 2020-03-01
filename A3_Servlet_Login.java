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


@WebServlet("/A3_Servlet_Login")
public class A3_Servlet_Login extends HttpServlet {
	private static final long serialVersionUTD = 1L;
	public A3_Servlet_Login() {
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
		
		String next = "/HomePage.jsp";
		HttpSession session = request.getSession();
		
		JDBC_Driver.connect();
		session.setAttribute("user_error", null);
		
		//If user exists
		if(JDBC_Driver.checkUser(username)) {
			//If password matches
			if(JDBC_Driver.checkPassword(username, password)) {
				session.setAttribute("user_success", username);
				System.out.println(username);
			}
			//If does not
			else {
				next = "/Login.jsp";
				session.setAttribute("user_error", "wrong_password");
			}
			
		}
		//If it does not
		else {
			next = "/Login.jsp";
			session.setAttribute("user_error", "user_exist");
		}
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		dispatch.forward(request, response);
		JDBC_Driver.close();
	}
}