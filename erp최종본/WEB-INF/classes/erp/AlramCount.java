package erp;

import java.io.IOException;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AlramCount
 */
@WebServlet("/erp/alramCount")
public class AlramCount extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		int toID = Integer.parseInt(request.getParameter("id"));
		//int toID = 2;
		if (toID == 0 || toID == -1) {
			response.getWriter().write("");
		} else {
			response.getWriter().write(getC(toID));
		}
	}
	
	public String getC(int toID) {
		MessageMgr messageMgr = new MessageMgr();
		int count = messageMgr.getCount(toID);
		String result = "{\"result2\": \"" + count +"\"}";
		return result;
	}

}
