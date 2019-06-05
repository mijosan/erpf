package erp;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/erp/sendmessage")
public class SendMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String who = request.getParameter("who");
		
		if ( who.equals("전체검색") ) {
			// 전체 검색 내용 보여주기
			response.getWriter().write(getAllList());
		} else if ( who == null || who.equals("") ) {
			response.getWriter().write("");
		} else {
			// 나머지 검색 정보 보여주기
			response.getWriter().write(getsempList(who));
		}				
	}
	
	public String getsempList(String who) {
		StringBuffer list = new StringBuffer();
		MessageMgr msgMgr = new MessageMgr();
		Vector<DeptEmpBean> empList = msgMgr.getSempList(who);
		if ( empList.size() == 0 )
			return "";
		list.append("{\"sempList\":[");
		for ( int i = 0; i < empList.size(); i++ ) {
			DeptEmpBean empBean = empList.get(i);
			list.append("{\"dept\": \"" + empBean.getDept() + "\",");
			list.append("\"emp_num\": \"" + empBean.getEmp_num() + "\",");
			list.append("\"emp_name\": \"" + empBean.getEmp_name() + "\"}");
			if ( i != empList.size() -1 ) {
				list.append(",");
			}
		}
		list.append("]}");
		
		return list.toString();
	}
	
	public String getAllList() {
		
		StringBuffer list = new StringBuffer();
		list.append("{\"deptList\":[");
		MessageMgr msgMgr = new MessageMgr();
		Vector<DeptBean> deptList = msgMgr.getDeptList();
		if ( deptList.size() == 0 ) {
			return "";
		} else {
			for (int i = 0; i < deptList.size(); i++) {
				DeptBean dBean = deptList.get(i);
				list.append("{\"dept\": \"" + dBean.getDept() + "\",");
				list.append("\"empCount\": \"" + dBean.getEmpCount() + "\"}");
			if ( i != deptList.size() -1 ) 
				list.append(",");
			}
			list.append("],");
		}
		list.append("\"empList\": [");
		Vector<DeptEmpBean> empList = msgMgr.getEmpList();
		
		if ( empList.size() == 0 ) {
			return "";
		} else {
			int dele = 0;
			int j = 0;
			for ( int i = 0; i < deptList.size(); i++ ) {
				DeptBean deptBean = deptList.get(i);
				dele += deptBean.getEmpCount();
				for ( ; j < dele; j++) {
					DeptEmpBean empBean = empList.get(j);
					list.append("{\"dept\": \"" + empBean.getDept() + "\",");
					list.append("\"emp_num\": \"" + empBean.getEmp_num() + "\",");
					list.append("\"emp_name\": \"" + empBean.getEmp_name() + "\"}");
					if ( j != empList.size() -1 ) {
						list.append(",");
					}
				}
			}
			list.append("]}");
		}
			return list.toString();
	}
	

	
	
}
