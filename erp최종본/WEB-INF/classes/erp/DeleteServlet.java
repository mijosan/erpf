package erp;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteServlet
 */
@WebServlet("/erp/deleteServlet")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");
		EmployeeMgr mgr = new EmployeeMgr();
		String str = request.getParameter("selectedBox");		
		
		String[] array;
		array = str.split("-");	//-�� �������� ���ڿ��� �ڸ� �Ŀ� ��Ʈ�� �迭�� �־��ش�.
		int [] arr = new int[array.length];
		for (int i = 0; i < arr.length; i++) {
			arr[i] = Integer.parseInt(array[i]);	//�ڸ� ���ڿ��� ��Ƽ���� ��ȯ�� �� ���������� ����ڽ�.
		}
		mgr.deleteEmployee(arr); //������ �迭�� �Լ��� �Ѱ���.
		response.sendRedirect("hrMenu.jsp"); //�Ϸ� �Ŀ��� �ٽ� �������� �����̷�Ʈ
	}
}
