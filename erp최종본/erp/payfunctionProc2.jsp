<%@page import="java.util.StringTokenizer"%>
<%@page import="erp.HolidayMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	int holi_idx = Integer.parseInt(request.getParameter("holi_idx"));
	System.out.println(holi_idx);
	HolidayMgr mgr = new HolidayMgr();
	boolean result = mgr.stateUpdate(holi_idx);
	
	if(result==true){
		%>
			<script>
				window.opener.location.reload();
				self.close();
			</script>
		<%
	} 
} else {
	response.sendRedirect("erpLogin.jsp");
}
%>
	
