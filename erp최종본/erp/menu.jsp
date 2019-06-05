<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int idCC = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
%>
<html>
    <head>
        <link href="style.css" rel="stylesheet" type="text/css">        
        <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            
        $(document).ready(function() {
        	var where = window.location.pathname;
        	function whereBold() {
            	if ( where == "/erp/erp/hrMenu.jsp" || where == "/erp/erp/salaryPage.jsp" || where == "/erp/erp/retirement.jsp" || where == "/erp/erp/certification.jsp" ) {
                    $("#IdtopMenu1").css("font-weight","bold");
            	} else if ( where == "/erp/erp/product.jsp" ) {
                    $("#IdtopMenu2").css("font-weight","bold");
            	} else if ( where == "/erp/erp/searchSell.jsp" || where == "/erp/erp/sellChart.jsp" ) {
                    $("#IdtopMenu3").css("font-weight","bold");
            	} else if ( where == "/erp/erp/HolidayPage.jsp" ) {
                    $("#IdtopMenu4").css("font-weight","bold");
            	} else if ( where == "/erp/erp/AnonyBoard.jsp" || where == "/erp/erp/LogBoard.jsp" || where == "/erp/erp/DirectorBoard.jsp") {
                    $("#IdtopMenu5").css("font-weight","bold");
            	}
        	}
			function whereNormal() {
				if ( where == "/erp/erp/hrMenu.jsp" || where == "/erp/erp/salaryPage.jsp" || where == "/erp/erp/retirement.jsp" || where == "/erp/erp/certification.jsp" ) {
                    $("#IdtopMenu1").css("font-weight","normal");
            	} else if ( where == "/erp/erp/product.jsp" ) {
                    $("#IdtopMenu2").css("font-weight","normal");
            	} else if ( where == "/erp/erp/searchSell.jsp" || where == "/erp/erp/sellChart.jsp" ) {
                    $("#IdtopMenu3").css("font-weight","normal");
            	} else if ( where == "/erp/erp/HolidayPage.jsp" ) {
                    $("#IdtopMenu4").css("font-weight","normal");
            	} else if ( where == "/erp/erp/AnonyBoard.jsp" || where == "/erp/erp/LogBoard.jsp" || where == "/erp/erp/DirectorBoard.jsp") {
                    $("#IdtopMenu5").css("font-weight","normal");
            	}
			}
        	whereBold();
			
            $("#IdtopMenu1").hover(function(){
            	whereNormal();
                $("#IdtopMenu1").css("font-weight","bold");
            },
                function() {
                    $("#IdtopMenu1").css("font-weight","normal");
                    whereBold();
            });
            
            $("#IdtopMenu2").hover(function(){
            	whereNormal();
                $("#IdtopMenu2").css("font-weight","bold");
            },
                function() {
                $("#IdtopMenu2").css("font-weight","normal");
                whereBold();
            });
            
            $("#IdtopMenu3").hover(function(){
            	whereNormal();
                $("#IdtopMenu3").css("font-weight","bold");
            },
                function() {
                $("#IdtopMenu3").css("font-weight","normal");
                whereBold();
            });
            
            $("#IdtopMenu4").hover(function(){
            	whereNormal();
                $("#IdtopMenu4").css("font-weight","bold");
            },
                function() {
                $("#IdtopMenu4").css("font-weight","normal");
                whereBold();
            });
            
            $("#IdtopMenu5").hover(function(){
            	whereNormal();
                $("#IdtopMenu5").css("font-weight","bold");
            },
                function() {
                $("#IdtopMenu5").css("font-weight","normal");
                whereBold();
            });
        });
            
        </script>
    </head>
    
    <body>
        <div id="topMenu">
            <ul>
                
                <li id="IdtopMenu1" class="topMenuLi"><a href="hrMenu.jsp">인사/급여 관리</a>                    
                    <ul class="subMenu">
                        <li><a href="hrMenu.jsp">인사 기초</a></li>
                                             
                        <li><a href="salaryPage.jsp">급여 대장</a></li>
                        
                        <li><a href="retirement.jsp">퇴직 정산</a></li>
                        
                        <li><a href="certification.jsp">증명 관리</a></li>
                    </ul>
                </li>
                
                
                
                <li id="IdtopMenu2" class="topMenuLi">생산/재고 관리
                    <ul class="subMenu">
                        <li><a href="product.jsp">생산 관리</a></li>
                    </ul>
                    
                </li>
                
                
                
                <li id="IdtopMenu3" class="topMenuLi">영업/구매 관리
                    <ul class="subMenu">
                        <li><a href="searchSell.jsp">판매 관리</a></li>
                        
                        <li class="subMenuLi"><a href="sellChart.jsp">판매 차트</a></li>
                    </ul>
                    
                </li>
                
                
                <li id="IdtopMenu4" class="topMenuLi">근태 관리
                    <ul class="subMenu">
                        <li class="subMenuLi"><a href="HolidayPage.jsp">근태 등록</a></li>
                    </ul>
                    
                </li>
                
                
                
                <li id="IdtopMenu5" class="topMenuLi">그룹웨어
                    <ul class="subMenu">
                        <li class="subMenuLi"><a href="AnonyBoard.jsp">자유 게시판</a></li>
                        
                        <li class="subMenuLi"><a href="LogBoard.jsp">로그 조회</a></li>
                        
                        <li class="subMenuLi"><a href="DirectorBoard.jsp">부서별 게시판</a></li>
                    </ul>
                    
                </li>
                
            </ul>
            
        </div>
        
        <div style="background: rgb(46,117,182); margin-top: -20px; min-width: 1300px; height: 30px;"></div>
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>