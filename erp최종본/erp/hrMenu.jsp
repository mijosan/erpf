<%@page import="erp.EmployeeBean"%>
<%@page import="erp.EmployeeMgr"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% 	request.setCharacterEncoding("utf-8");%>
<%	////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
///////////////////////////////////////////// 
EmployeeMgr mgr = new EmployeeMgr();
	  int totalRecord = mgr.getTotalCount();
	  int numPerPage = 15;
	  int totalpage = (int)Math.ceil((double)totalRecord/numPerPage);
	  int nowPage = 1;
	  int start=1; //디비의 select 시작번호
      int end=numPerPage; //시작번호로 부터 가져올 select 갯수
	  if(request.getParameter("nowPage")!=null){	//다른 페이지로 넘어갈때 nowPage값을 넘겨줌. null이 아니면 해당 값을 받아옴.
    	  nowPage = Integer.parseInt(request.getParameter("nowPage"));
    	  start = (nowPage * numPerPage)-numPerPage +1;  //ex)2페이지면 16번부터 30번까지.나와야 하므로 (2*15)-15 = 15 -> 15다음부터 나오면 됨.
      }
	  end = nowPage * numPerPage;
	  Vector<EmployeeBean> vlist = mgr.getAllEmployee(start, end);  
%>
<%@ include file="top.jsp" %>
<%@ include file="menu.jsp" %>		
<html>
    <head>
        <meta charset="utf-8">
        <style>
            * {
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .tblutf-8{            	
            	border-top : 1px solid #dee3eb;
            	border-bottom: 1px solid #dee3eb;
            	padding-top: 5px;
            	padding-bottom : 7px;
            }            
            .see { 
                width: 1100px; /* 
                margin-left: 10px;
                margin-top: 10px; */
                margin : 0 auto;
            }
            .t1{
            	border-collapse: collapse;    
	        }
	        .t2{
	            background-color: #D5D5D5;
	            text-align: center;
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
	        .hrtable{
	        	border : 1px solid #dee3eb;
	        }	        	        
	        a{
	        	text-decoration:none;
	        	color:black;
	        }
	        a:visited{
	        	color:black;
	        }
	        footer{
	        	margin:0 auto;
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
			.tblutf-8 img{
				width:10px;
				height:10px;
			}
        </style>
    </head>
    <body>

        <div class="see" id="see">
            <div class="noneutf-8">
                <div class="H1"></div>
                <div class="H2"></div>
            </div>
            <br/>
          
         <div class="tblutf-8"><img src="img/star.png"><b> &nbsp;인사정보조회</b><br/></div>
        
  		<table border="1" width="1100px" class="t1" class="hrtable">	    
	    <tr>
	       <img src="img/1.gif" >
	       <!-- 이전 페이지 넘어가기  -->
		   <a href="javascript:pageing('<%=nowPage-1%>')"><img src="img/2.gif" ></a>	
		   <!-- 이전 페이지 넘어가기 끝 -->	   
		   <!-- 페이징 처리 -->
		   <%for(int i=1; i<=totalpage; i++){ %>
		   <a href="javascript:pageing('<%=i%>')">
		   <%if(i==nowPage){ %><font color="red"><%} %>
				[<%=i %>]
				<%if(i==nowPage){ %></font><%} %>	</a>
		   <% }%>
		   <!-- 페이징 처리 끝 -->
		   <!-- 다음 페이지 넘어가기  -->
		   <a href="javascript:pageing('<%=nowPage+1%>')"><img src="img/3.gif"></a>
		   <!-- 다음 페이지 넘어가기 끝 -->
		   <img src="img/4.gif"><br><br></tr>
	    
	        <tr class="t2" >	        
	        <td height="30"><input type=checkbox id=allCheck onClick='allCheck(this);'></td><td>사번<img src="img/icon_arrowBot.gif"></td><td>성명<img src="img/icon_arrowBot.gif"></td><td>생년월일</td><td>부서<img src="img/icon_arrowBot.gif"></td><td>직급<img src="img/icon_arrowBot.gif"></td><td>입사일자<img src="img/icon_arrowBot.gif"></td><td>계좌번호</td><td>EMAIL</td><td>수정</td>
	        </tr>
	        <%
	        	for(int i=0; i<vlist.size();i++){	        	
	        		 EmployeeBean bean = new EmployeeBean();
	        		 bean = vlist.get(i);	        		  
	        %>
	        	<tr onMouseover="this.style.backgroundColor='#D5D5D5'" onmouseout="this.style.backgroundColor=''" align="center">
	            <td><input type=checkbox name="rowCheck" value="<%=bean.getEmp_num() %>"></td><td><a href=""><%=bean.getEmp_num() %></a></td><td><a href="javascript:readHr('<%=bean.getEmp_num()%>')"><%=bean.getEmp_name() %></a></td>
	            <td><%=bean.getEmp_birth() %></td><td><%=bean.getEmp_dept() %>  </td><td><%=bean.getEmp_job() %></td><td><%=bean.getEmp_hireDate().substring(0,10) %></td>
	            <td><%=bean.getEmp_bank() +" "+ bean.getEmp_account() %>  </td><td><%=bean.getEmp_email() %>  </td><td><a href="javascript:updateHr('<%=bean.getEmp_num()%>')"><font color="blue">수정</font></a></td>
	       		</tr> 
	        <%}%>	       
	        </table>	        
	        <form name="readFrm"><!-- 페이징을 위한 폼 -->
			<input type="hidden" name="totalRecord" value="<%=totalRecord%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			</form>
        <br/>        	
 </div>
       <footer>
       <div class="footer" id="footer"><input type = button value=" 신 규 " onclick="openHrPlus()" class="newButton"> 
        <input type = button value="삭 제" class="newButton" onClick="deleteHr()">
        <form name="delform" method="post" action="deleteServlet"><input type="hidden" name="selectedBox"></form>   	
        </div>
        </footer>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>  
        var newWindow;
        function openHrPlus(){
            newWindow = window.open("hrPlus.jsp","인사등록","height=250px,width=650px, left=400px, top=200px");
        };
        function readHr(no){
        	url = "hrRead.jsp?emp_num=" + no;
        	newWindow = window.open(url,"post","height=200px,width=600px, left=400px, top=200px");
        };
        function updateHr(no){
        	url = "hrUpdate.jsp?emp_num=" + no;
        	newWindow = window.open(url,"post","height=350px,width=600px, left=400px, top=200px");
        }
        
        function allCheck(obj){
        	var chkObj = document.getElementsByName('rowCheck'); //getElementsByName
        	var rowcnt = chkObj.length -1;
        	var check = obj.checked;        	
        	if(check){
        		for(var i=0; i<=rowcnt; i++){
        			if(chkObj[i].type=="checkbox"){
        				chkObj[i].checked = true;
        			}
        		}
        	}else{
        			for(var i=0; i<=rowcnt; i++){
        				if(chkObj[i].type=="checkbox"){
        					chkObj[i].checked = false;
        				}
        			}
        		}
        	}
         function deleteHr(){
        	 var chkObj = document.getElementsByName('rowCheck');
        	 var rowcnt = chkObj.length -1;
        	 var selected = "";
        	 var idxid = false;
        	 var cnt = 0;
        	 for(var i=0; i<=rowcnt; i++){
        		 if(chkObj[i].checked){
        			 if(idxid){
            			 selected = selected + "-";
            		 }
        			 selected = selected + chkObj[i].value;
        			 cnt++;
        			 idxid = true;
        		 }
        	 }
        	 document.delform.selectedBox.value = selected;
        	 
        	 var agree = confirm(cnt+"개의 정보를 삭제하시겠습니까 ?");
        		if(agree){
        			document.delform.submit();
        		}         
        	}
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
    	 	
    	} 
        </script>
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>