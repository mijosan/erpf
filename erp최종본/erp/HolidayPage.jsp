<%@page import="erp.AnonyBoardMgr"%>
<%@page import="erp.UtilMgr2"%>
<%@page import="erp.HolidayBean"%>
<%@page import="erp.HolidayMgr"%>
<%@page import="erp.EmployeeBean"%>

<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	EmployeeBean employeeBean = (EmployeeBean)session.getAttribute("employeeBean");
	HolidayMgr holiMgr = new HolidayMgr();
	Vector<HolidayBean> vlist = null;
	
	
	/////////////////////////////////////////////페이징
	int totalRecord = 0;//총 레코드 수
		int numPerPage = 15; // 페이지당 레코드 수 
		int pagePerBlock = 10;  //블럭당 페이지수 
		int totalPage = 0; //전체 페이지 수
		int totalBlock = 0;  //전체 블럭수 
		int nowPage = 1; // 현재페이지
		int nowBlock = 1;  //현재블럭
		
		int start = 0;
		int end = numPerPage;

	
	//검색
	String holi_content = "";
	String holi_state = "";
	
	if(request.getParameter("holi_content")!=null){
		holi_content = request.getParameter("holi_content");
	}
	if(request.getParameter("holi_state")!=null){
		holi_state = request.getParameter("holi_state");
	}
	
	if(request.getParameter("nowPage")!=null){
		nowPage = UtilMgr2.getInt(request,"nowPage");
	}
	////////////////////////////////////////////////

	start = (nowPage*numPerPage)-numPerPage;//(1*15)-15 = 0번째 게시물 부터 시작

	
	if(employeeBean.getEmp_job().equals("이사")){	

		vlist = holiMgr.getAllHoliday1(start, end, holi_content, holi_state);
		
		totalRecord = holiMgr.getTotalCount(holi_content,holi_state);
		totalPage = UtilMgr2.ceil(totalRecord,numPerPage);
		totalBlock = UtilMgr2.ceil(totalPage,pagePerBlock);
		nowBlock = UtilMgr2.ceil(nowPage,pagePerBlock);
	}else{
		vlist = holiMgr.getAllHoliday2(start, end, holi_content, holi_state, employeeBean.getEmp_dept());
		totalRecord = holiMgr.getTotalCount2(holi_content,holi_state,employeeBean.getEmp_dept());
		totalPage = UtilMgr2.ceil(totalRecord,numPerPage);
		totalBlock = UtilMgr2.ceil(totalPage,pagePerBlock);
		nowBlock = UtilMgr2.ceil(nowPage,pagePerBlock);
	}
%>
<%@ include file="top.jsp" %>
<%@ include file="menu.jsp" %>	
<html>
    <head>
       <style>
       	  .holiday-case{
       	  	  width: 1100px;
              margin : 0 auto;
       	  }
           .holidayHeader{
               background-color: #D5D5D5;
	           text-align: center;
           }
           .holidayHeader td{
               width: 120px;
           }
           .holidaytbl{
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
	        	display: inline;
	        }
	        .holiday_tbl_header{            	
            	border-top : 1px solid #dee3eb;
            	border-bottom: 1px solid #dee3eb;
            	padding-top: 5px;
            	padding-bottom : 7px;
            	display:inline-block;
            }
            .holiday_tbl_header img{
            	width:10px;
            	heigh:10px;
            }
            .holiday_footer {
			    position:fixed;			
			    bottom:0;
			    width:1100px;		
			    height:50px;
			    border-top: 3px solid #dee3eb;
			    margin:auto;
			    left:50%; 
			    transform:translateX(-50%);
				display:inline;
			}
			.pgDiv{
				margin-left:400px;
			}
			.fontId{
				color:rgb(46,117,182);
			}
			#searchDiv{
				margin-left:768px;
			}
			#searchFo{
				float:left;
			}
			#searchFo1{
				float:left;
			}
			table.holidaytbl tr:hover {
                background-color: rgb(225,225,225);
            }
				a:link {text-decoration: none; color: black;}
				a:visited {text-decoration: none; color: rgb(46,117,182);}
				a:active {text-decoration: none; color: rgb(46,117,182);}
				a:hover {text-decoration: none; color: rgb(46,117,182);}
		
        </style>
        <script type="text/javascript">
        
		//////////////////페이징
		function pageing(page) { //페이지를 이동시 실행
			document.readFrm.nowPage.value = page;
			document.readFrm.submit();
		}
	
		function block(value){ //블럭을 이동시 실행(현재 2블럭이면 value값으로 1이옴)
		 	document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;//nowPage==15*(2-1)+1=16 -->현재 페이지를 16페이지로 해야 2블럭이 됨으로
		 	document.readFrm.submit();
		}
		
		//////////////////페이징
		
		 function openHolidayPlus(){
	            newWindow = window.open("HolidayPlus.jsp","근태등록","height=140px,width=620px, left=400px, top=200px");
	        };
	        
	        
	        

	        function payfunction(i){
	        	var form = document.createElement("form");

	            form.setAttribute("charset", "UTF-8");

	            form.setAttribute("method", "get");  //Post 방식
				
	            form.setAttribute("action", "payfunctionProc.jsp"); //요청 보낼 주소



	            var hiddenField = document.createElement("input");

	           

	            hiddenField.setAttribute("type", "hidden");
	            hiddenField.setAttribute("name", "holi_idx");
	            hiddenField.setAttribute("value", i);


	            form.appendChild(hiddenField);


	            document.body.appendChild(form);

	            form.submit();
	        };
	
	
</script>
    </head>
    <body>
	<div class="holiday-case">
	  <div class="noneheader">
                <div class="H1"></div>
                <div class="H2"></div>
            </div>
            <br/>
	<div class="holiday_tbl_header"><img src="img/star.png"><b> &nbsp;근태 입력/조회</b><br/>
	
	<div id="searchDiv">
	<form method="GET">
		<select name="holi_content">
	             <option value="">근태항목</option>
	             <option value="출근">출근</option>
	             <option value="퇴근">퇴근</option>
				 <option value="경조사">경조사</option>
				 <option value="예비군">예비군</option>
				 <option value="결혼">결혼</option>
				 <option value="휴가">휴가</option>
				 <option value="조퇴">조퇴</option>
				 <option value="기타">기타</option>
		</select>
	<select name="holi_state">
             <option value="">결제상황</option>
			 <option value="승인">승인</option>
			 <option value="미승인">미승인</option>
	</select>
	<input type="submit" class="newButton" value="검색">
	</form>
	</div>
	</div>
	<br>
    <table border="1" class="holidaytbl">
	
         <tr class="holidayHeader" >	        
	        <td>근태번호</td>
            <td>날짜</td>
            <td>사번</td>
            <td>부서</td>
            <td>이름</td>
            <td>근태항목</td>
            <td>결제상황</td>
            <%if(employeeBean.getEmp_job().equals("부장") ||  employeeBean.getEmp_job().equals("이사")){%>
            <td>결제여부</td>
            <%}%>
	      </tr>
			
			<%for(int i=0;i<vlist.size();i++){ 
				HolidayBean bean = vlist.get(i);
				int listSize = vlist.size();
				if(listSize==i) break;
			%>
        	<tr>
            <td><%=bean.getHoli_idx() %></td><!--월+사번-->
            <td><%=bean.getHoli_date() %></td>
            <td><%=bean.getEmp_num() %></td>
            <td><%=bean.getEmp_dept() %></td>
            <td><%=bean.getEmp_name() %></td>
            <td><%=bean.getHoli_content() %></td>
            <td><%=bean.getHoli_state() %></td>
            <%
            int hol = bean.getHoli_idx();
            if(employeeBean.getEmp_job().equals("부장") ||  employeeBean.getEmp_job().equals("이사")){%>
            <td>
            
            
            <input type="button" class="newButton" value="결제" onclick=
            "window.open('payfunctionProc2.jsp?holi_idx=<%=hol%>','hiddenframe1','toolbar=no,status=no,menubar=no,scrollbars=no,resizable=no,left=10000, top=10000, width=10, height=10, visible=none')">
            	<iframe width=0 height=0 name="hiddenframe1" style="display:none;"></iframe>
            </td><%}%>
			 </tr>
			 <%}%>
 
    </table>
     <!--페이징-->
		<div class="pgDiv">
			 <%
							if(totalPage!=0){ 
								//이전블럭
								if(nowBlock>1){ %>
									<a href="javascript:block('<%=nowBlock-1%>')"><img src="img/1.gif"></a>
								&nbsp;<%}%> 
				
								<%
								//페이징
								int pageStart = (nowBlock-1)*pagePerBlock+1;//(현재블럭-1)*10+1 -->현재 2블럭이면 11번 페이지부터 시작
								int pageEnd = (pageStart+pagePerBlock)<=totalPage?(pageStart+pagePerBlock):totalPage+1; //11+10 <= 11 ? 11+10 : 12
						
								for(;pageStart<pageEnd;pageStart++){
								%>

									<a id="alink1" href="javascript:pageing('<%=pageStart%>')">
									
									<%if(pageStart==nowPage){ %>
									<span class="fontId"><%} %>
									[<%=pageStart %>]
									<%if(pageStart==nowPage) {%></span><%}%></a>
									<%
								}//for
							
								//다음블럭
								if(totalBlock>nowBlock){%>
									<a href="javascript:block('<%=nowBlock+1%>')"><img src="img/4.gif">
								&nbsp;</a><%}
							}//---if1 (totalPage!=0)
						%>
						</div>
    </div>
        <footer>
            <div class="holiday_footer" id="footer">
            <div id="searchFo1">
            <input type = button value=" 신 규 " onclick="openHolidayPlus()" class="newButton"> 
            </div>
            <div id="searchFo">
            <form action="HolidaySearch.jsp">
             	<input type="hidden" name="nowPage" value="1">
             	<input type="submit" class="newButton" value="리스트">
            </form>
            </div>
            </div>
        </footer>
        <form name="readFrm" method="get">
				<input type="hidden" name="num">
				<input type="hidden" name="nowPage" value="<%=nowPage%>">
				<input type="hidden" name="holi_content" value="<%=holi_content%>"> 
				<input type="hidden" name="holi_state" value="<%=holi_state%>">
		</form>
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>