<%@page import="erp.EmployeeBean"%>
<%@page import="erp.EmployeeMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
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
    	<title>인사정보조회</title>
        <style>
        	*{
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';                
            }
            .readHr td{
            	font-size:12px;
            	width:170px;
            }
            .hrTitle{
                border-top:1px solid lightgray;
                border-bottom: 1px solid lightgray;
                width: 580px;   
            }
            .tblSubject{
                background-color: lightgray;
            }
            .readHR td{
                border: 1px solid lightgray;
                text-align: center;
            }
            .buttons{
                width: 580px;            
            }
            .buttons input[type=button]{
                background-color: rgb(46,117,182);
                border: 1px solid #eeeeee;
                color: white;
                width: 80px;
                float:right;
            }
            .hrImage{
                width: 100px;
                text-align: center;
            }
        </style>
    </head>
    <body>
    <div class="hrTitle"><b>인사정보 조회</b></div>
    <div>
        <table class="readHR">
            <tr><td rowspan="5" class="hrImage">이미지</td><td class="tblSubject">사원번호</td><td><%=bean.getEmp_num() %></td><td class="tblSubject">성명</td><td><%=bean.getEmp_name() %></td></tr>
            <tr><td class="tblSubject">생년월일</td><td><%=bean.getEmp_birth()%></td><td class="tblSubject">입사일자</td><td><%=bean.getEmp_hireDate().substring(0,10)%></td></tr>
            <tr><td class="tblSubject">부서</td><td><%=bean.getEmp_dept() %></td><td class="tblSubject">직급</td><td><%=bean.getEmp_job() %></td></tr>
            <tr><td class="tblSubject">전화번호</td><td><%=bean.getEmp_phone()%></td><td class="tblSubject">Email</td><td><%=bean.getEmp_email()%></td></tr>
            <tr><td class="tblSubject">은행</td><td><%=bean.getEmp_bank()%></td><td class="tblSubject">계좌번호</td><td><%=bean.getEmp_account()%></td></tr>            
        </table>
        <div class="buttons">
        <input type="button" value="수 정" onclick="goUpdate(<%=bean.getEmp_num()%>)"><input type="button" value="닫 기" onclick="javascript:self.close()">
        </div>
    </div>
    </body>
    <script type="text/javascript">
    	function goUpdate(no){
    		url = "hrUpdate.jsp?emp_num=" + no;
    		window.open(url,"post","height=400px,width=700px, left=400px, top=200px");
    	}
    </script>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>