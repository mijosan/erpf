<%@page import="erp.JobNoticeBean"%>
<%@page import="erp.NoticeBean"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	JobNoticeBean jobnoticeBean = (JobNoticeBean)session.getAttribute("jobnoticeBean");
	int jtc_idx = Integer.parseInt(request.getParameter("jtc_idx"));
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
<form action="JupdateProc.jsp">
<table>
	<tr>
		<td align=center>
		<table>
			<tr>
				<td>제 목</td>
				<td>
				<input name="subject" size="50" maxlength="30" value="<%=jobnoticeBean.getJtc_title()%>"></td>
			
			</tr>
			<tr>
				<td>내 용</td>
				<td><textarea name="content" rows="10" cols="52"><%=jobnoticeBean.getJtc_content()%></textarea></td>
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
<input type="hidden" name="jtc_idx" value="<%=jtc_idx %>">
</form>
</div>
</body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>