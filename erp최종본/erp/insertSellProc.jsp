<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="insertBean" class="erp.S_insertBean"/>
<jsp:setProperty property="*" name="insertBean"/>
<jsp:useBean id="SMgr" class="erp.SellMgr"/>
<%
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////

		String[] s_customer = insertBean.getS_customer();
		boolean result = false;
		String close = "";
		String reload = "";
		
		
		for(int i = 0; i < s_customer.length; i++) {
			if(s_customer[i].equals("0")) {
				break;
			}else {
				result = SMgr.insertSellList(insertBean);
				close = "self.close()";
				reload = "opener.location.reload()";
				break;
			}
		}
		
%>
<script>
<%=close%>
<%=reload%>
</script>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>
