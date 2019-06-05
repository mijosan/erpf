<%@page import="erp.EmployeeBean"%>
<%@page import="erp.SellBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<jsp:useBean id="SMgr" class="erp.SellMgr"/>

<%
	request.setCharacterEncoding("utf-8");

	EmployeeBean Ebean = (EmployeeBean)session.getAttribute("employeeBean");
	if(Ebean.getEmp_dept().equals("영업부") || Ebean.getEmp_job().equals("이사")) {
%>

<html>
	<head>
		<style>
			.IStbl th{
				border: 1px solid rgb(210,210,210);
				background: rgb(249,249,249);
				height: 50px;
			}
			
			.IStbl td{
				border: 1px solid rgb(210,210,210);
				text-align: center;
			}
			
			.insertSellText {
				border: 0px;
				text-align: center;
			}
			
			input[id=allcheck]{
                transform: scale(1.5);
			}
			input[class=insertCheckbox] {
			                transform: scale(1.5);
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
				
				var fp = document.sellFrm;
				for(var i = 0; i < 5; i++) {
					if(fp.p_quantity[i].value=="" && fp.p_price[i].value=="") {
						fp.p_quantity[i].value=0;
						fp.p_price[i].value=0;
					}//---if
				}//---for
				
				fp.submit();
			}//---tableCheck()
			
			function keyNumber1(event) { //---수량, 가격에는 숫자만 입력 가능
				
				event = event || window.event;
				var keyID = (event.which) ? event.which : event.keyCode;
				if((keyID >= 48 && keyID <= 57) || (keyID >=96 && keyID <= 105) || keyID == 8 || keyID == 9 || keyID == 46) {
					
				}else {
					alert("숫자만 입력가능 합니다.");
				} //---else
			} //---function
			
			
			
			
		</script>
		
		<script>
		/* function comma(value1,i) { //---콤마 찍기
			var number = value1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			document.getElementsByName("p_price")[i].value = number;
		} */
		</script>
	</head>
	
	<body>
	
	<div class="full" align="center">
		<form name="sellFrm" method="post" action="insertSellProc.jsp" autocomplete="off">
			<div style="margin-top: 30px;"> <!--별, 생산등록 div1-->
	                <table style="border-bottom: 1px solid rgb(210,210,210);">
	                    <tr>
	                        <td style="width: 100px; text-align: center;"><img src="img/star.png"></td>
	                        <td style="width: 1000px;">판매 등록</td>
	                        <td style="width: 50px;">
	                        <input type="button" onclick="tableCheck()" value="완 료" style="background: rgb(46,117,182); color: white; font-weight: 500; border: 0px; width: 50px; height: 25px;">
	                        </td>
	                    </tr>
	                </table>
	            </div> <!--별, 생산등록 div1-->
		
			<div style="margin-top: 30px;">
					<table style="border-collapse: collapse" class="IStbl">
					
						<tr>
							<th style="width: 90px; height: 40px;">판매번호</th>
							<th style="width: 130px;">거래처</th>
							<th style="width: 90px;">품번</th>
							<th style="width: 130px;">품목</th>
							<th style="width: 80px;">수량</th>
							<th style="width: 80px;">단가</th>
							<th style="width: 130px;">판매일</th>
							<th style="width: 110px;">담당자</th>
						</tr>
		<%
			for(int i = 0; i < 5; i++) {
				 int maxNum = SMgr.getMaxNum();
		%>
						<tr>
							<td><input type="text" class="insertSellText" name="s_num" style="width: 90px; height: 40px;" value=<%=maxNum+i%> readonly>
							</td>
							<td><input type="text" class="insertSellText" name="s_customer" style="width: 130px; height: 40px;">
							</td>
							<td>
								<select size="1" name="p_num" style="border: 0px; width:90px; heigth:40px;">
<%
							Vector<SellBean> vlist1 = SMgr.getList3();
							for(int j = 0; j < vlist1.size(); j++) {
								SellBean Sbean = vlist1.get(j);
%>
								<option value=<%=Sbean.getP_num() %>><%=Sbean.getP_num()%></option>
<%
	}
%>							
								</select>
							</td>
							
							<td>
								<select size="1" name="p_name" style="border: 0px; width:130px; height: 40px; text-align: center;">
<%
							Vector<SellBean> vlist2 = SMgr.getList3();
							for(int j = 0; j < vlist2.size(); j++) {
								SellBean Sbean = vlist2.get(j);
%>
									<option value=<%=Sbean.getP_name()%>><%=Sbean.getP_name()%></option>
<%									
								}
%>
								</select>
							</td>
							
							<td><input type="text" class="insertSellText" name="p_quantity" style="width: 80px; height: 40px;" onkeydown="keyNumber1()">
							</td>
							<td><input type="text" class="insertSellText" name="p_price" style="width: 80px; height: 40px;" onkeydown="keyNumber1()">
							</td>
							<td><input type="text" class="insertSellText" name="s_date" style="width: 130px; height: 40px;">
							</td>
							<!-- <td><input type="text" class="insertSellText" name="s_staff" style="width: 110px; height: 40px;">
							</td> -->
							<td>
								<select size="1" name="s_staff" style="border: 0px; width:110px; height: 40px; text-align: center;">
<%
							Vector<EmployeeBean> vlist3 =  SMgr.getStaff();
							for(int j = 0; j < vlist3.size(); j++) {
								EmployeeBean E2bean = vlist3.get(j);
%>
							<option value="<%=E2bean.getEmp_name()%>"><%=E2bean.getEmp_name() %></option>
<%								
							}
%>									
								</select>
							</td>
							
						</tr>
		<%
				}
		%>
					</table>
				</div>
			</form>
		</div> <!-- full div-->
		<div style="color: red; margin-left: 170px; text-align: left;">* 수량, 단가 칸에는 숫자만 입력 가능 합니다.</div>
	</body>
</html>

<%}else { %>
<script>
self.close();
alert("판매 제품 등록에 대한 접근 권한이 없습니다.");
</script>
<%} %>
