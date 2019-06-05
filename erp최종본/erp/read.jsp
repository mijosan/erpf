<%@page import="erp.EmployeeBean"%>
<%@page import="erp.NCommentBean"%>
<%@page import="java.util.Vector"%>
<%@page import="erp.UtilMgr2"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="noticeBean" class="erp.NoticeBean"/>
<jsp:useBean id="noticeMgr" class="erp.NoticeMgr"/>
<jsp:useBean id="ncommentBean" class="erp.NCommentBean"/>
<%
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////

	int ntc_idx = Integer.parseInt(request.getParameter("ntc_idx"));
	noticeMgr.notice_upHits(ntc_idx);
	noticeBean = noticeMgr.getNotice(ntc_idx);
	
	Vector<NCommentBean> vlist = noticeMgr.getNComment(ntc_idx);
	
	session.setAttribute("noticeBean", noticeBean);
	
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
							<td><%=noticeBean.getNtc_name()%></td>
							<td align="center" bgcolor="#DDDDDD" width="100">등록날짜</td>
							<td><%=noticeBean.getNtc_date().substring(0,10)%></td>
						</tr>
						<tr>
							<td align="center" bgcolor="#DDDDDD">제 목</td>
							<td><%=noticeBean.getNtc_title()%></td>
                            <td align="center" bgcolor="#DDDDDD">조회수</td>
                            <td><%=noticeBean.getNtc_hits()%></td>
						</tr>
						<tr>
							<td align="center" bgcolor="#DDDDDD">첨부파일</td>
							<td bgcolor="#FFFFE8" colspan="3">
							<%
								if(noticeBean.getNtc_filename()==null){ 
													out.print("첨부된 파일이 없습니다.");
												}else{
							%>
							<a href="fdownload.jsp?cfile=<%=noticeBean.getNtc_filename()%>"><%=noticeBean.getNtc_filename()%></a>
							<font color="blue">(<%=UtilMgr2.monFormat(noticeBean.getNtc_filesize())%>Bytes)
							</font>
							<%}%>
							</td>
						</tr>
						<tr>
							<td colspan="4"><br>
							<%if(noticeBean.getNtc_filename()!=null){%>
								<img src="fileupload/<%=noticeBean.getNtc_filename()%>" width="500" height="300">
							<%}%>
							<%if(noticeBean.getNtc_content()!=null){
								%>
									<%=noticeBean.getNtc_content() %>
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
									<form method="GET" action="ncpostProc.jsp">
									<input name="nc_comment" size="50">
									
									<input type="hidden" name="ntc_idx" value="<%=ntc_idx %>">
									<input type="hidden" name="nc_name" value="<%=employeeBean.getEmp_name()%>">
									<input type="hidden" name="emp_num" value="<%=emp_num%>">
									
									<input type="submit" value="등록"></form></td>
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
							ncommentBean = vlist.get(i);
					%>
			 		<tr>
  						<td colspan="3" width="600"><b><%=ncommentBean.getNc_name()%></b></td>
  					</tr>
  					<tr>
  						<td><%=ncommentBean.getNc_comment()%></td>
  						<td align="right"><%=ncommentBean.getNc_date().substring(0,10)%></td>					
  						

  						<td align="center" valign="middle">
  						<%
  						if(ncommentBean.getEmp_num()==emp_num){%><input type="button" value="삭제" onclick="location.href='NCdeleteProc.jsp?nc_num='+<%=ncommentBean.getNc_num()%>+'&ntc_idx='+<%=ntc_idx%>"><%} %>
  				
  						</td>
  						<%}}%>
  					</tr>
  					<tr>
  						<td colspan="3"><br/></td>
  					</tr>
					</table>
				<%if(noticeBean.getEmp_num()==emp_num){ %>		
				<input type="button" value="수정" onclick="location.href='update.jsp?ntc_idx=<%=ntc_idx%>'">
                <input type="button" value="삭제" onclick="location.href='deleteProc.jsp?ntc_idx=<%=ntc_idx%>'">
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