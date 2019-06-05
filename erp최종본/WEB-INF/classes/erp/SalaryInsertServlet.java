package erp;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SalaryInsertServlet
 */
@WebServlet("/erp/salaryInsertServlet")
public class SalaryInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalaryInsertServlet() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		SalaryMgr mgr = new SalaryMgr();
		mgr.insertSalary(request);
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("opener.window.location.reload();");	
		out.println("self.close();");
		out.println("</script>");
	}

}
