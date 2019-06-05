<%@page import="erp.EmployeeBean"%>
<%@page import="erp.LogMgr"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	EmployeeBean employeeBean = (EmployeeBean)session.getAttribute("employeeBean");
	LogMgr logmgr = new LogMgr();
	logmgr.insertLogBoard("Out", employeeBean);
	session.invalidate();
	//response.sendRedirect("erpLogin.jsp");
%>
<script>
	location.replace("erpLogin.jsp");
</script>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>