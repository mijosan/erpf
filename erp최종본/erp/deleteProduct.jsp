<%@page import="erp.EmployeeBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<jsp:useBean id="PMgr" class="erp.ProductMgr"/>
<%
		request.setCharacterEncoding("utf-8");
		EmployeeBean Ebean = (EmployeeBean)session.getAttribute("employeeBean");
		if(Ebean.getEmp_dept().equals("생산부") || Ebean.getEmp_job().equals("이사")) {
			
		String[] str = request.getParameterValues("checkbox");
		for(int i = 0; i < str.length; i++) {
			PMgr.deleteProduct(str[i]);
		}
%>
<script>
location.href="product.jsp";
</script>

<%}else {%>
<script>
history.back();
alert("생산 제품에 대한 삭제 권한이 없습니다.");
</script>
<%}%>