<%@ page language="java" contentType="text/html; charset=utf-8"%>
<jsp:useBean id="insertBean" class="erp.P_insertBean"/>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:setProperty property="*" name="insertBean"/>
<jsp:useBean id="PMgr" class="erp.ProductMgr"/>
<%
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
		String[]p_num = insertBean.getP_num();

		boolean result = false;
		String close = "";
		String reload = "";
		
		for(int i = 0; i < p_num.length; i++) {
			if(p_num[i].equals("0")) {
				break;
			}else {
				result = PMgr.insertProduct(insertBean);
				close = "self.close()";
				reload = "opener.location.reload()";
				break;
			}
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