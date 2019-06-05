<%@page import="java.net.InetAddress"%>
<%@page import="erp.EmployeeBean"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%
	request.setCharacterEncoding("utf-8");
if (session.getAttribute("idKey") != null) {
	int id = (Integer) session.getAttribute("idKey");
	EmployeeBean employeeBean = (EmployeeBean) session.getAttribute("employeeBean");
	
	
	String thisIp = InetAddress.getLocalHost().toString();
	int idx = thisIp.indexOf("/") + 1;
	String ip = thisIp.substring(idx, thisIp.length());
	
	 String time = "";
	if (session.getAttribute("time") != null) {
		time = (String) session.getAttribute("time");
	}
	String time2 = "";
	if (session.getAttribute("time2") != null) {
		time2 = (String) session.getAttribute("time2");
	} 
	
%>
<html>
    <head>
        <style>
            * {
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .SSfull {
                width: 350px;
            }
            .Sp_1 {
                background-color: rgb(46,117,182);
                height: 150px;
                color: white;
                margin: 0;
                padding-top: 10px;
            }
            .Sp_2 {
                background-color: rgb(250,250,250);
                margin-top: -50px;
                height: 263px;
            }
            .Spic {
                background-color: white;
                width: 100px;
                height: 100px;
                margin-top: -339px;
                margin-left: 117px;
                border: 7px solid rgb(0,0,0,0.2);
                text-align: center;
                border-radius: 10px;
                
            }
            .Sp_name {
                padding-top: 40px;
                font-size: 17px;
                font-weight: bold;
                text-align: center;
            }
            .Sip {
                margin-left: 190px;
            }
            .Sedi_pwd {
                width: 100px;
                margin-top: 80px;
                margin-left: 250px;
            }
            .Sicon {
                vertical-align: bottom;
                width: 13px;
                height: 16px;
                margin-right: 10px;
            }
            .Simg_pic { 
                width: 50px;
                height: 60px;
                margin-top: 20px;
            }
            .Sd_name, .Sd_phone, .Sd_email {
                margin: 10px 40px 20px 110px;
            }
           .SnewButton{
	        	width: 80px;
	        	background-color: rgb(46,117,182);
	        	border-radius: 25px;
	        	border: 1px solid #dee3eb;
	        	color: white;
	        	height:20px;
                display: inline-block;
                 margin-left: 10px;
	        }
             .SnewButton2{
	        	width: 80px;
	        	background-color: rgb(46,117,182);
	        	border-radius: 25px;
	        	border: 1px solid #dee3eb;
	        	color: white;
	        	height:20px;
	        	margin-left: 10px;
                 margin-top: 5px;
	        }
        </style>
    </head>
    <body>
        
        <div class="SSfull">
                <div class="Sp_1">
                    <span class="Sip">접속 IP : <%=ip %></span>
                    <div class="Sedi_pwd">
                        <img class="Sicon" src="./img/wkanfthl.png">
                        <span class="Sspa_pwd">비밀번호변경</span>
                    </div>
                </div>
                <div class="Sp_2">
                    <p class="Sp_name"><%=employeeBean.getEmp_name() %></p>
                    <div class="Sd_name">
                        <img class="Sicon" src="./img/person2.png">
                        <span class="Sspa_name"><%=employeeBean.getEmp_dept() %> / <%=employeeBean.getEmp_job() %></span>
                    </div>
                    <div class="Sd_phone">
                        <img class="Sicon" src="./img/iphone.png">
                        <span class="Sspa_phone"><%=employeeBean.getEmp_phone() %></span>
                    </div>
                    <div class="Sd_email">
                        <img class="Sicon" src="./img/email.png">
                        <span class="Sspa_email"><%=employeeBean.getEmp_email() %></span>
                    </div>
                    <form action="CommutingProc.jsp">
                    <input type="submit" value=" 출 근 " class="SnewButton">
                    <span id="Sti"></span>
					<input type="hidden" name="출퇴" value="출근">
				</form>
				 
				<form action="CommutingProc.jsp">
					<input type ="submit" value=" 퇴 근 " class="SnewButton2">
					<span id="Sti2"></span>
					<input type="hidden" name="출퇴" value="퇴근">
				</form>
          
        
                <div class="Spic">
                    <img class="Simg_pic" src="./img/noimage.png">
                </div>
                
                
            </div>
        
        
        
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            $(document).ready(function(){
            		 $("#Sti").text("<%=time %>");
            		$("#Sti2").text("<%=time2 %>");
            });
        </script>
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>