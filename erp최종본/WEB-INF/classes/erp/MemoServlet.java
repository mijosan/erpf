package erp;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/erp/memo")
public class MemoServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		int id = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String how = request.getParameter("how");
		String content = request.getParameter("content");
		if ( how.equals("전체목록") && title.equals("전체목록 타이틀") ) {
			response.getWriter().write(getList(id));
		} else if ( id == 0 || how.equals("") || how == null || title.equals("") || title == null ) {
			response.getWriter().write("");
		} else if ( how.equals("메모저장") ) {
			response.getWriter().write(saveMemo(id, title, content));
		} else if ( how.equals("메모조회") ) {
			response.getWriter().write(getMemo(id, title, content));
		} else if ( how.equals("메모삭제") ) {
			response.getWriter().write(delMemo(id, title, content));
		} else if ( how.equals("메모수정") ) {
			response.getWriter().write(upMemo(id, title, content));
		}
	}
	
	public String upMemo(int id, String title, String content) {
		String[] list = title.split(":");
		boolean flag = new MemoMgr().upMemo(id, list[0], list[1], content);
		if ( flag == true )
			return "";
		else 
			return "성공쓰";
	}
	
	public String delMemo(int id, String title, String date) {
		boolean flag = new MemoMgr().delMemo(id, title, date);
		if ( flag == true )
			return "";
		else 
			return "성공쓰";
	}
	
	public String getMemo(int id, String title, String content) {
		StringBuffer result = new StringBuffer("");
		MemoBean mBean = new MemoMgr().getMemo(id, title, content);
		result.append("{\"memo\": [");
		result.append("{\"id\": \"" + mBean.getEmp_num() + "\",");
		result.append("\"title\": \"" + mBean.getMem_title() + "\",");
		result.append("\"content\": \"" + mBean.getMem_content() + "\",");
		result.append("\"date\": \"" + mBean.getMem_date() + "\"}]}");		
		System.out.println(result.toString());
		return result.toString();
	}
	public String saveMemo(int id, String title, String content) {
		MemoBean mBean = new MemoBean();
		mBean.setEmp_num(id);
		mBean.setMem_title(title);
		mBean.setMem_content(content);
		boolean flag = new MemoMgr().addMemo(mBean);
		if ( flag == true )
			return "";
		return "성공쓰";
	}
	
	public String getList(int id) {
		StringBuffer list = new StringBuffer("");
		list.append("{\"mList\": [");
		Vector<MemoBean> mList = new MemoMgr().getList(id);
		if ( mList.size() == 0 ) {
			return "";
		}
		for ( int i = 0; i < mList.size(); i++ ) {
			MemoBean mBean = mList.get(i);
			list.append("{\"id\": \"" + mBean.getEmp_num() + "\",");
			list.append("\"title\": \"" + mBean.getMem_title() + "\",");
			list.append("\"content\": \"" + mBean.getMem_content() + "\",");
			list.append("\"date\": \"" + mBean.getMem_date() + "\"}");
			if ( i != mList.size() -1 ) 
				list.append(","); 
		}
		list.append("]}");
		System.out.println(list.toString());
		return list.toString();
	}

}
