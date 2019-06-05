package erp;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CertUpdateStateServlet
 */
@WebServlet("/erp/certUpdateStateServlet")
public class CertUpdateStateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CertUpdateStateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		certifiMgr mgr = new certifiMgr();
		mgr.stateUpdate(Integer.parseInt(request.getParameter("cer_num")), request.getParameter("cer_state"));
		response.sendRedirect("certification.jsp");
	}

}
