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


@WebServlet("/A3_Servlet_printAll")
public class A3_Servlet_printAll extends HttpServlet {
	private static final long serialVersionUTD = 1L;
	public A3_Servlet_printAll() {
		super();
		System.out.println("in constructor");
	}
	public void init() throws ServletException{
		System.out.println("in init");
	}
	protected void service(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		String name = request.getParameter("name");
		
		response.setContentType("text/html");
		
		JDBC_Driver.connect();
		ArrayList<String> array = JDBC_Driver.printFavorite(name);
		
		for(int i=0; i < array.size(); i++) {
			response.getWriter().write(array.get(i));
			if(i != array.size()-1) {
				response.getWriter().write(",");
			}
			
		}
		
		//RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		//dispatch.forward(request, response);
		JDBC_Driver.close();
	}
}