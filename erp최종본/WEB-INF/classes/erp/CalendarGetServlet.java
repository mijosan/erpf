package erp;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class CalendarGetServlet
 */
@WebServlet("/erp/calendarGetServlet")
public class CalendarGetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public CalendarGetServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		Vector<CalendarBean> vlist = new Vector<CalendarBean>();
		CalendarMgr mgr = new CalendarMgr();
		vlist = mgr.getCalendar();		
		response.setContentType("application/json");
	    response.setCharacterEncoding("EUC-KR");
	    PrintWriter out = response.getWriter();
	    out.write(new Gson().toJson(vlist));
	}

}
