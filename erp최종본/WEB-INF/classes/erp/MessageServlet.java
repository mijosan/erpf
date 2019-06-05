package erp;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/erp/message")
public class MessageServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		int id = Integer.parseInt(request.getParameter("id"));
		int how = Integer.parseInt(request.getParameter("how"));
		if ( how >= 1) {
			response.getWriter().write(getList(id, how));
		} else if ( id == 0 || how == 0 ) {
			response.getWriter().write("");
		} else {
			response.getWriter().write("");
		}		
	}
	
	public String getList(int id, int how) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		MessageMgr msgMgr = new MessageMgr();
		Vector<MessageBean> msgList = new Vector<MessageBean>();
		if ( how == 1 ) {
			msgList = msgMgr.getAllMsglist(id);
		} else if ( how == 2 ) {
			msgList = msgMgr.getNoConMsglist(id);
		} else if ( how == 3 ) {
			msgList = msgMgr.getYesConMsglist(id);
		} else if ( how == 4 ) {
			msgList = msgMgr.getSendMsglist(id);
		}
		if ( msgList.size()== 0 ) {
			return "";
		} else {
			for ( int i = 0; i < msgList.size(); i++ ) {
				MessageBean msgBean = msgList.get(i);
				result.append("{\"idx\": \"" + msgBean.getMsg_idx() + "\",");
				result.append("\"content\": \"" + msgBean.getMsg_content() + "\",");
				if ( how != 4 ) {
					result.append("\"send\": \"" + msgMgr.getSender(msgBean.getMsg_send()) + "\",");
				} else {
					result.append("\"send\": \"" + msgMgr.getSender(msgBean.getMsg_to()) + "\",");
				}
				result.append("\"senddate\": \"" + msgBean.getMsg_senddate() + "\",");
				result.append("\"condate\": \"" + msgBean.getMsg_condate() + "\"}");
				if ( i != msgList.size() -1 ) 
					result.append(","); 
			}
			result.append("]}");
			System.out.println(result.toString());
			return result.toString();
		}
	}


}
