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
		array = str.split("-");	//-를 기준으로 문자열을 자른 후에 스트링 배열에 넣어준다.
		int [] arr = new int[array.length];
		for (int i = 0; i < arr.length; i++) {
			arr[i] = Integer.parseInt(array[i]);	//자른 문자열을 인티져로 변환한 후 정수형으로 오토박싱.
		}
		mgr.deleteEmployee(arr); //정수형 배열을 함수로 넘겨줌.
		response.sendRedirect("hrMenu.jsp"); //완료 후에는 다시 페이지로 리다이렉트
	}
}
