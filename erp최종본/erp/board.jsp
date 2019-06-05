<%@page import="erp.EmployeeBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="erp.NoticeBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="noticeBean" class="erp.NoticeBean"/>
<jsp:useBean id="noticeMgr" class="erp.NoticeMgr"/>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	Vector<NoticeBean> vlist = new Vector<NoticeBean>();
	vlist = noticeMgr.getAllNotice();
	EmployeeBean employeeBean = (EmployeeBean)session.getAttribute("employeeBean");
%>
<html>
    <head>
        <style>
            .Bboard{
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
            }
            .EBO{
            	width:460px;
            }
            table.EBO tr:hover {
                background-color: rgb(225,225,225);
            }
        </style>
    </head>
    <body>
        <div class="Bboard">
            <h2 class="boardName" style="display: inline-block">공지사항</h2>
            <%if(employeeBean.getEmp_job().equals("이사")||employeeBean.getEmp_job().equals("부장")){ %>
            <input type="button" value="+" class="boardBtn" onclick="window.open('post.jsp', '_blank', 'width=550 height=400')">
            <%} %>
            <br><hr/>
            <table class="EBO">
                <tr align="center" class="boardTr">
				    <td class="boardTd" width="80">번 호</td>
				    <td id="ntc_title" class="boardTd" width="250">제 목</td>
				    <td class="boardTd" width="100">작성자</td>
				    <td class="boardTd" width="130">날 짜</td>
				    <td class="boardTd" width="80">조회수</td>
				</tr>
				<%for(int i=0;i<vlist.size();i++){ noticeBean = vlist.get(i); %>
                <tr align="center">
                    <td><%=noticeBean.getNtc_idx()%></td>
                    <td><a href="#" onclick="window.open('read.jsp?ntc_idx='+<%=noticeBean.getNtc_idx()%>, '_blank', 'width=550 height=400')">
                    
                    <%
                    	String title="";
                    	if(noticeBean.getNtc_title().length() >15){
                    		title = noticeBean.getNtc_title().substring(0, 15)+"..";
                    	}else{
                    		title=noticeBean.getNtc_title();
                    	}
                     	 out.println(title);
                     	
                    %>
                    
                    
                    </a>
                    <%if(noticeBean.getNtc_filename()!=null&&!noticeBean.getNtc_filename().equals("")){ %><!--파일이 있을경우 파일아이콘 생성-->
											<img alt="첨부파일" src="img/icon_file.gif" align="middle">
										<% }%>
					<%if(noticeMgr.getNCommentCount(noticeBean.getNtc_idx())!=0){%>
					<font color="red">[<%=noticeMgr.getNCommentCount(noticeBean.getNtc_idx())%>]</font>
					<%}%>
                    
                    </td>
                    <td><%=noticeBean.getNtc_name()%></td>
                    <td><%=noticeBean.getNtc_date().substring(0,10)%></td>
                    <td><%=noticeBean.getNtc_hits()%></td>
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