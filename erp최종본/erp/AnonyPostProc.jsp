<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="erp.EmployeeBean"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="anonyBoardBean" class="erp.AnonyBoardBean"/>
<jsp:useBean id="anonyBoardMgr" class="erp.AnonyBoardMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	/* String saveDir = "/home/hosting_users/erpf/webapps/ROOT/erp/aaa/"; */
	String saveDir = "../webapps/ROOT/erp/fileupload";	
	int maxPostSize = 5*1024*1024;
	boolean flag = false;
	EmployeeBean eBean = (EmployeeBean)session.getAttribute("employeeBean");
	String name = eBean.getEmp_name();
	
	MultipartRequest mr
    =new MultipartRequest(request,
                           saveDir,
                           maxPostSize,
                           "utf-8",
                           new DefaultFileRenamePolicy());
	
	System.out.println("folder path");
	
	if(mr.getParameter("anony")!=null){
		name = "익명";
	}
	String subject = mr.getParameter("subject");
	String content = mr.getParameter("content");
	flag = anonyBoardMgr.insertAnonyBoard(mr, eBean.getEmp_num(), name, subject, content);
	
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
				location.href="AnonyPost.jsp";
			</script>
		<%
	}
} else {
	response.sendRedirect("erpLogin.jsp");
}
%>

