<%@page import="erp.EmployeeMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");	%>
<%
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	EmployeeMgr mgr = new EmployeeMgr();
	int num  = mgr.getNextEnum();	
%>
<html>
    <head>
        <style>
            .noimg{
                width: 80px;
                height: 125px;
            }
            .btn_box{
                width: 600px;
            }
            .registerTable{
                width: 600px;                
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
        </style>
    </head>
    <body>
    	<script>
    	function insertEmployee(){
    		/* 상위 4개 칸 빈칸 테스트 */
    		if(document.regfrm.emp_name.value==""||document.regfrm.emp_birth.value==""||document.regfrm.emp_hireDate.value==""
    				||document.regfrm.emp_dept.value==""||document.regfrm.emp_job.value==""){
    			alert("모든 정보를 입력하세요.");
    			document.regfrm.emp_name.focus();
    			return;
    		}
    		/* 이메일 형식 테스트 */
    		var EmailId = document.regfrm.emp_email.value;
    		var emailfilter = /^[\w._-]+[+]?[\w._-]+@[\w.-]+\.[a-zA-Z]{2,6}$/;
    		if((EmailId != "") && (!(emailfilter.test(EmailId ) ) )) {
    			alert("이메일 형식을 맞춰주세요.");
    			document.regfrm.emp_email.focus();
    			return;
    		}
    		/* 전화번호 형식 테스트 */
    		var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
    		var phone = document.regfrm.emp_phone.value;
    		if((phone != "") && (!(regExp.test(phone ) ) )) {
    			alert("전화번호 형식을 맞춰주세요.");
    			document.regfrm.emp_phone.focus();
    			return;
    		}
    			document.regfrm.submit();
    	} 
    	</script>
        <table>
        <tr><td width="600">인사정보 등록<hr/></td></tr>
        </table>
        <form name="regfrm" method="post" action="employeeServlet">
        <table class="registerTable">
            <tr>
                <td rowspan="5"><img src="img/noimage.PNG" class="noimg"></td><td class="subject">사원 번호</td><td><input name="emp_num" readonly value=<%=num %>></td><td class="subject" >성명</td><td><input name="emp_name"></td>
            </tr>            
            <tr>
                <td class="subject">생년 월일</td><td><input type="date" name="emp_birth"></td><td class="subject">등록날짜</td><td><input type="date" name="emp_hireDate"></td>
            </tr>
            <tr>
                <td class="subject">부서</td><td><select name="emp_dept">
				    <option value="인사부">인사부</option>
				    <option value="생산부">생산부</option>
				    <option value="영업부">영업부</option>
				    <option value="이사단">이사단</option>
				</select>
				</td>
				<td class="subject">직급</td><td><select name="emp_job">
				    <option value="이사">이사</option>
				    <option value="부장">부장</option>
				    <option value="사원">사원</option>
				    <option value="대리">대리</option>
				</select></td>
            </tr>
            <tr>
                <td class="subject">은행</td><td><input name="emp_bank"></td><td class="subject">계좌 번호</td><td><input name="emp_account"></td>
            </tr>
            <tr>
                <td class="subject">전화 번호</td><td><input type="tel" name="emp_phone" placeholder="010-000-0000"></td><td class="subject">Email</td><td><input type="email" name="emp_email" placeholder="aaa@gmail.com" required></td>
            </tr>
        </table>
        <div class="btn_box">
			<input type="button" class="newButton" value="취 소" onclick="javascript:self.close()">     <input type="button" class="newButton" value="등 록" onclick="insertEmployee()"> 
        </div>
        </form>
        
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>