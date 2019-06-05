<%@ page contentType="text/html; charset=utf-8"%>\
<jsp:useBean id="noticeMgr" class="erp.NoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	String nc_comment = request.getParameter("nc_comment");
	int ntc_idx = Integer.parseInt(request.getParameter("ntc_idx"));
	String nc_name = request.getParameter("nc_name");
	int emp_num = Integer.parseInt(request.getParameter("emp_num"));
	
	boolean result = noticeMgr.setNComment(ntc_idx, nc_name, nc_comment, emp_num);
	
	if(result){
		response.sendRedirect("read.jsp?ntc_idx="+ntc_idx);
	}else{
%>
	<script>
		alert("댓글이 입력되지 않았습니다");
		location.href="read.jsp?ntc_idx="+<%=ntc_idx%>;
	</script>

	<%}
	} else {
		response.sendRedirect("erpLogin.jsp");
	}%>