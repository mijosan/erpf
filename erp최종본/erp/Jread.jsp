<%@page import="erp.JNCommentBean"%>
<%@page import="erp.EmployeeBean"%>
<%@page import="erp.NCommentBean"%>
<%@page import="java.util.Vector"%>
<%@page import="erp.UtilMgr2"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="jobnoticeBean" class="erp.JobNoticeBean"/>
<jsp:useBean id="jobnoticeMgr" class="erp.JobNoticeMgr"/>
<jsp:useBean id="jncommentBean" class="erp.JNCommentBean"/>
<%
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	int jtc_idx = Integer.parseInt(request.getParameter("jtc_idx"));
	jobnoticeMgr.notice_upHits(jtc_idx);
	jobnoticeBean = jobnoticeMgr.getNotice(jtc_idx);
	
	Vector<JNCommentBean> vlist = jobnoticeMgr.getNComment(jtc_idx);
	
	session.setAttribute("jobnoticeBean", jobnoticeBean);
	
	EmployeeBean employeeBean = (EmployeeBean)session.getAttribute("employeeBean");
	
	int emp_num = (Integer)session.getAttribute("idKey");
%>
<html>
    <head>
        <style>
        .boardTd{
            background-color: rgb(46, 117, 182);
            color: white;
        }
        </style>
        <script>
        	opener.location.reload();
        </script>
    </head>
<body bgcolor="white">
	<br />
	<br />
	<div align="center">
		<table>
			<tr>
				<td class="boardTd" width="550" align="center">글읽기</td>
			</tr>
			<tr>
				<td>
					<table>
						<tr>
							<td align="center" bgcolor="#DDDDDD" width="100">이 름</td>
							<td><%=jobnoticeBean.getJtc_name()%></td>
							<td align="center" bgcolor="#DDDDDD" width="100">등록날짜</td>
							<td><%=jobnoticeBean.getJtc_date().substring(0,10)%></td>
						</tr>
						<tr>
							<td align="center" bgcolor="#DDDDDD">제 목</td>
							<td><%=jobnoticeBean.getJtc_title()%></td>
                            <td align="center" bgcolor="#DDDDDD">조회수</td>
                            <td><%=jobnoticeBean.getJtc_hits()%></td>
						</tr>
						<tr>
							<td align="center" bgcolor="#DDDDDD">첨부파일</td>
							<td bgcolor="#FFFFE8" colspan="3">
							<%
								if(jobnoticeBean.getJtc_filename()==null){ 
													out.print("첨부된 파일이 없습니다.");
												}else{
							%>
							<a href="fdownload.jsp?cfile=<%=jobnoticeBean.getJtc_filename()%>"><%=jobnoticeBean.getJtc_filename()%></a>
							<font color="blue">(<%=UtilMgr2.monFormat(jobnoticeBean.getJtc_filesize())%>Bytes)
							</font>
							<%}%>
							</td>
						</tr>
						<tr>
							<td colspan="4"><br>
							<%if(jobnoticeBean.getJtc_filename()!=null){%>
								<img src="fileupload/<%=jobnoticeBean.getJtc_filename()%>" width="500" height="300">
							<%}%>
							<%if(jobnoticeBean.getJtc_content()!=null){
								%>
									<%=jobnoticeBean.getJtc_content() %>
								<%
							}%>
							</td>
						</tr>
						<tr>
							<td colspan="4" align="right"></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>
				<td align="center">
							<table>
								<tr align="center">
									<td>
									<form method="GET" action="JncpostProc.jsp">
									<input name="jnc_comment" size="50">
									
									<input type="hidden" name="jtc_idx" value="<%=jtc_idx %>">
									<input type="hidden" name="jnc_name" value="<%=employeeBean.getEmp_name()%>">
									<input type="hidden" name="emp_num" value="<%=emp_num%>">
									
									<input type="submit" value="등록">
									</form></td>
								</tr>
							</table>
					
			 		<tr >
  						<td colspan="3" width="600"></td>
  					</tr>
  					<tr>
  						<td>댓글</td>
  					</tr>
 		
			<tr>
				<td align="right">
				<hr/>
					<table>
					<%if(!vlist.isEmpty()){
						for(int i=0;i<vlist.size();i++){
							jncommentBean = vlist.get(i);
					%>
			 		<tr>
  						<td colspan="3" width="600"><b><%=jncommentBean.getJnc_name()%></b></td>
  					</tr>
  					<tr>
  						<td><%=jncommentBean.getJnc_comment()%></td>
  						<td align="right"><%=jncommentBean.getJnc_date().substring(0,10)%></td>					
  						

  						<td align="center" valign="middle">
  						<%
  						if(jncommentBean.getEmp_num()==emp_num){%><input type="button" value="삭제" onclick="location.href='JNCdeleteProc.jsp?jnc_num='+<%=jncommentBean.getJnc_num()%>+'&jtc_idx='+<%=jtc_idx%>"><%} %>
  						</td>
  						<%}}%>
  					</tr>
  					<tr>
  						<td colspan="3"><br/></td>
  					</tr>
					</table>
				<%if(jobnoticeBean.getEmp_num()==emp_num){ %>
				<input type="button" value="수정" onclick="location.href='Jupdate.jsp?jtc_idx=<%=jtc_idx%>'">
                <input type="button" value="삭제" onclick="location.href='JdeleteProc.jsp?jtc_idx=<%=jtc_idx%>'">
                <%} %>
				</td>
			</tr>		
	</div>
</body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>
