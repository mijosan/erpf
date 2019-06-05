<%@page import="java.text.*"%>
<%@page import="java.util.*" %>
<%@page import="erp.MessageBean"%>
<%@page import="java.util.Vector"%>
<%@page import="erp.MessageMgr"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
if (session.getAttribute("idKey") != null) {
	int id = (Integer) session.getAttribute("idKey");
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date date = new Date();
	String today = dateFormat.format(date).substring(0,10);
	MessageMgr msgMgr = new MessageMgr();
%>
<html>
    <head>
        <style>
            * {
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .Smessage_full {
                width: 698px;
                height: 400px;
            }
            .Smessage_body {
                margin: 5px 10px 5px 10px;
                height: 320px;
            }
            .Smessage_footer {
                height: 30px;
                border-top: 1px solid rgb(220,220,220);
                padding-top: 5px;
            }
            .Smtabs {
                width: 676px;
                height: 25px;
            }
            .Stab_content {
                width: 675px;
                height: 290px;
                margin-left: 2px;
                margin-top: 5px;
                overflow: hidden;
                overflow-y: auto;
            }
            .Smtab_back {
                border: 1px solid rgb(220,220,220);
                border-top-left-radius: 18px;
                border-top-right-radius: 2px;
                height: 10px;
                width: auto;
                display: inline-block;
                padding: 7px;
                background-color: rgb(250,250,250);
                color: dimgray;
            }
            .Smtab_front {
                border: 1px solid rgb(46,117,182);
                border-top-left-radius: 18px;
                border-top-right-radius: 2px;
                height: 10px;
                width: auto;
                display: inline-block;
                padding: 7px;
                background-color: rgb(46,117,182);
                color: white;
            }
            #Smtab1 { margin: 0px;}
            #Smtab2 { margin-left: -5px;}
            #Smtab3 { margin-left: -5px;}
            #Smtab4 { margin-left: -5px;}
            #Smtab5 { 
                border-bottom: 1px solid rgb(220,220,220);
                width: 483px;
                display: inline-block;
                vertical-align: bottom;
                margin: -5px 0px 0px -5px;
            }
            
            .Stblmessage {
                width: 655px;
                text-align: center;
                border-collapse: collapse;
                border-top: 2px solid rgb(200,220,220);
                border-bottom: 2px solid rgb(200,220,220);
            }
            table.tblmessage tr, table.tblmessage td {
                border: 1px solid rgb(220,220,220);
                padding: 3px;
            }
            table.Stblmessage .Smsg_tr_title {
                background-color: rgb(250,250,250);
                height: 40px;
                color: dimgray;
            }
            .Smsg_icon, .Smsg_rmf, .Smsg_search {
                display: inline-block;
                border-bottom: 1px solid rgb(220,220,220);
                height: 25px;
            }
            .Smsg_icon {
                border-right: 1px solid rgb(220,220,220);
                width: 25px;
                background-image: url(./img/msg.png);
                background-repeat: no-repeat;
                background-position: center;
                padding: 5px;
                vertical-align: bottom;
            }
            .Smsg_rmf {
                width: 640px;
                font-size: 10pt;
                font-weight: bold;
                vertical-align: baseline;
                margin-left: -4px;
                padding-left: 10px;
            }
            .Smsg_search {
                padding-right: 10px;
                vertical-align: bottom;
                margin-left: -4px;
            }
            .Si_msg_search {
                height: 20px;
                border: 1px solid rgb(220,220,220);
            }
            .Sbtn_msg_search {
                border: 1px solid rgb(46,117,182);
                background-color: rgb(46,117,182);
                color: white;
                height: 20px;
            }
            .Smsg_new_btn {
                margin-left: 5px;
                width: 50px;
                height: 25px;
                border: 1px solid rgb(46,117,182);
                background-color: rgb(46,117,182);
                color: white;
            }
            
            
            .SsendMessage {
                border: 1px solid rgb(0, 90, 129);
                background-color: white;
                width: 400px;
                height: 450px;
                position: absolute;
                left: 400px;
                top: 50px;
            }
            .SsendMessage_tool {
                background-color: rgb(46,117,182);
                border-bottom: 1px solid rgb(0,90,129);
                height: 30px;
            }
            .SsendMessage_rmf {
                color: white;
                font-weight: bold;
                display: inline-block;
                width: 355px;
                height: 20px;
                margin-left: 8px;
            }
            .SsendMessage_clo{
                vertical-align: bottom;
                display: inline-block;
                border-left: 1px solid rgb(0,90,135);
                width: 30px;
                height: 30px;
                background-position: center;
                background-repeat: no-repeat;
                background-image: url(./img/clo.png);
            }
            
            
            .SviewMessage {
                border: 1px solid rgb(0, 90, 129);
                background-color: white;
                width: 400px;
                height: 450px;
                position: absolute;
                left: 400px;
                top: 50px;
            }
            .SviewMessage_tool {
                background-color: rgb(46,117,182);
                border-bottom: 1px solid rgb(0,90,129);
                height: 30px;
            }
            .SviewMessage_rmf {
                color: white;
                font-weight: bold;
                display: inline-block;
                width: 355px;
                height: 20px;
                margin-left: 8px;
            }
            .SviewMessage_clo{
                vertical-align: bottom;
                display: inline-block;
                border-left: 1px solid rgb(0,90,135);
                width: 30px;
                height: 30px;
                background-position: center;
                background-repeat: no-repeat;
                background-image: url(./img/clo.png);
            }
            
            
            
        </style>
        <script>
        	function getMsgList(how) {
        		// 앞에 썼던 내용 지우기
                $(".Smsg_tr_title").nextAll().detach();
        		
                // 탭의 색상 변경
            	for (var i = 1; i < 5; i++) {
                    $("#Smtab" + i).removeClass();
                    if (how == i) {
                        $("#Smtab" + i).addClass("Smtab_front");
                    } else {
                        $("#Smtab" + i).addClass("Smtab_back");
                    }
                }
        		
        		var id = <%= id %>;
        		$.ajax({
        			type: "POST",
        			url: "./message",
        			data: {
        				id: id,
        				how: how
        			},
        			success: function(data) {
        				if ( data == "" )	 {
        	        		$(".Smsg_tr_title").after("<tr><td colspan=5>확인된 쪽지가 없습니다.</td></tr>");
        					return;
        				}
        				var parsed = JSON.parse(data);
        				var result = parsed.result;
        				for ( var i = 0; i < result.length; i++ ) {
        					addList(i, result[i].idx, result[i].content, result[i].send, result[i].senddate, result[i].condate);
        				}
        			}
        		});
        	}
        	
        	function addList(i, idx, content, send, senddate, condate) {
        		$(".Smsg_tr_title").after("<tr class='SviewCon' id=" + idx + "><td>" + (i + 1) + "</td><td>" + send + "</td><td>" + content + "</td><td>" + senddate.substring(0,10) + "</td><td>" + condate + "</td></tr>");
        	}
        </script>
    </head>
    <body>
        <div class="Smessage_full">
            <div class="Smessage_header">
                <div class="Smsg_icon"></div>
                <div class="Smsg_rmf">쪽지</div>
               	<div class="Smsg_search">
                <!--<input type="text" class="i_msg_search">
                    <button class="btn_msg_search">Search</button>-->
                </div>
            </div>
            <div class="Smessage_body">
                <div class="Smtabs">
                    <div id="Smtab1" class="Smtab_front">전체</div>
                    <div id="Smtab2" class="Smtab_back">미확인</div>
                    <div id="Smtab3" class="Smtab_back">확인</div>
                    <div id="Smtab5">  </div>
                    <div id="Smtab4" class="Smtab_back">보낸쪽지</div>
                </div>
                <div class="Stab_content">
                    <table class="StblMessage">
                        <tr class="Smsg_tr_title">
                            <td class="Std_title" width="20"></td>
                            <td class="Std_title" width="140">보낸사람</td>
                            <td class="Std_title" width="300">내용</td>
                            <td class="Std_title" width="70">보낸날짜</td>
                            <td class="Std_title" width="70">상태</td>
                        </tr>
                    </table>
                </div>
			</div>                        
       		<div class="Smessage_footer">
	           <button class="Smsg_new_btn">신규</button>
       		</div>           
  		</div>

		
		<div class="SsendMessage">
            <div class="SsendMessage_tool">
                <div class="SsendMessage_rmf">쪽지 보내기</div>
                <div class="SsendMessage_clo"></div>
            </div>
            <div class="SsendMessage_include"></div>
        </div>
        
        <div class="SviewMessage">
            <div class="SviewMessage_tool">
                <div class="SviewMessage_rmf">쪽지 조회</div>
                <div class="SviewMessage_clo"></div>
            </div>
            <div class="SviewMessage_include"></div>
        </div>

		<script src="messageJS.js"></script>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            $(document).ready(function(){
               	var fro = 0;
            	
            	getMsgList(1);
            	$(".Stab_content2").hide();
            	$(".Stab_content3").hide();
            	$(".Stab_content4").hide();
            	$(".SsendMessage").hide();
            	$(".SviewMessage").hide();
            	
                $("#Smtab1").click(function(){
                    getMsgList(1);
                });
                $("#Smtab2").click(function(){
                    getMsgList(2);
                });
                $("#Smtab3").click(function(){
                    getMsgList(3);
                });
                $("#Smtab4").click(function(){
                    getMsgList(4);
                });
                $(".Smsg_new_btn").click(function(){
                	$(".SsendMessage").show();
                	$(".SsendMessage_include").load("sendMessage.jsp");
                	$(".SsendMessage").draggable();
                });
                $(".SsendMessage_clo").click(function(){
                	$(".SsendMessage").hide();
                });
                $(document).on("click",".SviewCon",function() {
                	for ( var i = 0; i < 5; i++ ) {
                		if ($("#Smtab" + i).attr("class") == "Smtab_front")
                			fro = i;
                	}
                	$(".SviewMessage").show();
                	$(".SviewMessage_include").load("viewMessage.jsp?idx=" + $(this).attr("id") + "&fro=" + fro);
                	$(".SviewMessage").draggable();	
                });
                $(".SviewMessage_clo").click(function(){
                	ChangeClo(fro);
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