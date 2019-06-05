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
            	overflow-y:scroll;
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
        <form action="AnonyUpdateProc.jsp">
        <div class="full">
        	<div class="scroll">
                <table class="view">
                	<tr>
                		<td>
                			<span class="write">제목</span>
                		</td>
                	</tr>
                    <tr>
                        <td class="ti">
                            <span class="write"><input size="84px" type="text" name="subject" value="<%=bean.getAny_title() %>"></span> <br><br>
                           
                         </td>
                    </tr>
                    <tr>
                    <td>
                    	<span class="write">내용</span>
                    </td>
                    </tr>
                    <tr>
                        <td><textArea name="content" rows="20" cols="82"><%=bean.getAny_content() %></textArea></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" class="btn2" value="수정">
                            <input type="button" class="btn2" onclick="history.back()" value="뒤로가기">
                        </td>
                    </tr>
                </table>       
            </div>
        </div>
        
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <input type="hidden" name="any_idx" value=<%=any_idx %>>
        </form>
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>