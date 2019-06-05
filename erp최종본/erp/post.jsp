<%@ page contentType="text/html; charset=EUC-KR"%>
<% 
	request.setCharacterEncoding("EUC-KR");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
%>
<html>
<head>
<title>postBoard</title>
    <style>
        .boardTd{
            background-color: rgb(46, 117, 182);
            color: white;
        }
        .name{
            background-color: #ccc;
        }
    </style>
</head>
<body bgcolor="white">
<div align="center">
<br/><br/>
<table>
	<tr>
		<td class="boardTd" width="450" align="center">글쓰기</td>
	</tr>
</table>
<br/>
<form action="postProc.jsp" method="post" enctype="multipart/form-data">
<table>
	
	<tr>
		<td align=center>
		<table>
			<tr>
				<td>제 목</td>
				<td>
				<input name="subject" size="50" maxlength="30"></td>
			</tr>
			<tr>
				<td>내 용</td>
				<td><textarea name="content" rows="10" cols="52"></textarea></td>
			</tr>
			<tr>
			 <tr>
     			<td>파일찾기</td> 
     			<td><input type="file" name="filename" size="50" maxlength="50"></td>
    		</tr>
 			
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					 <input type="submit" value="등록">
					 <input type="reset" value="다시쓰기">
				</td>
			</tr>
		</table>
		</td>
	</tr>
	
</table>
</form>
</div>
</body>
</html>

<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>