<%@page import="erp.EmployeeBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<jsp:useBean id="PMgr" class="erp.ProductMgr"/>
<%
	request.setCharacterEncoding("utf-8");
	EmployeeBean Ebean = (EmployeeBean)session.getAttribute("employeeBean");
	if(Ebean.getEmp_dept().equals("생산부") || Ebean.getEmp_job().equals("이사")) {
%>

<html>
	<head>
		<style>
			.IPtbl th{
				border: 1px solid rgb(210,210,210);
				background: rgb(249,249,249);
				height: 50px;
			}
			
			.IPtbl td{
				border: 1px solid rgb(210,210,210);
				text-align: center;
			}
			
			.insertProductText {
				border: 0px;
				text-align: center;
			}
			
			input[id=allcheck]{
                transform: scale(1.5);
			}
			input[class=insertCheckbox] {
			                transform: scale(1.5);
			}
			
			input::placeholder {
			  color: red;
			  text-align: center;
			}
		</style>
		
		
		
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script>
		
			$(document).ready(function() {
				 $("#allcheck").click(function(){   //체크박스 전체 체크 하기
					$(".insertCheckbox").prop("checked",this.checked);
				}); //---click 
				
			}); //---ready()
			
			function tableCheck() {
				
				var fp = document.productionFrm;				
				for(var i = 0; i < 5; i++) {
					if(fp.p_num[i].value=="" && fp.p_quantity[i].value=="" && fp.p_price[i].value=="") {
						fp.p_num[i].value='0';
						fp.p_quantity[i].value=0;
						fp.p_price[i].value=0;
					}//---if
				}//---for
				
				fp.submit();
			}//---tableCheck()
			
			function keyNumber1(event) { //---제품번호, 수량, 가격에는 숫자만 입력 가능
				
				event = event || window.event;
				var keyID = (event.which) ? event.which : event.keyCode;
				if((keyID >= 48 && keyID <= 57) || (keyID >=96 && keyID <= 105) || keyID == 8 || keyID == 9 || keyID == 46) {
					
				}else {
					alert("숫자만 입력가능 합니다.");
				} //---else
			} //---function
			
		</script>
	</head>
	
	<body>
	
	<div class="full" align="center">
		<form name="productionFrm" method="post" action="insertProductProc.jsp" autocomplete="off">
			<div style="margin-top: 30px;"> <!--별, 생산등록 div1-->
	                <table style="border-bottom: 1px solid rgb(210,210,210);">
	                    <tr>
	                        <td style="width: 100px; text-align: center;"><img src="img/star.png"></td>
	                        <td style="width: 800px;">생산 등록</td>
	                        <td style="width: 50px;">
	                        <input type="button" onclick="tableCheck()" value="완 료" style="background: rgb(46,117,182); color: white; font-weight: 500; border: 0px; width: 50px; height: 25px;">
	                        </td>
	                    </tr>
	                </table>
	            </div> <!--별, 생산등록 div1-->
		
			<div style="margin-top: 30px;">
					<table style="border-collapse: collapse" class="IPtbl">
					
						<tr>
							<th style="width: 100px;";>생산 번호</th>
							<th style="width: 100px;">제품 번호</th>
							<th style="width: 200px;">제 품</th>
							<th style="width: 60px;">수량</th>
							<th style="width: 100px;">가격</th>
							<th style="width: 200px;">생산 공장</th>
							<th style="width: 150px;">생산일</th>
						</tr>
		<%
				for(int i = 0; i < 5; i++) {
					int maxNum = PMgr.getMaxNum();
					String[] num = {"fa-125", "tp-35", "tk-218", "pr-87", "ax-93"};
					String[] name = {"키보드","마우스","모니터","충전기","본체"};
					int[] quantity = {500,300,400,1000,500};
					int[] price = {35000, 45000, 300000, 10000, 750000};
					String[] container = {"부산","대구","광주","인천","서울"};
					String[] date = {"2019.01.01","2019.01.02","2019.01.03","2019.01.04","2019.01.05"};
		%>
				<tr>
							<td><input type="text" style="width: 100px; height: 40px;" class="insertProductText" name="add_num" value=<%=maxNum+i%> readonly>
							</td>
							<td><input type="text" style="width: 100px; height: 40px;" class="insertProductText" name="p_num">
							</td>
							<td><input type="text" style="width: 200px; height: 40px;" class="insertProductText" name="p_name">
							</td>
							<td><input type="text" style="width: 60px; height: 40px;" class="insertProductText" name="p_quantity" onkeydown="keyNumber1(event)">
							</td>
							<td><input type="text" style="width: 100px; height: 40px;" class="insertProductText" name="p_price" onkeydown="keyNumber1(event)">
							</td>
							<td><input type="text" style="width: 200px; height: 40px;" class="insertProductText" name="p_container">
							</td>
							<td><input type="text" style="width: 150px; height: 40px;" class="insertProductText" name="p_date">
							</td>
						</tr>
		<%
				}
		%>
					</table>
				</div>
			</form>
		</div> <!-- full div-->
		<div style="color: red; margin-left: 130px;">* 수량, 가격 칸에는 숫자만 입력 가능 합니다.</div>
	</body>
</html>

<%}else { %>
<script>
self.close();
alert("생산 제품 등록에 대한 권한이 없습니다.");
</script>
<%} %>
