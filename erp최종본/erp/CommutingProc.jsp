<%@page import="erp.LogMgr"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.*"%>
<%@page import="erp.EmployeeBean"%>
<%@page import="erp.HolidayMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	HolidayMgr holiMgr = new HolidayMgr();
	EmployeeBean employeeBean = (EmployeeBean)session.getAttribute("employeeBean");
	String commuting = request.getParameter("출퇴");
	boolean result = false;
	
	if (commuting.equals("출근")) {
		result = holiMgr.insertCommuting(employeeBean.getEmp_num(), employeeBean.getEmp_dept(), employeeBean.getEmp_name(), commuting);
	} else if (commuting.equals("퇴근")) {
		if (session.getAttribute("time") != null ) {
			result = holiMgr.insertCommuting(employeeBean.getEmp_num(), employeeBean.getEmp_dept(), employeeBean.getEmp_name(), commuting);
			LogMgr logMgr = new LogMgr();
			logMgr.insertLogBoard("Out", employeeBean);
		} else {
			result = false;
		}
	}
	if(result==true){
%>
	<script>
		alert("<%=commuting%>이 정상적으로 등록되었습니다");
		window.history.back();
	</script>
    	<%
    	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    	Date date = new Date();
    	String time = dateFormat.format(date);
    	if (commuting.equals("출근")) {
    		session.setAttribute("time", time);
    	} else {
    		session.setAttribute("time2", time);
    	}
} else { %>
	<script>
		alert("<%=commuting%>이 안됩니다.");
		window.history.back();
	</script>
<%}
} else {
		response.sendRedirect("erpLogin.jsp");
	}%>
