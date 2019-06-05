package erp;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/erp/goreally")
public class GoReally extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String content = request.getParameter("smsg");
		int send = Integer.parseInt(request.getParameter("send"));
		String to = request.getParameter("to");

		if ( content == null || content.equals("") || send < 0 || to == null || to.equals("") ) {
			response.getWriter().write("");
		} else {
			response.getWriter().write(sendGo(send, to, content));
		}
	}
	
	public String sendGo(int send, String to, String content) {
		MessageMgr msgMgr = new MessageMgr();
		MessageBean msgBean = new MessageBean();
		String msg_to[] = to.split("/");
		for ( int i = 0; i < msg_to.length; i++ ) {
			msgBean.setMsg_send(send);
			msgBean.setMsg_to(Integer.parseInt(msg_to[i]));
			msgBean.setMsg_content(content);
			boolean flag = msgMgr.addMsg(msgBean);
			if ( flag == true )
				return "";
		}
		
		return "¼º°ø¾²";
	}
}


















