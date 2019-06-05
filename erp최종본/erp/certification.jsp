<%@page import="erp.EmployeeBean"%>
<%@page import="erp.certifiBean"%>
<%@page import="java.util.Vector"%>
<%@page import="erp.certifiMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	  certifiMgr cMgr = new certifiMgr();
	  Vector<certifiBean> clist = new Vector<certifiBean>();
	  clist = cMgr.getAllCertificate();
	  EmployeeBean employeeBean4 = (EmployeeBean)session.getAttribute("employeeBean");
%>
<html>
	<head>
		<link href="style.css" rel="stylesheet" type="text/css">
		<style>
			* {
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .tblheader{            	
            	border-top : 1px solid #dee3eb;
            	border-bottom: 1px solid #dee3eb;
            	padding-top: 5px;
            	padding-bottom : 7px;
            }
            .tblheader img{
				width:10px;
				height:10px;
			}			            
            .wrap_cerf { 
                width: 1100px; /* 
                margin-left: 10px;
                margin-top: 10px; */
                margin : 0 auto;
            }            
	        .cerftable{
	        	border-collapse: collapse;
	        	text-align:center;
	        	border-color:#dee3eb;
	        }
	        .cerfHeader{
               background-color: #D5D5D5;
	           text-align: center;
           }
           .cerfHeadTitle{
           		height:30px;
           		width: 120px;
           }
           .footer {
			    position:fixed;			
			    bottom:0;
			    width:1100px;		
			    height:50px;
			    border-top: 3px solid #dee3eb;
			    margin:auto;
			    left:50%; 
			    transform:translateX(-50%);
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
	<%@ include file="top.jsp" %>
	<%@ include file="menu.jsp" %>	
	<div class="wrap_cerf" id="wrap_cerf">
            <div class="noneheader">
                <div class="H1"></div>
                <div class="H2"></div>
            </div>
            <br/>
          
         <div class="tblheader"><img src="img/star.png"><b> &nbsp;증명관리 신청/조회</b><br/></div>
         <table border="1" width="1100px" class="cerftable">
         	    	<tr>
    	 <img src="img/1.gif" >
	       <!-- 이전 페이지 넘어가기  -->
		   <a href="#"><img src="img/2.gif" ></a>
		   <!-- 페이징처리 -->
		   
		   <a href="#"><img src="img/3.gif"></a>
		   <!-- 다음 페이지 넘어가기 끝 -->
		   <img src="img/4.gif"><br><br>
    	</tr>
         	<tr class="cerfHeader">	        
		        <td class="cerfHeadTitle">신청번호</td>
	            <td class="cerfHeadTitle">신청자</td>
	            <td class="cerfHeadTitle">부서</td>
	            <td class="cerfHeadTitle">직급</td>
	            <td class="cerfHeadTitle">담당업무</td>
	            <td class="cerfHeadTitle">제출용도</td>
	            <td class="cerfHeadTitle">신청일</td>
	            <td class="cerfHeadTitle">신청상태</td>
	            <%if(employeeBean4.getEmp_dept().equals("인사부")){%>	               
	            <td class="cerfHeadTitle">처리</td>
	            <%}else{%>
	            <td class="cerfHeadTitle">보기</td>	
	            <%}%>
	            
	      	</tr>
	      	<%for(int i=0; i<clist.size();i++){
	      		certifiBean cbean = new certifiBean();
	      		cbean = clist.get(i);
	      	%>	
	      	<tr>
	      		<td><%=cbean.getCer_num() %></td>
	      		<td><%=cbean.getCer_name() %></td>
	      		<td><%=cbean.getCer_dept() %></td>
	      		<td><%=cbean.getCer_job() %></td>
	      		<td><%=cbean.getCer_task() %></td>
	      		<td><%=cbean.getCer_use() %></td>
	      		<td><%=cbean.getCer_date() %></td>
	      		<td><%=cbean.getCer_state() %></td>
	      		<%if(employeeBean4.getEmp_dept().equals("인사부")){%>
	      		<td><select class="cerSelect" name="newstate" id="cerSelect<%=i+1%>">
	      		<option value="보류">보류</option>
	      		<option value="발급완료">발급완료</option>
	      		</select>
	      		<input type="button" value="변 경" class="newButton" onclick="updateState('<%= cbean.getCer_num()%>',<%=i+1%>)">
	      		</td>
	      		<%}else{
	      			if(cbean.getCer_state().equals("발급완료")){%>
	      				<td><a href="javascript:readCef(<%=cbean.getCer_num() %>)">보기</a></td>
	      		<%}else{%>
	      			<td>발급진행중..</td>
	      		<%}%>
	      		
	      		<%} %>
	      		
	      	</tr>
	      	<%} %>
	      	
         </table>
      </div>
        <form name="stateChange" method="post" action="certUpdateStateServlet">
    	<input type="hidden" name="cer_num" value="">
    	<input type="hidden" name="cer_state" value="">
    	</form>	
      <footer>
       <div class="footer" id="footer">
       	<input type = button value=" 신 규 " onclick="openApplyCef()" class="newButton"> 
       </div>
       </footer>
       <script>
       var newWindow;
       function openApplyCef(){
           newWindow = window.open("applyCertificate.jsp","신청","height=250px,width=650px, left=400px, top=200px");
       };
       function readCef(num){
    	   url = "readCertificate.jsp?cer_num="+num;
    	  	newWindow = window.open(url,"post","height=600px,width=800px"); 
       };
       </script>
       <script>
        function updateState(num, id){        	
        	var target = document.getElementById("cerSelect"+id);
        	var newState = target.options[target.selectedIndex].value;       	
        	document.stateChange.cer_num.value = num;
        	document.stateChange.cer_state.value = newState;
        	document.stateChange.submit();
        };
        </script>
	</body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>