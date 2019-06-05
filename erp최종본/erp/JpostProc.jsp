<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="jobnoticeBean" class="erp.JobNoticeBean"/>
<jsp:useBean id="jobnoticeMgr" class="erp.JobNoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////

	boolean flag = false;
	flag = jobnoticeMgr.insertNotice(request);
	
	if(flag==true){
		%>
			<script>
				alert("등록이 완료되었습니다.");
				self.close();
				opener.location.reload();
			</script>
		<%
	}else{
		%>
			<script>
				alert("등록이 되지않았습니다 다시 시도하여주십시오");
				location.href="Jpost.jsp";
			</script>
		<%
	}
} else {
	response.sendRedirect("erpLogin.jsp");
}
%>
