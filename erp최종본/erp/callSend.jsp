<%@page import="erp.GmailMgr"%>
<%@page import="erp.EmployeeBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	int id = (Integer) session.getAttribute("idKey");
	EmployeeBean employeeBean = (EmployeeBean) session.getAttribute("employeeBean");
	String result = request.getParameter("check");
	String content = request.getParameter("content");
	if (content.equals("")) {
		%>
		<script>
			window.history.back();
		</script>
		<%
	} else {
		String title = "[문의요청]" + employeeBean.getEmp_name() + " : " + result;
		content = "[" + result + "]" + "에 대한 문의내용입니다.\n" + content;
		String fromEmail = employeeBean.getEmp_email().trim();
		new GmailMgr().sendAccount(title, content, fromEmail);
	}
%>
<script>
window.history.back();
</script>