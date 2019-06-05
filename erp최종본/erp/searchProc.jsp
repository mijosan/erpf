<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	String search_content = request.getParameter("search_content").replace(" ","");
	
	if(search_content.equals("인사기초")){
		response.sendRedirect("hrMenu.jsp");
	}else if(search_content.equals("급여대장")){
		response.sendRedirect("salaryPage.jsp");
	}else if(search_content.equals("퇴직정산")){
		response.sendRedirect("retirement.jsp");
	}else if(search_content.equals("증명관리")){
		response.sendRedirect("certification.jsp");
	}else if(search_content.equals("생산관리")){
		response.sendRedirect("product.jsp");
	}else if(search_content.equals("판매관리")){
		response.sendRedirect("searchSell.jsp");
	}else if(search_content.equals("판매차트")){
		response.sendRedirect("sellChart.jsp");
	}else if(search_content.equals("근태등록")){
		response.sendRedirect("HolidayPage.jsp");
	}else if(search_content.equals("자유게시판")){
		response.sendRedirect("AnonyBoard.jsp");
	}else if(search_content.equals("로그조회")){
		response.sendRedirect("LogBoard.jsp");
	}else if(search_content.equals("부서별게시판")){
		response.sendRedirect("DirectorBoard.jsp");
	}else{
		%>
			<script>
				history.back();
				alert("검색어를 제대로 입력하십시오");
			</script>
		<%
	}
} else {
	response.sendRedirect("erpLogin.jsp");
}
	
%>
