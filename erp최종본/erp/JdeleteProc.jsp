<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="jobnoticeMgr" class="erp.JobNoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	int jtc_idx = Integer.parseInt(request.getParameter("jtc_idx"));
	boolean result = jobnoticeMgr.deleteNotice(jtc_idx);
	
	if(result){jobnoticeMgr.deleteAllNComment(jtc_idx);%>
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
			location.href="Jread.jsp?jtc_idx="+<%=jtc_idx%>;
		</script>
<%}
} else {
		response.sendRedirect("erpLogin.jsp");
	}%>
		
	

	
