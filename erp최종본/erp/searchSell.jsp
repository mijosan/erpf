<%@page import="erp.SellBean"%>
<%@page import="java.util.Vector"%>
<%@page import="erp.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<jsp:useBean id="SMgr" class="erp.SellMgr"/>
<%
				request.setCharacterEncoding("utf-8");
				int totalRecord = 0;
				int numPerPage = 10; // 페이지당 레코드 수
				int pagePerBlock = 10; //블럭당 페이지수
				int totalPage = 0; //전체 페이지 수
				int totalBlock = 0; //전체 블럭수
				int nowPage = 1; // 현재페이지
				int nowBlock = 1; //현재블럭

				int start = 0; //디비의 select 시작번호
				int end = numPerPage; //시작번호로 부터 가져올 select 갯수

				String keyField = "", keyWord = ""; //검색할 때 사용
				
				if(request.getParameter("keyWord")!=null){
					
					keyField = request.getParameter("keyField");
					keyWord = request.getParameter("keyWord");
				}
				
				if(request.getParameter("nowPage")!=null){
					nowPage = UtilMgr.getInt(request,"nowPage");
				}

				start = (nowPage * numPerPage) - numPerPage;
				totalRecord = SMgr.getTotalCount(keyField, keyWord);

				totalPage = UtilMgr.ceil(totalRecord, numPerPage);
				totalBlock = UtilMgr.ceil(totalPage, pagePerBlock);
				nowBlock = UtilMgr.ceil(nowPage, pagePerBlock);
			%>



<%@ include file="top.jsp" %>
<%@ include file="menu.jsp" %>
<html>
<head>
<style>
.full { /*전체 div 감싸기*/
	width: 1000px;
	margin: auto;
	height: 100%;
}

.searchSelltbl th{ /*테이블 제일 윗칸*/
	border: 1px solid rgb(210, 210, 210);
	background: rgb(249, 249, 249);
	height: 50px;
}

.searchSelltbl td{
	border: 1px solid rgb(210, 210, 210);
	text-align: center;
	height: 50px;
}

.Shref {
	color: black;
	text-decoration: none;
}

.ssBtn {
	border: 0px;
	background: rgb(46,117,182);
	color: white;
	height: 30px;
}

input[id=allcheck1]{
                transform: scale(1.5);
}
input[class=sellcheckbox] {
                transform: scale(1.5);
}
</style>


<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="script.js"></script>
<script>
	$(document).ready(function() {
		
		 $("#allcheck1").click(function(){   //체크박스 전체 체크 하기
			$(".sellcheckbox").prop("checked",this.checked);
		}); //---click 
		
		
	}); //---ready
	
	
	 function pageing(page) {
		if(page <= 0) {
			page = 1;
		}
		if(page><%=totalPage%>) {
			page=<%=totalPage%>
		}
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}

	function block(blockvalue){
		if(blockvalue <= 0) {
			blockvalue = 1;
		}
		if(blockvalue > <%=totalBlock%>) {
			blockvalue = <%=totalBlock%>
		}
		
	 	document.readFrm.nowPage.value=<%=pagePerBlock%>*(blockvalue-1)+1;
	 	document.readFrm.submit();
	}
	
	function check() { //---검색창 text
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
			document.searchFrm.submit();
	}
	
	function add1() { //---추가 버튼
		var frmX = (window.screen.width/2) - (1200 / 2);
	   	var frmY = (window.screen.height/2) - (500 / 2);
   	window.open("insertSell.jsp","_blank","width=1200, height=500, left="+ frmX +", top="+ frmY); 
	}
	
	function delete1() {  //---선택 삭제
		var checkb = document.getElementsByClassName("sellcheckbox");
		document.sellFrm.action="deleteSearchSell.jsp";
		document.sellFrm.submit();
	}
	
	function read(s_num) { //---sellRead.jsp로 s_num 값 넘기기
		 var frmX = (window.screen.width/2) - (1000 / 2);
    	 var frmY = (window.screen.height/2) - (300 / 2);
    	 var url = "sellRead.jsp?s_num="+s_num;
    	window.open(url,"_blank","width=1000, height=300, left="+ frmX +", top="+ frmY);
	}
	
</script>
</head>

<body>

	<div class="full">
		<form name="searchFrm" autocomplete="off">
			<div>
				<!--별, 판매조회 div1-->
				<br>
				<table style="border-bottom: 1px solid rgb(210, 210, 210); border-top: 1px solid rgb(210, 210, 210);">
					<tr>
					
						<td style="width: 100px; text-align: center;">
						<img src="img/star2.png"></td>
						<td style="width: 600px;"><a href="searchSell.jsp" class="Shref">판매 조회</a></td>
						<td><input type="text" name="keyWord" width="150px; height:30px;"></td>
						<td style="width: 50px;">
						<input type="submit" value="검  색" onclick ="javascript:check()" style="background: rgb(46, 117, 182); color: white; font-weight: 500; border: 0px; width: 50px; height: 25px;">
						<input type="hidden" name="nowPage" value="1">
						</td>
						<td style="width: 100px;">
							<select size="1" name="keyField" style="width: 80px; height: 25px;">
									<option value="s_num">판매번호</option>
									<option value="p_name">품 목</option>
									<option value="s_date">판매일</option>
									<option value="s_customer">거래처</option>
							</select></td>
							
					</tr>
				</table>
			</div>
		</form>
		
		<!--별, 판매조회 div1-->


		<!--판매조회 테이블 시작-->
			<%
				Vector<SellBean> vlist = SMgr.getList(keyField, keyWord, start, end);
					int listSize = vlist.size();
					if (vlist.isEmpty()) {
						out.println("등록된 판매 정보가 없습니다.");
					} else {
			%>
	<form name=sellFrm method="post">
		<div style="margin-left: 50px; margin-top: 30px;">
			<table style="border-collapse: collapse;" class="searchSelltbl">
				<tr>
					<th style="width: 40px;"><input type="checkbox" id="allcheck1"></th>
					<th style="width: 100px;">판매번호</th>
					<th style="width: 150px;">거래처</th>
					<th style="width: 200px;">품&emsp;목</th>
					<th style="width: 60px;">수량</th>
					<th style="width: 200px;">판매일</th>
					<th style="width: 100px;">담당자</th>
				</tr>
			<%
				for(int i = 0; i < numPerPage; i++) {
						if(listSize == i) break;					
						SellBean bean = vlist.get(i);
						int s_num = bean.getS_num();
						String s_customer = bean.getS_customer();
						String p_num = bean.getP_num();
						String p_name = bean.getP_name();
						int p_quantity = bean.getP_quantity();
						int p_price = bean.getP_price();
						String s_date = bean.getS_date();
						String s_staff = bean.getS_staff();
			%>
			<tr>
					<td style="width: 40px;" class="tabletd1">
					<input type="checkbox" class="sellcheckbox" value=<%=s_num %> name="checkbox">
					</td>
					<td class="tabletd1">
					<a href="javascript:read('<%=s_num%>')" style="color: rgb(46,117,182)" class="Shref"><%=s_num %></a>
					</td>
					<td class="tabletd1"><%=s_customer %></td>
					<td class="tabletd1"><%=p_name %></td>
					<td class="tabletd1"><%=p_quantity %></td>					
					<td class="tabletd1"><%=s_date %></td>
					<td class="tabletd1"><%=s_staff %></td>
			<%
				}//---for
			%>
					</tr>
				</table>
			</div>
	</form>
					<%
						} //---else
					%>
		<!--판매조회 테이블 끝-->
		
		
		<div style="text-align: center; margin-top: 20px;">
		<%
			if(totalPage!=0){%>
				<!-- 이전 블럭 -->
				<a href="javascript:block('<%=nowBlock-1%>')" class="Shref"><img src="img/1.gif"></a>					
				
				<!-- 이전 페이지 -->
				<a href="javascript:pageing('<%=nowPage-1%>')" class="Shref"><img src="img/2.gif"></a>
					
				<%
				//페이징
					int pageStart = (nowBlock-1)*pagePerBlock+1;
					int pageEnd = (pageStart+pagePerBlock) <= totalPage? (pageStart+pagePerBlock):totalPage+1;
					for(;pageStart<pageEnd;pageStart++){
				%>
				<a href="javascript:pageing('<%=pageStart%>')" class="Shref">
				<%if(pageStart==nowPage){%><font color="red"><%} %>
				[<%=pageStart%>]
				<%if(pageStart==nowPage){ %></font><%} %>	</a>
				<%
					}//for
%>
				 <!-- 다음 페이지 -->
				 <a href="javascript:pageing('<%=nowPage+1%>')" class="Shref"><img src="img/3.gif"></a>
				
				<!-- 다음 블럭 -->
				<a href="javascript:block('<%=nowBlock+1%>')" class="Shref"><img src="img/4.gif"></a>
					
			<%}//---if1%>
		</div>
		
		<hr>
		<input type="button" value="등   록" onclick="add1()" class="ssBtn" style="width: 50px;">
		<input type="button" value="선택 삭제" onclick="delete1()" class="ssBtn" style="width: 70px;">
		
		<form name="readFrm">
			<input type="hidden" name="s_num">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
		
	</div>
	<!--full div-->

</body>
</html>
