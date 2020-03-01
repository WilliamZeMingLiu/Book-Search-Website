package liu994_CSCI201L_Assignment3;
import java.io.IOException;

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

@WebServlet("/A3_Servlet_SignOut")
public class A3_Servlet_SignOut extends HttpServlet {
	private static final long serialVersionUTD = 1L;
	public A3_Servlet_SignOut() {
		super();
		System.out.println("in constructor");
	}
	public void init() throws ServletException{
		System.out.println("in init");
	}
	protected void service(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
String next = "/HomePage.jsp";
		HttpSession session = request.getSession();
		
		JDBC_Driver.connect();
		session.setAttribute("user_success", null);

		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		dispatch.forward(request, response);
		JDBC_Driver.close();
	}
}