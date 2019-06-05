<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="jobnoticeMgr" class="erp.JobNoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	String jtc_title = request.getParameter("subject");
	String jtc_content = request.getParameter("content");
	int jtc_idx = Integer.parseInt(request.getParameter("jtc_idx"));
	
	boolean result = jobnoticeMgr.setNotice(jtc_idx,jtc_title,jtc_content);
	
	if(result){
		%>		
			<script>
				alert("수정이 완료 되었습니다.");
				location.href="Jread.jsp?jtc_idx="+<%=jtc_idx%>;
				opener.location.reload();
			</script>
		<%
	}else{
		%>
			<script>
				alert("수정이 되지 않았습니다.");
				location.href="Jupdate.jsp?jtc_idx="+<%=jtc_idx%>;
			</script>
		<%
	}
} else {
	response.sendRedirect("erpLogin.jsp");
}
%>
