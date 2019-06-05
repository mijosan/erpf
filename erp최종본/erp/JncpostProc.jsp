<%@ page contentType="text/html; charset=utf-8"%>\
<jsp:useBean id="jobnoticeMgr" class="erp.JobNoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	String jnc_comment = request.getParameter("jnc_comment");
	int jtc_idx = Integer.parseInt(request.getParameter("jtc_idx"));
	String jnc_name = request.getParameter("jnc_name");
	int emp_num = Integer.parseInt(request.getParameter("emp_num"));
	
	boolean result = jobnoticeMgr.setNComment(jtc_idx, jnc_name, jnc_comment, emp_num);
	
	if(result){
		response.sendRedirect("Jread.jsp?jtc_idx="+jtc_idx);
	}else{
%>
	<script>
		alert("댓글이 입력되지 않았습니다");
		location.href="Jread.jsp?jtc_idx="+<%=jtc_idx%>;
	</script>

	<%}
	} else {
		response.sendRedirect("erpLogin.jsp");
	}%>