package erp;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateStateServlet
 */
@WebServlet("/erp/updateStateServlet")
public class UpdateStateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateStateServlet() {
        super();      
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		SalaryMgr mgr = new SalaryMgr();
		String salary_num = request.getParameter("salary_num");
		String salary_state = request.getParameter("salary_state");
		mgr.stateUpdate(salary_num,salary_state);		
		response.sendRedirect("salaryPage.jsp");
	}
}
