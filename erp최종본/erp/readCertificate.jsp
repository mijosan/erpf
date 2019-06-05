<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="erp.EmployeeBean"%>
<%@page import="erp.EmployeeMgr"%>
<%@page import="erp.certifiBean"%>
<%@page import="erp.certifiMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	int num = Integer.parseInt(request.getParameter("cer_num"));
	certifiMgr mgr = new certifiMgr();
	EmployeeMgr emgr = new EmployeeMgr();
	
	certifiBean ctBean = mgr.getCert(num);
	EmployeeBean ebean = emgr.getEmployee(ctBean.getCer_name(), ctBean.getCer_dept(), ctBean.getCer_job());
	SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
	SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy년 MM월 dd일");
	Date date = new Date();
	Date date2 = new Date();
	String date1 = format1.format(date);
	String today = format2.format(date2);
%>

<html>
    <head>
        <style>
            .wrap_cerfi{
                width: 800px;
                margin-top: 10px;
            }
            .certificate{
                border-collapse: collapse;
                text-align: center;
                margin: 0 auto;
            }
            .certificate_subject{
                background-color: #D5D5D5;
                width: 150px;
                height: 50px;
                font-weight: bold;
            }
            .certificate_contents{
                width: 180px;
            }
            .certification{
                border: 1px solid black;
                margin: 0 auto;
                width: 670px;
            }
             .newButton{
	        	width: 80px;
	        	background-color: rgb(46,117,182);
	        	border-radius: 25px;
	        	border: 1px solid #dee3eb;
	        	color: white;
	        	height:20px;
	        	margin-top:5px;
	        } 
        </style>
    </head>
    <body>
        <input type = "button" value="인쇄" onclick="cer_print()" class="newButton" id=>
        <div class="wrap_cerfi" id="wrap_cerfi">
            <h1 align=center>재 직 증 명 서</h1>
            <br>
            
            <!--증명서 양식 시작-->
            <table class="certificate" border="1">
                <tr>
                    <td class="certificate_subject">성 명</td><td class="certificate_contents"><%=ctBean.getCer_name() %></td><td class="certificate_subject">생년월일</td><td class="certificate_contents"><%=ebean.getEmp_birth() %></td>
                </tr>
                <tr>
                    <td class="certificate_subject">부 서</td><td class="certificate_contents"><%=ctBean.getCer_dept() %></td><td class="certificate_subject">직 급</td><td class="certificate_contents"><%=ctBean.getCer_job() %></td>
                </tr>
                <tr>
                    <td class="certificate_subject">E-mail</td><td colspan="3" class="certificate_contents"><%=ebean.getEmp_email() %></td>
                </tr>
                <tr>
                    <td class="certificate_subject">담당업무</td><td colspan="3" class="certificate_contents"><%=ctBean.getCer_task() %></td>
                </tr>
                <tr>
                    <td class="certificate_subject">재직기간</td><td colspan="3" class="certificate_contents"><%=ebean.getEmp_hireDate().substring(0,10)%>~<%=date1 %></td>
                </tr>
                <tr>
                    <td class="certificate_subject">용도</td><td colspan="3" class="certificate_contents"><%=ctBean.getCer_use()%></td>
                </tr>
            </table>
            <div class="certification">
                <br><br><br><br>
                <p align=center>위와 같이 재직하고 있음을 증명함.</p>
                <br><br>
                <p align=center><%=today %></p>
                 <br><br> <br><br>
                <p align=right>부산광역시 부산진구 동의대학교&nbsp;&nbsp;&nbsp;&nbsp;</p>
                <p align=right>(주) ERP_F&nbsp;&nbsp;&nbsp;&nbsp;</p>
                <br>
                <p align=right>대표이사 최 태 산 (인)&nbsp;&nbsp;&nbsp;&nbsp;</p>
                
            </div>
        </div>
        <script>
        	function cer_print(){
        		var printArea = document.getElementById("wrap_cerfi").innerHTML;
        		document.body.innerHTML = "<br/><br/><br/>"+ printArea;
        		window.print();
        	}
        </script>
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>