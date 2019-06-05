<%@page import="erp.NoticeBean"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////

	NoticeBean noticeBean = (NoticeBean)session.getAttribute("noticeBean");
	int ntc_idx = Integer.parseInt(request.getParameter("ntc_idx"));
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
		<td class="boardTd" width="450" align="center">글수정</td>
	</tr>
</table>
<br/>
<form action="updateProc.jsp">
<table>
	<tr>
		<td align=center>
		<table>
			<tr>
				<td>제 목</td>
				<td>
				<input name="subject" size="50" maxlength="30" value="<%=noticeBean.getNtc_title()%>"></td>
			
			</tr>
			<tr>
				<td>내 용</td>
				<td><textarea name="content" rows="10" cols="52"><%=noticeBean.getNtc_content()%></textarea></td>
			</tr>
			<tr>
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
                    <input type="button" value="뒤로가기" onclick="history.back()">
                    <input type="submit" value="수정">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="ntc_idx" value="<%=ntc_idx %>">
</form>
</div>
</body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>