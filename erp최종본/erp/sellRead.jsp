<%@page import="erp.EmployeeBean"%>
<%@page import="erp.SellBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<jsp:useBean id="UtilMgr" class="erp.UtilMgr"/>
<jsp:useBean id="mgr" class="erp.SellMgr"/>
<%
	request.setCharacterEncoding("utf-8");
	EmployeeBean Ebean = (EmployeeBean)session.getAttribute("employeeBean");
	if(Ebean.getEmp_dept().equals("영업부") || Ebean.getEmp_job().equals("이사")) {
		
	int s_num = UtilMgr.getInt(request, "s_num");
%>
<html>
	<head>
		<style>
			table th{
				border: 1px solid rgb(210,210,210);
				background: rgb(249,249,249);
				height: 40px;
			}
			
			.tblSellRead td{
				border: 1px solid rgb(210,210,210);
				text-align: center;
				height: 40px;
			}
			
			.SRprice {
				border: 0px;
				width: 100px;
				height: 40px;
				text-align: center;
			}
			
			.SRprice2 {
				border: 0px;
				width: 80px;
				height: 40px;
				background: rgb(249,249,249);
			}
		</style>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script>
		
		$(document).ready(function() {
			$("#SRprice1").change(function() {
                var pay1 = Number($("#SRquantity").val());
                var pay2 = Number($("#SRprice1").val());
                var sum = pay1*pay2;
                var vat = sum/10;
                $("#SRprice2").val(sum);
                $("#SRvat").val(vat);
                $("#SRsumprice1").val(sum+vat);
			});
			
			$("#SRquantity").change(function() {
                var pay1 = Number($("#SRquantity").val());
                var pay2 = Number($("#SRprice1").val());
                var sum = pay1*pay2;
                var vat = sum/10;
                $("#SRprice2").val(sum);
                $("#SRvat").val(vat);
                $("#SRsumprice1").val(sum+vat);
			});
			
		});
		
		</script>
	</head>
	
	<body>
	
			<div> <!--별, 생산등록 div1-->
                <table style="border-bottom: 1px solid rgb(210,210,210);">
                    <tr>
                        <td style="width: 100px; text-align: center;"><img src="img/star2.png"></td>
                        <td style="width: 800px;">판매 수정</td>
                    </tr>
                </table>
            </div> <!--별, 생산등록 div1-->
            
    <form action="sellReadProc.jsp" autocomplete="off">
		<div align="center" style="margin-top: 20px;">
			<table class="tblSellRead" style="border-collapse: collapse">
			
				<tr>
					<th style="width: 100px;">판매번호</th>
					<th style="width: 200px;">품목</th>
					<th style="width: 100px;">수량</th>
					<th style="width: 100px;">단가</th>
					<th style="width: 100px;">판매일</th>
					<th style="width: 100px;">담당자</th>
					
				</tr>
<%
	Vector<SellBean> vlist = mgr.getList2(s_num);
		for(int i = 0; i < vlist.size(); i++) {
			SellBean bean = vlist.get(i);
%>
		<tr>
			<td><input type="text" value="<%=bean.getS_num() %>" class="SRprice" name="s_num" readonly></td>
			<td><input type="text" value="<%=bean.getP_name() %>" class="SRprice" style="width: 200px;" name="p_name"></td>
			<td><input type="text" id="SRquantity" value="<%=bean.getP_quantity() %>" class="SRprice" name="p_quantity"></td>
			<td><input type="text" id="SRprice1" class="SRprice" name="p_price"></td>   <!-- 단가 -->
			<td><input type="text" value="<%=bean.getS_date()%>" class="SRprice" name="s_date"></td>
			<td><input type="text" value="<%=bean.getS_staff() %>" class="SRprice" name="s_staff"></td>
		</tr>
		<tr>
			<td colspan="3" style="border: 0px;"></td>
			<th style="width: 100px;">공급가액</th>
			<th style="width: 100px;">부가세</th>
			<th style="width: 100px;">합계</th>
		</tr>
		<tr>
			<td colspan="3" style="border: 0px;"></td>
			<td><input type="text" id="SRprice2" class="SRprice" readonly></td>   <!-- 공급가액 -->
			<td><input type="text" id="SRvat" class="SRprice" readonly></td>      <!-- 부가세  -->
			<td><input type="text" id="SRsumprice1" class="SRprice" readonly></td>   <!-- 총합계 -->
		</tr>
<%
		}
		
%>
			</table>
			<input type="submit" onclick="SRupdate()" value="수  정" style="background: rgb(46,117,182); color: white; font-weight: 500; border: 0px; width: 70px; height: 45px; margin-top:20px;">
		</div>
	</form>
		
		
	</body>
</html>

<%}else { %>
<script>
self.close();
alert("판매 수정에 대한 접근 권한이 없습니다.");
</script>
<%} %>
