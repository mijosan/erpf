<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="noticeBean" class="erp.NoticeBean"/>
<jsp:useBean id="noticeMgr" class="erp.NoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	boolean flag = false;
	flag = noticeMgr.insertNotice(request);
	
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
				location.href="post.jsp";
			</script>
		<%
	}
} else {
	response.sendRedirect("erpLogin.jsp");
}
%>

