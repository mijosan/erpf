<%@page import="erp.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
%>
<jsp:useBean id="Pbean" class="erp.ProductBean"/>
<jsp:setProperty property="*" name="Pbean"/>
<jsp:useBean id="PMgr" class="erp.ProductMgr"/>

<%
		int i = UtilMgr.getInt(request, "add_num");
		
		boolean result = PMgr.updateProduct(Pbean);
		String close = "";
		String reload = "";
		
		if(result) {
			reload = "opener.location.reload()";
			close = "self.close()";
		}
%>
<script>
<%=reload%>
<%=close%>
</script>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>