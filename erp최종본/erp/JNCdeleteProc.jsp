<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="jobnoticeMgr" class="erp.JobNoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	int jnc_num = Integer.parseInt(request.getParameter("jnc_num"));
	boolean result = jobnoticeMgr.deleteNComment(jnc_num);
	int jtc_idx = Integer.parseInt(request.getParameter("jtc_idx"));
	
	if(result){
			response.sendRedirect("Jread.jsp?jtc_idx="+jtc_idx);
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
		
	

	
