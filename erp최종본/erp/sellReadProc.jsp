<%@ page language="java" contentType="text/html; charset=utf-8"%>
<jsp:useBean id="SMgr" class="erp.SellMgr"/>
<jsp:useBean id="UtilMgr" class="erp.UtilMgr"/>
<%
		request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
		int s_num = UtilMgr.getInt(request, "s_num");
		String p_name = request.getParameter("p_name");
		int p_quantity = UtilMgr.getInt(request, "p_quantity");
		String s_date = request.getParameter("s_date");
		String s_staff = request.getParameter("s_staff");
		int p_price = UtilMgr.getInt(request, "p_price");
		
		String close = "";
		String reload = "sellRead.jsp";
		boolean result = SMgr.updateSell(s_num, p_name, p_quantity, s_date, s_staff, p_price);
		if(result) {
			close = "self.close()";
			reload = "opener.location.reload()";
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