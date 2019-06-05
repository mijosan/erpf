<%@page import="erp.LogMgr"%>
<%@page contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="mgr" class="erp.LoginMgr"/><!--mgr import-->
<jsp:useBean id="employeeBean" class="erp.EmployeeBean"/><!--Bean import-->
<%		
		
		String url = "erpLogin.jsp";
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		boolean result = mgr.loginCheck(id,pwd);

		
		String msg = "로그인 실패";
		if(result){
			msg = "로그인 성공";
			url = "main.jsp";
			employeeBean = mgr.getInfo(id);
			LogMgr logmgr = new LogMgr();
			logmgr.insertLogBoard("In", employeeBean);
			session.setAttribute("idKey",Integer.parseInt(id));//세션에 아이디 넣음(Object 형식으로 저장됨)
			session.setAttribute("employeeBean",employeeBean);
		}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>




