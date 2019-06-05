<%@page import="erp.EmployeeBean"%>
<%@page import="erp.ACommentBean"%>
<%@page import="java.util.Vector"%>
<%@page import="erp.UtilMgr2"%>
<%@page import="erp.AnonyBoardMgr"%>
<%@page import="erp.AnonyBoardBean"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////

	AnonyBoardMgr mgr = new AnonyBoardMgr();
	int any_idx = Integer.parseInt(request.getParameter("any_idx"));
	AnonyBoardBean bean = new AnonyBoardBean();
	bean = mgr.getAnonyBoard(any_idx);
	mgr.notice_upHits(any_idx);
	//댓글관련
	
	Vector<ACommentBean> vlist = mgr.getAComment(any_idx);
	int emp_num = (Integer)session.getAttribute("idKey");
	EmployeeBean employeeBean = (EmployeeBean)session.getAttribute("employeeBean");
%>
<html>
    <head>
        <style>
        	#fullbody{
        		overflow-x: hidden;
      			overflow-y: hidden;
        	}
            * {
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .full {
                width: 650px;
                height: 500px;
      			overflow-x: hidden;
      		
            }
            .view {
                border-collapse: collapse;
                margin-top: 7px;
                margin-left: 13px;
                border: 1px solid rgb(210,210,210);
                width: 570px;
            }
            .write {
                color: rgb(20,117,182);
            }
            .ti {
                border-bottom: 1px solid rgb(215,215,215);
                font-weight: bold;
                background-color: rgb(250,250,250);
            }
            .btn {
                background-color: rgb(46,117,182);
                border: 2px solid rgb(46,117,182);
                color: white;
            }
            .btn2 {
                background-color: rgb(250,250,250);
                border: 1px solid rgb(215,215,215);
            }
            table.view td {
                padding: 10px;
            }
            .scroll{
            	padding:0;
            	margin:0;
            }
            .cList {
                width: 570px;
                height: 228px;
                margin: 7px 13px;
            }
            .dap {
                width: 570px;
                margin-left: 15px;
                margin-right: 15px;
            }
            .comment {
                width: 497px;
                height: 40px;
                vertical-align: bottom;
            }
            #go {
                border-radius: 4px;
                height: 40px;
                vertical-align: super;
            }
            .com {
                border-collapse: collapse;
                margin-top: 7px;
                margin-left: 15px;
                border: 1px solid rgb(210,210,210);
                width: 530px;
            }
            table.com td, table.c_me td {
                padding: 6px;
            }
            .c_me {
                border-collapse: collapse;
                margin-top: 7px;
                margin-left: 210px;
                border: 1px solid rgb(210,210,210);
                width: 350px;
            }
            
        </style>
    </head>
    <body id="fullbody">
        
        <div class="full">
        	<div class="scroll">
                <table class="view">
                    <tr>
                        <td class="ti">
                            <%=bean.getAny_idx() %> | <%=bean.getAny_title() %> | <span class="write"><%=bean.getAny_name() %></span> | <%=bean.getAny_date() %><br><br>
                            
						   <%
							if(bean.getAny_filename()==null){ 
													out.print("첨부된 파일이 없습니다.");
												}else{
							%>
							<a href="fdownload.jsp?cfile=<%=bean.getAny_filename()%>"><%=bean.getAny_filename()%></a>
							<font color="blue">(<%=UtilMgr2.monFormat(bean.getAny_filesize())%>Bytes)
							</font>
							<%}%>
                         </td>
                    </tr>
                    <tr>
                        <td><%if(bean.getAny_filename()!=null){%>
								<img src="fileupload/<%=bean.getAny_filename()%>" width="500" height="300">
							<%}%><br>
							<%=bean.getAny_content() %></td>
                    </tr>
                    <tr>
                        <td>
                        	<%if(bean.getEmp_num()==emp_num){ %>
                            <button class="btn2" onclick="location.href='AnonyUpdate.jsp?<%=request.getQueryString()%>'">수정</button>
                            <input class="btn2" type="button" value="삭제" onclick="location.href='AnonyDeleteProc.jsp?any_idx=<%=any_idx%>'">
                        	<%} %>
                        </td>
                    </tr>
                </table>
                <br><br>
                <div class="cList">
                <div class="dap">
       
                <form method="GET" action="AcPostProc.jsp">
									<input class="comment" name="ac_comment" size="50">
									
									<input type="hidden" name="any_idx" value="<%=any_idx %>">
									<input type="hidden" name="ac_name" value="<%=employeeBean.getEmp_name()%>">
									<input type="hidden" name="emp_num" value="<%=emp_num%>">
									
				<input id="go" class="btn" type="submit" value="등 록"></form>
            </div>
                <!--        댓글 부분        -->
                    <table class="com">
                    <%if(vlist.isEmpty()){ out.println("등록된 댓글이 없습니다");}else{
                    	for(int i=0;i<vlist.size();i++){
                    		ACommentBean cBean = vlist.get(i);	
                    %>
                        <tr>
                            <td width="200" class="ti"><%=cBean.getAc_name() %></td>
                            <td class="ti">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=cBean.getAc_date() %></td>
                        </tr>
                        <tr>
                            <td colspan="2"><%=cBean.getAc_comment() %>
                       		<%
  						if(cBean.getEmp_num()==emp_num){%><input type="button" class="btn2" value="삭제" onclick="location.href='AcDeleteProc.jsp?ac_num='+<%=cBean.getAc_num()%>+'&any_idx='+<%=any_idx%>"><%} %>
                       		
                            </td>
                        </tr>
                        <%}}%>
                    </table>
           		</div>
            </div>
         
        </div>
        
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>