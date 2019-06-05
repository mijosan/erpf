<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="noticeMgr" class="erp.NoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	int ntc_idx = Integer.parseInt(request.getParameter("ntc_idx"));
	boolean result = noticeMgr.deleteNotice(ntc_idx);
	
	if(result){noticeMgr.deleteAllNComment(ntc_idx);%>
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
			location.href="read.jsp?ntc_idx="+<%=ntc_idx%>;
		</script>
<%}
} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>%>
		
	

	
