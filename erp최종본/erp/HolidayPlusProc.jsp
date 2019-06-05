<%@page import="erp.HolidayMgr"%>
<%@page import="erp.EmployeeBean"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	String holiday_first = request.getParameter("holiday_first");
	String holiday_end = request.getParameter("holiday_end");
	
	String holiday_date = holiday_first+" ~ "+holiday_end;

	String holiday_content = request.getParameter("holiday_content");

	EmployeeBean employeeBean = (EmployeeBean)session.getAttribute("employeeBean");
	HolidayMgr mgr = new HolidayMgr();
	
	boolean result = mgr.insertHoliday(holiday_date,employeeBean.getEmp_num(),employeeBean.getEmp_dept(),employeeBean.getEmp_name(),holiday_content);
	if(result==true){
%>
	<script>
		alert("등록 되었습니다.");
		window.close();
		opener.location.reload();
	</script>
	<%}else{ %>
	<script>
		alert("등록 되지 않았습니다.");
		history.back();
	</script>
<%}
} else {
		response.sendRedirect("erpLogin.jsp");
	}%>