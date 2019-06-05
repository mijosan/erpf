<%@page import="erp.EmployeeBean"%>
<%@page import="erp.certifiMgr"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////

		EmployeeBean employeeBean3 = (EmployeeBean)session.getAttribute("employeeBean");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
		Date date = new Date();
		String date1 = format1.format(date);
		certifiMgr cMgr = new certifiMgr();
		int cnt = cMgr.getTotalCountC();
		if(cnt==0){
			cnt = 1;
		}else if(cnt!=0){
			cnt = cnt +1;
		}
%>
<html>
	<head>
		    <style>
            .btn_box{
                width: 500px;
            }
            .certifTable{
                width: 500px;                
            }
            .cerSelect{
            	width:120px;
            } 
            .cer_task{
            	width: 300px;
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
        </style>
	</head>
	<body>
		<table>
        <tr><td width="500">재직증명서 신청<hr/></td></tr>
        </table>
        <form name="applyfrm" method="post" action="certificateServlet">
        <table class="certifTable">
            <tr>
                <td class="subject">신청번호</td><td><input name="cer_num" value="<%if(cnt==0) cnt = 1; %><%=cnt %>" readonly></td>
                <td class="subject"  >신청자</td><td><input name="cer_name" value="<%=employeeBean3.getEmp_name()%>" readonly></td>
            </tr>            
            <tr>
                <td class="subject">부서</td><td><input name="cer_dept" value="<%=employeeBean3.getEmp_dept()%>" readonly></td>
				<td class="subject">직급</td><td><input name="cer_job" value="<%=employeeBean3.getEmp_job()%>" readonly></td>   
            </tr>            
            <tr>
                <td class="subject">제출용도</td><td><select class="cerSelect" name="cer_use">
				    <option value="은행">은행</option>
				    <option value="공공기관">공공기관</option>
				    <option value="공문">공문</option>
				    <option value="취업용">취업용</option></select></td>
                <td class="subject">신청일</td><td><input name="cer_date" value="<%=date1%>" readonly></td>
            </tr>
            <tr>			
				<td class="subject">담당업무</td><td colspan="3"><input name="cer_task" placeholder="담당업무 내용을 정확히 기입" class="cer_task"></td>
            </tr>           
        </table>
        <div class="btn_box">
			<input type="button" class="newButton" value="취 소" onclick="javascript:self.close()">     <input type="button" class="newButton" value="등 록" onclick="insertCertifi()"> 
        </div>
        </form>
        <script>
        function insertCertifi(){
    		/* 상위 4개 칸 빈칸 테스트 */
    		document.applyfrm.submit();
    	} 
        </script>
	</body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>