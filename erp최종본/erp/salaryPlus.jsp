<%@page import="erp.SalaryMgr"%>
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
	  EmployeeMgr mgr = new EmployeeMgr();
	  Vector<String> namelist = new Vector<String>();
	  namelist = mgr.getEmployeeName();
	  SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM");
	  Date date = new Date();
	  String date1 = format1.format(date);
	  EmployeeBean salaryEmployee = (EmployeeBean)session.getAttribute("employeeBean");
	  SalaryMgr sMgr2 = new SalaryMgr();
%>
<html>
    <head>
        <style>
            .btn_box{
                width: 600px;
            }
            .salaryTable{
                width: 700px;                
            }
            .salarySelect{
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
        </style>
    </head>
    <body>
    	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
    	<script>
    	//지급액 입력 테스트(숫자만 가능하며 천단위 콤마 찍음)
    	$(function() {
    		  var $input = $("#salary_content");
    		  $input.on('blur', function() {
    		    // 입력 값 알아내기
    		    var _$self = $(this);
    		    var value = _$self.val();

    		    // 원단위로 변경하기
    		    var result = AddComma(value);

    		    _$self.val(result);
    		  })

    		});

    		function AddComma(dataValue) {
    		  isNumber(dataValue);
    		  var separateValue = Number(dataValue).toLocaleString('en');
    		  if (separateValue == 'NaN') {
    		    return '';
    		  }
    		  return separateValue;
    		}

    		function isNumber(checkValue) {
    		    checkValue = '' + checkValue;
    		    if (isNaN(checkValue) || checkValue == "") {
    		      alert('숫자만 입력해 주세요!!!');
    		      return;
    		    }
    		}
    	function insertSalary(){
    		/* 상위 4개 칸 빈칸 테스트 */
    		if(document.salaryfrm.salary_num.value==""||document.salaryfrm.salary_name.value==""||document.salaryfrm.salary_dept.value==""
    				||document.salaryfrm.salary_job.value==""||document.salaryfrm.salary_state.value==""){
    			alert("모든 정보를 입력하세요.");
    			document.regfrm.salary_num.focus();
    			return;
    		}
    			document.salaryfrm.submit();
    	} 
    	</script>
        <table>
        <tr><td width="600">급여대장 등록<hr/></td></tr>
        </table>
        <form name="salaryfrm" method="post" action="salaryInsertServlet">
        <table class="salaryTable">
            <tr>
                <td class="subject">급여대장번호</td><td><input name="salary_num" value="<%=date1%>-<%=sMgr2.getAllCount()+1 %>" readonly></td>
                <td class="subject"  >대장명칭</td><td><input name="salary_name" placeholder="0월급여"></td>
            </tr>            
            <tr>
                <td class="subject">부서</td><td><select class="salarySelect" name="salary_dept">
				    <option value="인사부">인사부</option>
				    <option value="생산부">생산부</option>
				    <option value="영업부">영업부</option>
				    <option value="이사단">이사단</option></select></td>
				    <td class="subject">이름</td>
				    <td>
				    <select class="salarySelect" name="salary_empname">
				    <%for(int i=0; i<namelist.size();i++){ String name = namelist.get(i); %>				    	
						    <option value="<%=name%>"><%=name%></option>						
				    <%} %>
				    </select></td>
            </tr>
            <tr>                
				<td class="subject">직급</td><td><select class="salarySelect" name="salary_job">
				    <option value="이사">이사</option>
				    <option value="부장">부장</option>
				    <option value="사원">사원</option>
				    <option value="대리">대리</option>
				</select></td>
				<td class="subject">지급일</td><td><input type="date" name="salary_date"></td>
            </tr>
            <tr>
                <td class="subject">지급액</td><td><input name="salary_content" id="salary_content"></td>
                <td class="subject">지급상태</td><td><select class="salarySelect" name="salary_state">
				    <option value="지급대기">지급대기</option>
				    <option value="보류">보류</option>
				    <option value="지급처리중">지급처리중</option>
				    <option value="지급완료">지급완료</option>				    
				</select></td>
            </tr>           
        </table>
        <div class="btn_box">
			<input type="button" class="newButton" value="취 소" onclick="javascript:self.close()">     <input type="button" class="newButton" value="등 록" onclick="insertSalary()"> 
        </div>
        </form>
        
    </body>
</html>

<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>