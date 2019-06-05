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
	Vector<JobNoticeBean> vlist2 = new Vector<JobNoticeBean>();
	EmployeeBean employeeBean2 = (EmployeeBean)session.getAttribute("employeeBean");
	vlist2 = jobnoticeMgr.getAllNotice(employeeBean2.getEmp_dept());
%>
<html>
    <head>
        <style>
            .JobBoard{
                width:460px;
                height:400px;
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
                position:inherit;
            }
            table.tblJob tr:hover {
                background-color: rgb(225,225,225);
            }
            .tbljob{
            	width:460px;
            }
            }
        </style>
    </head>
    <body>
        <div class="JobBoard">
            <h2 class="boardName" style="display: inline-block"><%=employeeBean2.getEmp_dept()%> 공지사항</h2>
            <input type="button" value="+" class="boardBtn" onclick="window.open('Jpost.jsp', '_blank', 'width=550 height=400')">
            <br><hr/>
            <table class="tblJob">
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
                    	if(jobnoticeBean.getJtc_title().length() >14){
                    		title = jobnoticeBean.getJtc_title().substring(0, 14)+"..";
                    	}else{
                    		title=jobnoticeBean.getJtc_title();
                    	}
                    	if(jobnoticeBean.getEmp_job().equals("부장") || jobnoticeBean.getEmp_job().equals("이사")){
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
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>