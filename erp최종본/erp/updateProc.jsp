<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="noticeMgr" class="erp.NoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	String ntc_title = request.getParameter("subject");
	String ntc_content = request.getParameter("content");
	int ntc_idx = Integer.parseInt(request.getParameter("ntc_idx"));
	
	boolean result = noticeMgr.setNotice(ntc_idx,ntc_title,ntc_content);
	
	if(result){
		%>		
			<script>
				alert("수정이 완료 되었습니다.");
				location.href="read.jsp?ntc_idx="+<%=ntc_idx%>;
				opener.location.reload();
			</script>
		<%
	}else{
		%>
			<script>
				alert("수정이 되지 않았습니다.");
				location.href="update.jsp?ntc_idx="+<%=ntc_idx%>;
			</script>
		<%
	}
} else {
	response.sendRedirect("erpLogin.jsp");
}
%>
