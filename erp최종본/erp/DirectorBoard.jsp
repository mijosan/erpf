<%@page import="erp.JobNoticeBean"%>
<%@page import="erp.EmployeeBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="erp.NoticeBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="jobnoticeBean" class="erp.JobNoticeBean"/>
<jsp:useBean id="jobnoticeMgr" class="erp.JobNoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	EmployeeBean employeeBean = (EmployeeBean)session.getAttribute("employeeBean");
	
	if(employeeBean.getEmp_job().equals("이사")){
	Vector<JobNoticeBean> vlist1 = new Vector<JobNoticeBean>();
	Vector<JobNoticeBean> vlist2 = new Vector<JobNoticeBean>();
	Vector<JobNoticeBean> vlist3 = new Vector<JobNoticeBean>();
	Vector<JobNoticeBean> vlist4 = new Vector<JobNoticeBean>();
	
	
	vlist1 = jobnoticeMgr.getAllNotice("이사부");
	vlist2 = jobnoticeMgr.getAllNotice("인사부");
	vlist3 = jobnoticeMgr.getAllNotice("생산부");
	vlist4 = jobnoticeMgr.getAllNotice("영업부");
%>
<%@ include file="top.jsp" %>
<%@ include file="menu.jsp" %>
<br><br>
 <div class="tblheader2"><img src="img/star2.png"><b> &nbsp;부서별 게시판(이사 전용)</b><br/></div><br>
<html>
    <head>
        <style>
        .tblheader2{            	
            	border-top : 1px solid #dee3eb;
            	border-bottom: 1px solid #dee3eb;
            	padding-top: 5px;
            	padding-bottom : 7px;
            	margin-left:50px;
            	width:1320px;
            }   
            .JobBoard{
                width:450px;
                height:400px;
                overflow-y:scroll;
                margin-left:35px;
            }
            .boardName{
                margin:0px;
                font-size: 15px;
            }
            .boardBtn{
                float: right;
                margin-top: 3px;
                background-color: white;
                border: 1px solid #dee3eb;
            }
            .boardTd{
                color:white;
            }
            .boardTr{
                background-color: rgb(46, 117, 182);
            }
        </style>
    </head>
    <body>
        <div class="JobBoard" style="float: left; width: 33%;padding:10px;">
            <h2 class="boardName" style="display: inline-block">이사단 공지사항</h2>
            <input type="button" value="+" class="boardBtn" onclick="window.open('Jpost.jsp', '_blank', 'width=550 height=400')">
            <br><hr/>
            <table>
                <tr align="center" class="boardTr">
				    <td class="boardTd" width="80">번 호</td>
				    <td id="ntc_title" class="boardTd" width="250">제 목</td>
				    <td class="boardTd" width="100">작성자</td>
				    <td class="boardTd" width="130">날 짜</td>
				    <td class="boardTd" width="80">조회수</td>
				</tr>
				<%for(int i=0;i<vlist1.size();i++){ jobnoticeBean = vlist1.get(i); %>
                <tr align="center">
                    <td><%=jobnoticeBean.getJtc_idx()%></td>
                    
                    <td><a href="#" onclick="window.open('Jread.jsp?jtc_idx='+<%=jobnoticeBean.getJtc_idx()%>, '_blank', 'width=550 height=400')">
                    
                    <%
                    	String title="";
                    	if(jobnoticeBean.getJtc_title().length() >10){
                    		title = jobnoticeBean.getJtc_title().substring(0, 9)+"..";
                    	}else{
                    		title=jobnoticeBean.getJtc_title();
                    	}
                    	if(jobnoticeBean.getEmp_job().equals("부장")){
                    		%>
                    		<input type="image" src="img/notice00.png"><font color="red"> <%=title %></font>
                    		<%
                    	}else{
                    		out.println(title);
                    	}
                    %>
                    
                    
                    </a>
                    <%if(jobnoticeBean.getJtc_filename()!=null&&!jobnoticeBean.getJtc_filename().equals("")){ %><!--파일이 있을경우 파일아이콘 생성-->
											<img alt="첨부파일" src="img/icon_file.gif" align="middle">
										<% }%>
					<%if(jobnoticeMgr.getNCommentCount(jobnoticeBean.getJtc_idx())!=0){%>
					<font color="red">[<%=jobnoticeMgr.getNCommentCount(jobnoticeBean.getJtc_idx())%>]</font>
					<%}%>
                    
                    </td>
                    <td><%=jobnoticeBean.getJtc_name()%></td>
                    <td><%=jobnoticeBean.getJtc_date().substring(0,10)%></td>
                    <td><%=jobnoticeBean.getJtc_hits()%></td>
                </tr>
                <%}%>      
            </table>            
        </div>
        <div class="JobBoard" style="float: left; width: 33%; padding:10px;">
            <h2 class="boardName" style="display: inline-block">인사부 공지사항</h2>
            <input type="button" value="+" class="boardBtn" onclick="window.open('Jpost.jsp', '_blank', 'width=550 height=400')">
            <br><hr/>
            <table>
                <tr align="center" class="boardTr">
				    <td class="boardTd" width="80">번 호</td>
				    <td id="ntc_title" class="boardTd" width="250">제 목</td>
				    <td class="boardTd" width="100">작성자</td>
				    <td class="boardTd" width="130">날 짜</td>
				    <td class="boardTd" width="80">조회수</td>
				</tr>
				<%for(int i=0;i<vlist2.size();i++){ jobnoticeBean = vlist2.get(i); %>
                <tr align="center">
                    <td><%=jobnoticeBean.getJtc_idx()%></td>
                    
                    <td><a href="#" onclick="window.open('Jread.jsp?jtc_idx='+<%=jobnoticeBean.getJtc_idx()%>, '_blank', 'width=550 height=400')">
                    
                    <%
                    	String title="";
                    	if(jobnoticeBean.getJtc_title().length() >10){
                    		title = jobnoticeBean.getJtc_title().substring(0, 9)+"..";
                    	}else{
                    		title=jobnoticeBean.getJtc_title();
                    	}
                    	if(jobnoticeBean.getEmp_job().equals("부장")){
                    		%>
                    		<input type="image" src="img/notice00.png"><font color="red"> <%=title %></font>
                    		<%
                    	}else{
                    		out.println(title);
                    	}
                    %>
                    
                    
                    </a>
                    <%if(jobnoticeBean.getJtc_filename()!=null&&!jobnoticeBean.getJtc_filename().equals("")){ %><!--파일이 있을경우 파일아이콘 생성-->
											<img alt="첨부파일" src="img/icon_file.gif" align="middle">
										<% }%>
					<%if(jobnoticeMgr.getNCommentCount(jobnoticeBean.getJtc_idx())!=0){%>
					<font color="red">[<%=jobnoticeMgr.getNCommentCount(jobnoticeBean.getJtc_idx())%>]</font>
					<%}%>
                    
                    </td>
                    <td><%=jobnoticeBean.getJtc_name()%></td>
                    <td><%=jobnoticeBean.getJtc_date().substring(0,10)%></td>
                    <td><%=jobnoticeBean.getJtc_hits()%></td>
                </tr>
                <%}%>      
            </table>            
        </div>
        <div class="JobBoard" style="float: left; width: 33%; padding:10px;">
            <h2 class="boardName" style="display: inline-block">생산부 공지사항</h2>
            <input type="button" value="+" class="boardBtn" onclick="window.open('Jpost.jsp', '_blank', 'width=550 height=400')">
            <br><hr/>
            <table>
                <tr align="center" class="boardTr">
				    <td class="boardTd" width="80">번 호</td>
				    <td id="ntc_title" class="boardTd" width="250">제 목</td>
				    <td class="boardTd" width="100">작성자</td>
				    <td class="boardTd" width="130">날 짜</td>
				    <td class="boardTd" width="80">조회수</td>
				</tr>
				<%for(int i=0;i<vlist3.size();i++){ jobnoticeBean = vlist3.get(i); %>
                <tr align="center">
                    <td><%=jobnoticeBean.getJtc_idx()%></td>
                    
                    <td><a href="#" onclick="window.open('Jread.jsp?jtc_idx='+<%=jobnoticeBean.getJtc_idx()%>, '_blank', 'width=550 height=400')">
                    
                    <%
                    	String title="";
                    	if(jobnoticeBean.getJtc_title().length() >10){
                    		title = jobnoticeBean.getJtc_title().substring(0, 9)+"..";
                    	}else{
                    		title=jobnoticeBean.getJtc_title();
                    	}
                    	if(jobnoticeBean.getEmp_job().equals("부장")){
                    		%>
                    		<input type="image" src="img/notice00.png"><font color="red"> <%=title %></font>
                    		<%
                    	}else{
                    		out.println(title);
                    	}
                    %>
                    
                    
                    </a>
                    <%if(jobnoticeBean.getJtc_filename()!=null&&!jobnoticeBean.getJtc_filename().equals("")){ %><!--파일이 있을경우 파일아이콘 생성-->
											<img alt="첨부파일" src="img/icon_file.gif" align="middle">
										<% }%>
					<%if(jobnoticeMgr.getNCommentCount(jobnoticeBean.getJtc_idx())!=0){%>
					<font color="red">[<%=jobnoticeMgr.getNCommentCount(jobnoticeBean.getJtc_idx())%>]</font>
					<%}%>
                    
                    </td>
                    <td><%=jobnoticeBean.getJtc_name()%></td>
                    <td><%=jobnoticeBean.getJtc_date().substring(0,10)%></td>
                    <td><%=jobnoticeBean.getJtc_hits()%></td>
                </tr>
                <%}%>      
            </table>            
        </div>
        <div class="JobBoard" style="float: left; width: 33%; padding:10px;">
            <h2 class="boardName" style="display: inline-block">영업부 공지사항</h2>
            <input type="button" value="+" class="boardBtn" onclick="window.open('Jpost.jsp', '_blank', 'width=550 height=400')">
            <br><hr/>
            <table>
                <tr align="center" class="boardTr">
				    <td class="boardTd" width="80">번 호</td>
				    <td id="ntc_title" class="boardTd" width="250">제 목</td>
				    <td class="boardTd" width="100">작성자</td>
				    <td class="boardTd" width="130">날 짜</td>
				    <td class="boardTd" width="80">조회수</td>
				</tr>
				<%for(int i=0;i<vlist4.size();i++){ jobnoticeBean = vlist4.get(i); %>
                <tr align="center">
                    <td><%=jobnoticeBean.getJtc_idx()%></td>
                    
                    <td><a href="#" onclick="window.open('Jread.jsp?jtc_idx='+<%=jobnoticeBean.getJtc_idx()%>, '_blank', 'width=550 height=400')">
                    
                    <%
                    	String title="";
                    	if(jobnoticeBean.getJtc_title().length() >10){
                    		title = jobnoticeBean.getJtc_title().substring(0, 9)+"..";
                    	}else{
                    		title=jobnoticeBean.getJtc_title();
                    	}
                    	if(jobnoticeBean.getEmp_job().equals("부장")){
                    		%>
                    		<input type="image" src="img/notice00.png"><font color="red"> <%=title %></font>
                    		<%
                    	}else{
                    		out.println(title);
                    	}
                    %>
                    
                    
                    </a>
                    <%if(jobnoticeBean.getJtc_filename()!=null&&!jobnoticeBean.getJtc_filename().equals("")){ %><!--파일이 있을경우 파일아이콘 생성-->
											<img alt="첨부파일" src="img/icon_file.gif" align="middle">
										<% }%>
					<%if(jobnoticeMgr.getNCommentCount(jobnoticeBean.getJtc_idx())!=0){%>
					<font color="red">[<%=jobnoticeMgr.getNCommentCount(jobnoticeBean.getJtc_idx())%>]</font>
					<%}%>
                    
                    </td>
                    <td><%=jobnoticeBean.getJtc_name()%></td>
                    <td><%=jobnoticeBean.getJtc_date().substring(0,10)%></td>
                    <td><%=jobnoticeBean.getJtc_hits()%></td>
                </tr>
                <%}%>      
            </table>            
        </div>
        
    </body>
</html>
<%}else{%>
	<script>
		alert("접근 권한이 없습니다");
		history.back();
	</script>
<%}
} else {
		response.sendRedirect("erpLogin.jsp");
	}%>