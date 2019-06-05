package erp;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CalendarServlet
 */
@WebServlet("/erp/calendarServlet")
public class CalendarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	boolean result = false;
    public CalendarServlet() {
        super();
        
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String calendar_title = request.getParameter("calendar_title");
		String calendar_start_date = request.getParameter("calendar_start_date");
		String calendar_end_date = request.getParameter("calendar_end_date");
		System.out.println(calendar_title+calendar_start_date+calendar_end_date);
		CalendarMgr mgr = new CalendarMgr();
		result = mgr.insertCalendar(calendar_title, calendar_start_date, calendar_end_date);
		String gogo ="";
		if(result) {
			gogo="true";
		}else {
			gogo="false";
		}
		response.getWriter().write(gogo);
	}
	
}
