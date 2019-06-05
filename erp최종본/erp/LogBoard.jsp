<%@page import="erp.EmployeeBean"%>
<%@page import="erp.LogBean"%>
<%@page import="java.util.Vector"%>
<%@page import="erp.LogMgr"%>
<%@page import="erp.UtilMgr2"%>
<jsp:useBean id="mgr" class="erp.LogMgr"/>

<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
	String ida = String.valueOf(session.getAttribute("idKey")); //세션에서 id를 받아옴
	EmployeeBean employeeBean = (EmployeeBean)session.getAttribute("employeeBean");
	if(!ida.equals("null")){
			if(employeeBean.getEmp_job().equals("이사")){
		int totalRecord = 0;//총 레코드 수
		int numPerPage = 15; // 페이지당 레코드 수 
		int pagePerBlock = 10;  //블럭당 페이지수 
		int totalPage = 0; //전체 페이지 수
		int totalBlock = 0;  //전체 블럭수 
		int nowPage = 1; // 현재페이지
		int nowBlock = 1;  //현재블럭
		
		int start = 0;
		int end = numPerPage;
		
		String keyField = "";
		String keyWord = "";
		
		//검색일때 keyField랑 KeyWord값을 넣어 리스트를 띄워줌(검색된 결과)
		if(request.getParameter("keyWord")!=null){
			keyField = request.getParameter("keyField");
			keyWord = request.getParameter("keyWord");
		}
		
		if(request.getParameter("nowPage")!=null){
			//nowPage = Integer.parseInt(request.getParameter("nowPage"));
			nowPage = UtilMgr2.getInt(request,"nowPage");
		}
		System.out.println(keyField);
		System.out.println(keyWord);
		
		 start = (nowPage*numPerPage)-numPerPage;//(1*15)-15 = 670번째 게시물 부터 시작
		 totalRecord = mgr.getTotalCount(keyField,keyWord); //keyField : 콤보박스 keyWord : 검색내용 , 검색한 결과의 총갯수를 정해야
		 													//                                         페이지 를 구성할수있다.
		 totalPage = UtilMgr2.ceil(totalRecord,numPerPage);
		 totalBlock = UtilMgr2.ceil(totalPage,pagePerBlock);
		 nowBlock = UtilMgr2.ceil(nowPage,pagePerBlock);
%>
<%@ include file="top.jsp"%>
<%@ include file="menu.jsp"%>
<html>
    <head>
        <meta charset="utf-8">

        <style>
            * {
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .see { 
                width: 1300px;
                margin-top: 10px;
            }
            .BOARD{
                top: 135px;
                width: 1400px;
                padding-top: 10px;
                float: left;
            }
            .tblBoard {
                margin-left: 50px;
                margin-top: 2px;
                width: 1325px;
                text-align: center;
                border-collapse: collapse;
                border-top: 2px solid rgb(200,220,220);
                border-bottom: 2px solid rgb(200,220,220);
                color: rgb(46,117,182);
            }
            table.tblBoard tr, table.tblBoard td {
                border: 1px solid rgb(220,220,220);
                padding: 3px;
            }
            table.tblBoard .tr_title {
                background-color: rgb(250,250,250);
                height: 40px;
            }
            
            .lol_name {
                font-size: 20px;
                font-weight: bold;
            }
            .search1 {
                width: 400px;
                display: inline-block;
                float: right;
                margin-left:500px;
            }
            .num {
                color: black;
            }
            .i_search {
                border: 1px solid rgb(210,220,220);
                margin-right: 10px;
                margin-left: 13px;
                width: 170px;
            }
            .btn {
                background-color: rgb(46,117,182);
                border: 1px solid rgb(46,117,182);
                color: white;
            }
            .paging {
                text-align: center;
                margin-left: 230px;
                border-spacing: 15px;
            }
            .p_btn {
                border: none;
            }
            .pa {
                border: 1px solid rgb(220,220,220);
                width: 20px;
                height: 20px;
            }
            .include, .include2 {
                position: absolute;
                top: 50px;
                width: 600px;
                height: 450px;
                border: 1px solid rgb(0,90,129);
                background-color: white;
            }
            .tool {
                background-color: rgb(46,117,182);           
                border-bottom: 1px solid rgb(0,90,129);
                height: 30px;
            }
            .incluePage {
                height: 420px;
            }
            .rmf {
                color: white;
                font-weight: bold;
                display: inline-block;
                float: left;
                margin-top: 8px;
                margin-left: 8px;
            }
            .close{
                display: inline-block;
                border-left: 1px solid rgb(0,90,135);
                width: 30px;
                height: 30px;
                background-position: center;
                background-repeat: no-repeat;
                background-image: url(img/clo.png);
                float: right;
            }
            #new {
                margin: 5px 500px 1px 50px;
            }
             #new1 {
                margin: 5px 0px 1px 1320px;
            }
            #aid{
            	text-decoration:none;
            	color:black;
            }
            .bb1{
            	color:rgb(46,117,182);
            }
            table.tblBoard tr:hover {
                background-color: rgb(225,225,225);
            }
            .tblheader2{            	
            	border-top : 1px solid #dee3eb;
            	border-bottom: 1px solid #dee3eb;
            	padding-top: 5px;
            	padding-bottom : 7px;
            	margin-left:50px;
            	width:1320px;
            }      
            #hrid{
            	margin-left:50px;
            }

        </style>
    </head>
    <body>

        <div class="see">
            <div class="BOARD">
            <div class="tblheader2"><img src="img/star2.png"><b> &nbsp;로그조회</b><br/></div>
                <div class="lol">
                    <form name="searchFrm" method="get">
                  	  <div class="search1">
                   	 <select name="keyField" size="1" >
                    			<option value="">선택하세요</option>
			    				<option value="log_content">구 분</option>
			    				<option value="emp_dept">부 서</option>
			    				<option value="emp_job">직 책</option>
			    				<option value="emp_name">이 름</option>
			    				<option value="emp_phone">연 락 처</option>
			   				</select>
                        <input type="text" class="i_search" name="keyWord">
                        <button class="btn" onClick="javascript:check()">Search</button>
                        <input type="hidden" name="nowPage" value="1">
                    </div>
                    </form>
                    
                </div>
                <br><br>
                <hr id="hrid" width="1325px">
                <div>
                    <button class="btn" id="new1" onclick="location.href='LogBoard.jsp'">리스트</button>
                </div>
                <table class="tblBoard">
                    <tr class="tr_title">
                        <td class="td_title" width="50">번호</td>
                        <td class="td_title" width="50">구분</td>
                        <td class="td_title" width="50">시간</td>
                        <td class="td_title" width="50">부서</td>
                        <td class="td_title" width="50">직책</td>
                        <td class="td_title" width="50">이름</td>
                        <td class="td_title" width="200">연락처</td>
                    </tr>
                    <%	Vector<LogBean> vlist = mgr.getBoardList(keyField, keyWord, start, end);
                    	int listSize = vlist.size();
                    	if(vlist.isEmpty()){
                    		
                    	}else{
                    	for(int i=0;i<numPerPage;i++){
                    		if(listSize==i) break;
                    		
                    		LogBean bean = vlist.get(i);
                    %>
                    <tr>
                    	<td><%=bean.getLog_idx() %></td>
                    	<%if(bean.getLog_content().equals("Out")){ %>
                    		<td><font color="red"><%=bean.getLog_content() %></font></td>
                    	<%}else{%>
                    		<td><font color="blue"><%=bean.getLog_content() %></font></td>
                    	<%}%>
                    						
                    	<td><%=bean.getLog_date() %></td>
                    	<td><%=bean.getEmp_dept()%></td>
                    	<td><%=bean.getEmp_job() %></td>
                    	<td><%=bean.getEmp_name() %></td>
                    	<td><%=bean.getEmp_phone() %></td>
                    </tr>
                    <%
                    	}}%>
                    <!-- 쿼리로 테이블 내용 추가함 -->
                </table>
                <table class="paging">
                    <tr>
                 	<td>
                 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 	</td>
                    <td>
                   
                        <%
							if(totalPage!=0){ 
								//이전블럭
								if(nowBlock>1){ %>
									<td class="p_btn"><a href="javascript:block('<%=nowBlock-1%>')"><img src="img/1.gif"></a></td>
								&nbsp;<%}%> 
				
								<%
								//페이징
								int pageStart = (nowBlock-1)*pagePerBlock+1;//(현재블럭-1)*15+1 -->현재 2블럭이면 16번 페이지부터 시작
								int pageEnd = (pageStart+pagePerBlock)<=totalPage?(pageStart+pagePerBlock):totalPage+1;
						
								for(;pageStart<pageEnd;pageStart++){
								%>
									<td class="pa"><a id="aid" href="javascript:pageing('<%=pageStart%>')">
									
									<%if(pageStart==nowPage){ %>
									<span class="bb1"><%} %>
									<%=pageStart %>
									<%if(pageStart==nowPage) {%></span><%}%></a></td>
									<%
								}//for
							
								//다음블럭
								if(totalBlock>nowBlock){%>
									<td class="p_btn"><a href="javascript:block('<%=nowBlock+1%>')"><img src="img/4.gif"></td>
								&nbsp;</a><%}
							}//---if1 (totalPage!=0)
						%>
						</td>
                    </tr>
                </table>
            </div>
        </div>
        <form name="readFrm" method="get"><!--게시물 읽고 돌아왔을때 그 페이지로 가도록-->
				<input type="hidden" name="num">
				<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
				<input type="hidden" name="keyField" value="<%=keyField%>"> 
				<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
		
        
        
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script>
            function pageing(page) { //페이지를 이동시 실행
        		document.readFrm.nowPage.value = page;
        		document.readFrm.submit();
        	}

        	function block(value){ //블럭을 이동시 실행(현재 2블럭이면 value값으로 1이옴)
        	 	document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
        	 	document.readFrm.submit();
        	}
        	
        	function read(num) { //글을 읽을때
        		document.readFrm.num.value=num;
        		document.readFrm.action = "read.jsp?<%=request.getQueryString()%>";
        		document.readFrm.submit();
        	}
        	
        	function check() {//검색 했을때
        		if(document.searchFrm.keyWord.value==""){
        			alert("검색어를 입력하세요.");
        			document.searchFrm.keyWord.focus();
        			return;
        		}
        		document.searchFrm.submit();
        	}
        	
        </script>
    </body>
</html>
<%}else{ %>
<script>
	history.back();
	alert("접근 권한이 없습니다");
</script>
<%} %>
<%}else{response.sendRedirect("erpLogin.jsp");}%>