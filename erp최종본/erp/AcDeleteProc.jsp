<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="mgr" class="erp.AnonyBoardMgr"/>
<% 
	request.setCharacterEncoding("utf-8");

	////////////////////////////////////////////
	if (session.getAttribute("idKey") != null) {
	int id = (Integer) session.getAttribute("idKey");
	/////////////////////////////////////////////
	
	int ac_num = Integer.parseInt(request.getParameter("ac_num"));
	boolean result = mgr.deleteNComment(ac_num);
	int any_idx = Integer.parseInt(request.getParameter("any_idx"));
	
	if(result){
		response.sendRedirect("AnonyRead.jsp?any_idx="+any_idx);
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
		
	

	
