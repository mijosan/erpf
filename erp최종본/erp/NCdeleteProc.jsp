<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="noticeMgr" class="erp.NoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	int nc_num = Integer.parseInt(request.getParameter("nc_num"));
	boolean result = noticeMgr.deleteNComment(nc_num);
	int ntc_idx = Integer.parseInt(request.getParameter("ntc_idx"));
	
	if(result){
		response.sendRedirect("read.jsp?ntc_idx="+ntc_idx);
		out.print("opener.location.reload()");
	}else{
		%>
		<script>
			alert("삭제가 되지 않았습니다");
			history.back();
		</script>
<%}
} else {
		response.sendRedirect("erpLogin.jsp");
	}%>
		
	

	
