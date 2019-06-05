<%@page import="erp.EmployeeBean"%>
<%@page import="erp.SalaryMgr"%>
<%@page import="erp.SalaryBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	Vector<SalaryBean> salaryList = new Vector<SalaryBean>();
	SalaryMgr sMgr = new SalaryMgr();
	EmployeeBean salaryEmployee = (EmployeeBean)session.getAttribute("employeeBean");
	int totalRecord = sMgr.getAllCount();
	int numPerPage = 10;
	int totalpage = (int)Math.ceil((double)totalRecord/numPerPage);
	int nowPage = 1;
	int start=1; //디비의 select 시작번호
    int end=numPerPage; //시작번호로 부터 가져올 select 갯수
	  if(request.getParameter("nowPage")!=null){	//다른 페이지로 넘어갈때 nowPage값을 넘겨줌. null이 아니면 해당 값을 받아옴.
  	  nowPage = Integer.parseInt(request.getParameter("nowPage"));
  	  start = (nowPage * numPerPage)-numPerPage +1;  //ex)2페이지면 16번부터 30번까지.나와야 하므로 (2*15)-15 = 15 -> 15다음부터 나오면 됨.
    }
	  end = nowPage * numPerPage;
	salaryList = sMgr.getAllSalary(start,end);
%>
<html>
    <head>
       <style>
       	  .salary-case{
       	  	  width: 1100px; /* 
                margin-left: 10px;
                margin-top: 10px; */
                margin : 0 auto;
       	  }
           .salaryHeader{
               background-color: #D5D5D5;
	           text-align: center;
           }
           .salaryHeader td{
               width: 120px;
           }
           .salarytbl{
               border : 1px solid #dee3eb;
               text-align: center;               
               border-collapse: collapse;  
           }
            * {
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
	        }
	        .salary_tbl_header{            	
            	border-top : 1px solid #dee3eb;
            	border-bottom: 1px solid #dee3eb;
            	padding-top: 5px;
            	padding-bottom : 7px;
            }
            .salary_tbl_header img{
            	width:10px;
            	heigh:10px;
            }
            .salary_footer {
			    position:fixed;			
			    bottom:0;
			    width:1100px;		
			    height:50px;
			    border-top: 3px solid #dee3eb;
			    margin:auto;
			    left:50%; 
			    transform:translateX(-50%);
			}
			 a{
	        	text-decoration:none;
	        	color:black;
	        }
	        a:visited{
	        	color:black;
	        }
        </style>
    </head>
    <body>
    <%@ include file="top.jsp" %>
	<%@ include file="menu.jsp" %>
	<div class="salary-case">
	  <div class="noneheader">
                <div class="H1"></div>
                <div class="H2"></div>
            </div>
            <br/>
	<div class="salary_tbl_header"><img src="img/star.png"><b> &nbsp;급여대장입력/조회</b><br/></div>
    <table border="1" class="salarytbl">
    	<tr>
    	 <img src="img/1.gif" >
	       <!-- 이전 페이지 넘어가기  -->
		   <a href="#"><img src="img/2.gif" ></a>
		   <!-- 페이징처리 -->
		   <%for(int i=1; i<=totalpage; i++){ %>
		   <a href="javascript:pageing('<%=i%>')">
		   <%if(i==nowPage){ %><font color="red"><%} %>
				[<%=i %>]
				<%if(i==nowPage){ %></font><%} %>	</a>
		   <% }%>
		   <a href="#"><img src="img/3.gif"></a>
		   <!-- 다음 페이지 넘어가기 끝 -->
		   <img src="img/4.gif"><br><br>
    	</tr>
         <tr class="salaryHeader" >	        
	        <td>급여대장번호</td>
            <td>대장명칭</td>
            <td>부서</td>
            <td>이름</td>
            <td>직급</td>
            <td>지급일</td>
            <td>지급총액(원)</td>
            <td>지급상태</td>
            <%if(salaryEmployee.getEmp_dept().equals("인사부") && salaryEmployee.getEmp_job().equals("부장")||salaryEmployee.getEmp_job().equals("이사")){%>
            <td>지급상태변경</td>
            <%} %>
	      </tr>
	     
        <%for(int i=0; i< salaryList.size(); i++) { 
        	SalaryBean bean2 = new SalaryBean();
        	bean2 = salaryList.get(i);
        %>      
        	 <tr>  	
            <td><%=bean2.getSalary_num() %></td><!--월+사번-->
            <td><%=bean2.getSalary_name() %></td>
            <td><%=bean2.getSalary_dept() %></td>
            <td><%=bean2.getSalary_empname() %></td>
            <td><%=bean2.getSalary_job() %></td>
            <td><%=bean2.getSalary_date() %></td>
            <td><%=bean2.getSalary_content() %>원</td>
            <td><%=bean2.getSalary_state() %></td>
            <%if((salaryEmployee.getEmp_dept().equals("인사부")&&salaryEmployee.getEmp_job().equals("부장"))||salaryEmployee.getEmp_job().equals("이사")){            	
            %>
            <td>
            <select class="salarySelect" name="newstate" id="salarySelect<%=i+1%>">
				    <option value="지급대기">지급대기</option>
				    <option value="보류">보류</option>
				    <option value="지급처리중">지급처리중</option>
				    <option value="지급완료">지급완료</option>				    
			</select>			
			<input type="button" value="변 경" class="newButton" onclick="updateState('<%= bean2.getSalary_num()%>',<%=i+1%>)">
			</td>
            <%} %><!-- if문종료 --> 
            </tr>          
        <%}%>   <!-- for문 종료 -->
           
    </table>
    <form name="stateChange" method="post" action="updateStateServlet">
    	<input type="hidden" name="salary_num" value="">
    	<input type="hidden" name="salary_state" value="">
    </form>
    <form name="readFrm">
			<input type="hidden" name="totalRecord" value="<%=totalRecord%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			</form>
    </div>
        <footer>
            <div class="salary_footer" id="footer"><input type = button value=" 신 규 " onclick="openSalaryPlus()" class="newButton"> 
            </div>
        </footer>
        <script>
        function openSalaryPlus(){
            newWindow = window.open("salaryPlus.jsp","급여등록","height=250px,width=650px, left=400px, top=200px");
        };       
        </script>
        <script>
        function updateState(date, id){
        	
        	var target = document.getElementById("salarySelect"+id);
        	var newState = target.options[target.selectedIndex].value;     	
        	
        	document.stateChange.salary_num.value = date;
        	document.stateChange.salary_state.value = newState;
        	document.stateChange.submit();
        };
        </script>
        <script>/* 페이징 처리 함수 */
        function pageing(page) {
        	if(page<=0) page=1;
        	if(page><%=totalpage%>) page = <%=totalpage%>;
    		document.readFrm.nowPage.value = page;
    		document.readFrm.submit();
    	}

    	function block(value){
    	 	<%-- document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1; --%>
    	 	document.readFrm.submit();
    	} 
        </script>
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>