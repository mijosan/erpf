<%@page import="erp.EmployeeBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<jsp:useBean id="SMgr" class="erp.SellMgr"/>
<jsp:useBean id="UtilMgr" class="erp.UtilMgr"/>
<%

		EmployeeBean Ebean = (EmployeeBean)session.getAttribute("employeeBean");
		if(Ebean.getEmp_dept().equals("영업부") || Ebean.getEmp_job().equals("이사")) {
			
		request.setCharacterEncoding("utf-8");
		 String[] str = request.getParameterValues("checkbox");
		int[] sellnum = UtilMgr.toInt(str);
		for(int i = 0; i < sellnum.length; i++) {
			SMgr.deleteSell(sellnum[i]);
		}
%>
<script>
location.href="searchSell.jsp";
</script>

<%}else {%>
<script>
history.back();
alert("판매 제품 삭제에 대한 접근 권한이 없습니다.");
</script>
<%}%>