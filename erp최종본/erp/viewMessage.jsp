<%@page import="erp.EmployeeMgr"%>
<%@page import="erp.EmployeeBean"%>
<%@page import="erp.MessageBean"%>
<%@page import="erp.MessageMgr"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	int idx = Integer.parseInt(request.getParameter("idx"));
	int fro = Integer.parseInt(request.getParameter("fro"));
	MessageMgr msgMgr = new MessageMgr();
	MessageBean msgBean = msgMgr.getView(idx);
	String sender = msgMgr.getSender(msgBean.getMsg_send());
	String senddate = msgBean.getMsg_senddate();
	String content = msgBean.getMsg_content();
	if ( msgBean.getMsg_condate() == null ) {
		msgMgr.conView(idx);
	}
%>
<html>
    <head>
        <style>
            * {
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .SviewMsg_full {
                width: 400px;
                height: 420px;
            }
            .SviewMsg_header {
                border-bottom: 1px solid rgb(220,220,220);
            }
            .SviewMsg_body {
                height: 350px;
                overflow-y: auto;
                overflow-x: hidden;
            }
            .SviewMsg_footer {
                border-top: 1px solid rgb(220,220,220);
                height: 30px;
                padding-top: 5px;
            }
            .SviewMsg_icon, .SviewMsg_rmf {
                display: inline-block;
                height: 20px;
            }
            .SviewMsg_icon {
                border-right: 1px solid rgb(220,220,220);
                width: 20px;
                background-image: url(./img/msg.png);
                background-repeat: no-repeat;
                background-position: center;
                padding: 5px;
                vertical-align: bottom;
                display: inline-block;
                height: 20px;
            }
            .SviewMsg_rmf {
                display: inline-block;
                height: 20px;
                font-size: 10pt;
                font-weight: bold;
                padding-bottom: 3px;
                padding-left: 5px;
            }
            .SviewMsg_del_btn {
                margin-left: 5px;
                width: 50px;
                height: 25px;
                border: 1px solid rgb(46,117,182);
                background-color: rgb(46,117,182);
                color: white;
            }
            .SviewMsg_tbl {
                border: 1px solid rgb(200,200,200);
                border-collapse: collapse;
                width: 380px;
                margin: 5px 10px;
            }
            .SviewMsg_tbl tr {
                border: 1px solid rgb(200,200,200);
            }
            .SviewMsg_tbl_td_senddate {
                text-align: right;
                padding: 6px 10px;
                background-color: rgb(250,250,250);
            }
            .SviewMsg_tbl_td_content {
                padding: 10px;
            }
        </style>
        <script src="messageJS.js"></script>
        <script>
        	function deleteView() {
        		var idx = <%=idx %>;
        		var fro = <%=fro %>;
        		var how = "삭제";
        		$.ajax({
            		type:"POST",
            		url:"./viewmessage",
            		data: {
            			idx: idx,
            			how: decodeURIComponent(how)
            		}, 
            		success: function(data) {
            			if ( data == "" ) {
            				alert("쪽지를 삭제할 수 없습니다.");
            			}
            			if ( data == "성공쓰" ) {
            				ChangeClo(fro);
            			}
            		}
            	});
        	}
        </script>
    </head>
    <body>
        
        <div class="SviewMsg_full">
            <div class="SviewMsg_header">
                <div class="SviewMsg_icon"></div>
                <div class="SviewMsg_rmf">
                    <%=sender %>
                </div>
            </div>
            <div class="SviewMsg_body">
                <table class="SviewMsg_tbl">
                    <tr>
                        <td class="SviewMsg_tbl_td_senddate">
                            <%=senddate %>
                        </td>
                    </tr>
                    <tr>
                        <td class="SviewMsg_tbl_td_content">
                            <%=content %>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="SviewMsg_footer">
                <button class="SviewMsg_del_btn">삭제</button>
            </div>
        </div>
        
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
   	 		$(document).ready(function() {
   	   	     	$(".SviewMsg_del_btn").click(function() {
            		deleteView();
            	});
            });
        </script>
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>