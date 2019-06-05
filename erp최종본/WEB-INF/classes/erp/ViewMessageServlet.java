package erp;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/erp/viewmessage")
public class ViewMessageServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String how = request.getParameter("how");
		int idx = Integer.parseInt(request.getParameter("idx"));

		if ( how == null || how.equals("") || idx < 0 ) {
			response.getWriter().write("");
		} else if ( how.equals("삭제") ) {
			response.getWriter().write(delView(idx));
		}
	}

	public String delView(int idx) {
		boolean flag = new MessageMgr().delView(idx);
		if ( flag == true )
			return "";
		else 
			return "성공쓰";
	}
}
