<%@ page contentType="text/html; charset=utf-8"%>\
<jsp:useBean id="mgr" class="erp.AnonyBoardMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////

	String ac_comment = request.getParameter("ac_comment");
	int any_idx = Integer.parseInt(request.getParameter("any_idx"));
	String ac_name = request.getParameter("ac_name");
	int emp_num = Integer.parseInt(request.getParameter("emp_num"));
	
	boolean result = mgr.setNComment(any_idx, ac_name, ac_comment, emp_num);

	if(result){

		//response.sendRedirect("AnonyRead.jsp?any_idx="+any_idx);
		%>
		<script>
			opener.location.reload();
			location.href="AnonyRead.jsp?any_idx=<%=any_idx%>";
		</script>
		<%
	}else{
%>
	<script>
		alert("댓글이 입력되지 않았습니다");
		location.href="read.jsp?any_idx="+<%=any_idx%>;
	</script>

	<%}
	} else {
		response.sendRedirect("erpLogin.jsp");
	}%>