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
				alert("����� �Ϸ�Ǿ����ϴ�.");
				self.close();
				opener.location.reload();
			</script>
		<%
	}else{
		%>
			<script>
				alert("����� �����ʾҽ��ϴ� �ٽ� �õ��Ͽ��ֽʽÿ�");
				location.href="Jpost.jsp";
			</script>
		<%
	}
} else {
	response.sendRedirect("erpLogin.jsp");
}
%>
