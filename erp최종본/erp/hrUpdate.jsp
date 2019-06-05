<%@page import="erp.EmployeeBean"%>
<%@page import="erp.EmployeeMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% 	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////

		int no = Integer.parseInt(request.getParameter("emp_num"));
		EmployeeMgr mgr = new EmployeeMgr();
		EmployeeBean bean = mgr.getEmployee(no);
%>
<html>
    <head>
    	<title>인사정보수정</title>
        <style>
        
            *{
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';                
            }
            .hrTitle{
                border-top:1px solid lightgray;
                border-bottom: 1px solid lightgray;
                width: 600px;
            }
            .tblSubject{
                background-color: lightgray;
                font-size: 12px;
            }
            .readHR td{
                border: 1px solid lightgray;
                text-align: center;
                font-size: 12px;
            }
            .readHR input:hover{
                background-color: antiquewhite;
            }
            .readHR input{
                float: left;
                width: 170px;
            }
            .buttons{
                width: 600px;
            }
            .readHR input[type=date]{
                float: left;
                width: 170px;
            }
            .buttons input[type=button]{
                background-color: rgb(46,117,182);
                border: 1px solid #eeeeee;
                color: white;
                width: 80px;
            }
            .hrImage{
                width: 100px;
                text-align: center;
            }
            .selectOption{
                float: left;
                width: 170px;
            }
        </style>
    </head>
    <body>
    <div class="hrTitle"><b>인사정보 수정</b></div>
    <div>
    	<form name="updatefrm" method="post" action="updateServlet">
        <table class="readHR">
            <tr><td rowspan="5" class="hrImage">이미지</td><td class="tblSubject">사원번호</td><td><input name ="emp_num" value="<%=bean.getEmp_num() %>" readonly ></td><td class="tblSubject">성명</td><td><input name="emp_name" value="<%=bean.getEmp_name() %>"></td></tr>
            <tr><td class="tblSubject">생년 월일</td><td><input name = "emp_birth" type="date" value="<%=bean.getEmp_birth() %>"></td><td class="tblSubject">입사일자</td><td><input name="emp_hireDate" type="date" value="<%=bean.getEmp_hireDate().substring(0,10)%>"></td></tr>
            <tr><td class="tblSubject">부서</td>
                <td><select name="emp_dept" class="selectOption">
				    <option value="인사부"<%if(bean.getEmp_dept().equals("인사부"))%> selected<% %>>인사부</option>
				    <option value="생산부"<%if(bean.getEmp_dept().equals("생산부"))%> selected<% %>>생산부</option>
				    <option value="영업부"<%if(bean.getEmp_dept().equals("영업부"))%> selected<% %>>영업부</option>
				    <option value="이사단"<%if(bean.getEmp_dept().equals("이사단"))%> selected<% %>>이사단</option>
				</select></td>
                <td class="tblSubject">직급</td>
                <td><select name="emp_job" class="selectOption">
				    <option value="이사" <%if(bean.getEmp_job().equals("이사"))%> selected<% %>>이사</option>
				    <option value="부장" <%if(bean.getEmp_job().equals("부장"))%> selected<% %>>부장</option>
				    <option value="사원" <%if(bean.getEmp_job().equals("사원"))%> selected<% %>>사원</option>
				    <option value="대리" <%if(bean.getEmp_job().equals("대리"))%> selected<% %>>대리</option>
				</select></td>
            </tr>
            <tr><td class="tblSubject">전화번호</td><td><input name="emp_phone" value="<%=bean.getEmp_phone()%>"></td><td class="tblSubject">Email</td><td><input name="emp_email" value="<%=bean.getEmp_email()%>"></td></tr>  
            <tr><td class="tblSubject">은행</td><td><input name="emp_bank" value="<%=bean.getEmp_bank()%>"></td><td class="tblSubject">계좌번호</td><td><input name="emp_account" value="<%=bean.getEmp_account()%>"></td></tr>             
        </table>
        </form>
        <div class="buttons">
        <input type="button" value="저 장" onclick="update()"><input type="button" value="닫 기">
        </div>
    </div>
    <script>
    	function update(){
    		if(document.updatefrm.emp_name.value==""||document.updatefrm.emp_birth.value==""||document.updatefrm.emp_hireDate.value==""
				||document.updatefrm.emp_dept.value==""||document.updatefrm.emp_job.value==""){
			alert("모든 정보를 입력하세요.");
			document.updatefrm.emp_name.focus();
			return;
		}
    		var EmailId = document.updatefrm.emp_email.value;
    		var emailfilter = /^[\w._-]+[+]?[\w._-]+@[\w.-]+\.[a-zA-Z]{2,6}$/;
    		if((EmailId != "") && (!(emailfilter.test(EmailId ) ) )) {
    			alert("이메일 형식을 맞춰주세요.");
    			document.updatefrm.emp_email.focus();
    			return;
    		}
    		var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
    		var phone = document.updatefrm.emp_phone.value;
    		if((phone != "") && (!(regExp.test(phone ) ) )) {
    			alert("전화번호 형식을 맞춰주세요.");
    			document.updatefrm.emp_phone.focus();
    			return;
    		}
    	document.updatefrm.submit();
    	}
    </script>
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>