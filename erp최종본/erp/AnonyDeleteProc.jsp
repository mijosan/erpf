<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="mgr" class="erp.AnonyBoardMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	int any_idx = Integer.parseInt(request.getParameter("any_idx"));
	boolean result = mgr.deleteNotice(any_idx);
	
	if(result){
		mgr.deleteAllNComment(any_idx);%>
		<script>
			alert("삭제가 완료 되었습니다");
			self.close();
			opener.location.reload();
		</script>
		<% 
	}else{
		%>
		<script>
			alert("삭제가 되지 않았습니다");
			location.href="AnonyRead.jsp?any_idx="+<%=any_idx%>;
		</script>
<%}
} else {
		response.sendRedirect("erpLogin.jsp");
	}%>
		
	

	
