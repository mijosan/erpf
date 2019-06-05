<%@page import="erp.EmployeeBean"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Vector"%>
<%@page import="erp.EmployeeMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
%>
<html>
    <head>
        <style>
            .btn_box{
                width: 600px;
            }
            .holidayTable{
                width: 300px;
                         
            }
            .holidaySelect{
            	width:120px;
            }
            .sm{
                margin-left: 500px;
            }
            .subject{
                background-color: aliceblue;
            }
            *{
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .newButton{
	        	width: 80px;
	        	background-color: rgb(46,117,182);
	        	border-radius: 25px;
	        	border: 1px solid #dee3eb;
	        	color: white;
	        	height:20px;
	        	margin-top:5px;
	        	float:right;
	        }
	        #hrhr{
	        	color:rgb(46,117,182);
	        }
        </style>
    </head>
    <body>
    	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
    	
        <table>
        <tr><td width="600"><h2>근태 등록</h2><hr id="hrhr"/></td></tr><br>
        </table>
        <form name="Holidayfrm" method="post" action="HolidayPlusProc.jsp">
        <table class="holidayTable">
        	<tr>
        	<td>시작일</td><td>종료일</td><td>근태항목</td>
        	</tr>
            <tr>
                <td><input type="date" name="holiday_first"></td><td><input type="date" name="holiday_end"></td>
                <td><select class="holidaySelect" name="holiday_content">
                	<option value="">선택하세요</option>
				    <option value="경조사">경조사</option>
				    <option value="예비군">예비군</option>
				    <option value="결혼">결혼</option>
				    <option value="휴가">휴가</option>
				    <option value="조퇴">조퇴</option>
				    <option value="기타">기타</option>
				    </select></td>
            </tr> 
        </table>
        <div class="btn_box">
			<input type="button" class="newButton" value="취 소" onclick="javascript:self.close()">     <input type="submit" class="newButton" value="등 록"> 
        </div>
        </form>
    </body>
</html>

<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>