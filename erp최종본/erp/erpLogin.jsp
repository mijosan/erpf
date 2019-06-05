<%@page contentType="text/html;charset=utf-8"%> <!--이 페이지의 한글값이 깨지지 않도록한다.-->
<%
	request.setCharacterEncoding("utf-8"); //받아올때 utf-8로 인코딩함
	int id = 0;
	if(session.getAttribute("idKey")!=null){
		id = (Integer)session.getAttribute("idKey"); //세션에서 id를 받아옴	
	}
%>
<html>
<title>로그인</title>
<%
		if(id!=0){ //세션에 id가 있으면
			response.sendRedirect("main.jsp");
		}else{
%>
    <head>
		<link href="style.css" rel="stylesheet" type="text/css">
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
        	$(document).ready(function(){
        			$("#id1").focusout(function(){
        				if($("#id1").val().length==0){
        					alert("아이디를 입력하십시오");
        				}
        			});	
        	});
        </script>
 		<style>
 		.noticeLevel table{
            color: gray;
            border: 1px solid #eeeeee;
            border-collapse: collapse;
            font-size: 14px;
            text-align: center;
	        }
	        .noticeLevel table td{
	            width: 150px;
	            border: 1px solid #eeeeee;
	        }
 		</style>


    </head>
    <body>
    <form action="erpLoginProc.jsp">
        <div class="login">
        	<input class="erpLogo" type="image" src="img/logo.png"><br><br><br>
        	
            <div class="idDiv">
            <input id="id1" class="loginbox" name="id" placeholder="아이디" autofocus>
            </div>
            <div class="pwDiv">
            <input type="password" class="loginbox" name="pwd" placeholder="비밀번호">
            </div>   
            <input class="loginBtn" type="submit" alt="로그인" value="로그인"><br><br>
            <div class="noticeLevel">
        <table>
            <thead>
                <tr><td colspan="3" align="center"><b>권한 계정 안내</b></td></tr>
            </thead>
            <tr><td><b>권한</b></td><td><b>아이디</b></td><td><b>비밀번호</b></td></tr>
            <tr><td>관리자</td><td>1</td><td>1234</td></tr>
            <tr><td>생산부(모든권한)</td><td>9</td><td>1234</td></tr>
            <tr><td>생산부(일반)</td><td>10</td><td>1234</td></tr>
            <tr><td>인사부(모든권한)</td><td>6</td><td>1234</td></tr>
            <tr><td>인사부(일반)</td><td>5</td><td>1234</td></tr>
            <tr><td>영업부(모든권한)</td><td>7</td><td>1234</td></tr>
            <tr><td>영업부(일반)</td><td>8</td><td>1234</td></tr>
        </table>
        </div>
        </div>
        </form>
    </body>
</html>
<% } %>