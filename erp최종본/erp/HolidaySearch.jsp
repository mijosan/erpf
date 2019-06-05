<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
    response.sendRedirect("HolidayPage.jsp");
} else {
	response.sendRedirect("erpLogin.jsp");
}
%>
