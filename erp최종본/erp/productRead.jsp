<%@page import="erp.EmployeeBean"%>
<%@page import="java.util.Vector"%>
<%@page import="erp.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<jsp:useBean id="UtilMgr" class="erp.UtilMgr"/>
<jsp:useBean id="PMgr" class="erp.ProductMgr"/>
<%
		request.setCharacterEncoding("utf-8");
		int Add_num = UtilMgr.getInt(request, "add_num");
		EmployeeBean Ebean = (EmployeeBean)session.getAttribute("employeeBean");
		if(Ebean.getEmp_dept().equals("생산부") || Ebean.getEmp_job().equals("이사")) {
%>
<html>
	<head>
		<style>
			.tblProdutRead th{
				border: 1px solid rgb(210,210,210);
				background: rgb(249,249,249);
				height: 40px;
			}
			
			.tblProdutRead td{
				border: 1px solid rgb(210,210,210);
				text-align: center;
				height: 40px;
			}
			
			.PRinputtext {
				width: 100px;
				height: 40px;
				border: 0px;
				text-align: center;
			}
			
		</style>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script>
		
		</script>
	</head>
	
	<body>
	
			<div> <!--별, 생산등록 div1-->
                <table style="border-bottom: 1px solid rgb(210,210,210);">
                    <tr>
                        <td style="width: 100px; text-align: center;"><img src="img/star2.png"></td>
                        <td style="width: 800px;">생산 수정</td>
                    </tr>
                </table>
            </div> <!--별, 생산등록 div1-->
            
    <form action="productReadProc.jsp" autocomplete="off">
		<div align="center" style="margin-top: 20px;">
			<table class="tblProdutRead" style="border-collapse: collapse">
			
				<tr>
					<th style="width: 100px;">생산번호</th>
					<th style="width: 100px;">제품번호</th>
					<th style="width: 200px;">품목</th>
					<th style="width: 100px;">수량</th>
					<th style="width: 100px;">단가</th>
					<th style="width: 100px;">생산공장</th>
					<th style="width: 100px;">생산일</th>
				</tr>
<%
				ProductBean Pbean = PMgr.getList(Add_num);
%>
		<tr>
			<td><input type="text" class="PRinputtext" name="add_num" value=<%=Pbean.getAdd_num() %> readonly></td>
			<td><input type="text" class="PRinputtext" name="p_num" value=<%=Pbean.getP_num() %>></td>
			<td><input type="text" class="PRinputtext" name="p_name" value=<%=Pbean.getP_name() %> style="width: 200px;"></td>
			<td><input type="text" class="PRinputtext" name="p_quantity" value=<%=Pbean.getP_quantity() %>></td>
			<td><input type="text" class="PRinputtext" name="p_price" value=<%=Pbean.getP_price()%>></td>
			<td><input type="text" class="PRinputtext" name="p_container" value=<%=Pbean.getP_container() %>></td>
			<td><input type="text" class="PRinputtext" name="p_date" value=<%=Pbean.getP_date() %>></td>
		</tr>
			</table>
			<input type="submit" onclick="PRupdate()" value="수  정" style="background: rgb(46,117,182); color: white; font-weight: 500; border: 0px; width: 70px; height: 45px; margin-top:20px;">
		</div>
	</form>
		
		
	</body>
</html>
<%}else { %>
<script>
self.close();
alert("생산 제품 수정에 대한 접근 권한이 없습니다.");
</script>
<%} %>
