<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="mgr" class="erp.AnonyBoardMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	String any_title = request.getParameter("subject");
	String any_content = request.getParameter("content");
	int any_idx = Integer.parseInt(request.getParameter("any_idx"));
	System.out.println(any_idx);
	boolean result = mgr.setNotice(any_idx,any_title,any_content);
	
	if(result){
		%>		
			<script>
				alert("수정이 완료 되었습니다.");
				location.href="AnonyRead.jsp?any_idx="+<%=any_idx%>;
				opener.location.reload();
			</script>
		<%
	}else{
		%>
			<script>
				alert("수정이 되지 않았습니다.");
				location.href="AnonyUpdate.jsp?any_idx="+<%=any_idx%>;
			</script>
		<%
	}
} else {
	response.sendRedirect("erpLogin.jsp");
}
%>
