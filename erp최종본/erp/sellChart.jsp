<%@page import="erp.SellBean"%>
<%@page import="java.util.Vector"%>
<%@page import="erp.SellMgr"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8"); ////////////////////////////////////////////
	if (session.getAttribute("idKey") != null) {
	int id = (Integer) session.getAttribute("idKey");
	/////////////////////////////////////////////%>
<jsp:useBean id="SMgr" class="erp.SellMgr"/>

<%@ include file="top.jsp" %>
<%@ include file="menu.jsp" %>
<head>
<style>

	.Chartdiv {
		text-align: center;
		float: left;
	}

</style>

<meta charset=”utf-8″ />
<link rel=”stylesheet” href=”morris.css”>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/prettify/r224/prettify.min.css">
</head>

<body>
<br><br>
<div align="center">

	<div class="Chartdiv" style="margin-left: 200px; width: 600px;">
	<div><h1>사원별 판매 현황</h1></div>
	<div id="graph1"></div>
	</div>
	
	<div class="Chartdiv" style="margin-left: 100px; width: 300px;">
	<div><h1>제품별 판매 현황</h1></div>
	<div id="graph2"></div>
	</div>
	
</div>	

	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="morris.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.2/raphael-min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/prettify/r224/prettify.min.js"></script>
	
	<script>

		Morris.Bar({
			element : 'graph1',
			
<%		
			Vector<String> slist = SMgr.getStaffName();
			Vector<String> plist = SMgr.getProductName();
			
			String[] staff = new String[slist.size()];
			String[] product = new String[plist.size()];
%>
			data :[ <%for(int i =0; i < staff.length; i++) {
				staff[i] = slist.get(i);%> //스태프 한명을 찍음
				{x :'<%=staff[i]%>', 
					<%for(int j = 0; j < product.length; j++) {
						boolean flag = false;
						product[j] = plist.get(j);
						%>
						<%=product[j]+" : "%>
						<%
							Vector<SellBean> qlist = SMgr.getSumQuantity(staff[i]);
							for(int k = 0; k < qlist.size(); k++) {
							SellBean Sbean = qlist.get(k);
							if(product[j].equals(Sbean.getP_name())) {%>
								<%=Sbean.getP_quantity()+","%>
							<% flag= true;}else {}%>
						<%}//---for(k)%>
						<%if(flag==false){%>
						null,
						<%}%>
					<%}%>//---for(j)%>
				},
				<%}//---for(i)%>],
			xkey : 'x',
			ykeys : [ <%for(int a = 0; a < product.length; a++) {
				product[a] = plist.get(a);%>
				'<%=product[a]%>',
			<%}%> ],
			labels : [ <%for(int b = 0; b < product.length; b++) {
				product[b] = plist.get(b);%>
				'<%=product[b]%>',
			<%}%> ]
		}).on('click', function(i, row) {
			console.log(i, row);
		});
	</script>
	
	<script>
	
	Morris.Donut({
  element: 'graph2',
  data: [
<%
		Vector<SellBean> vlist = SMgr.getProductList();
		for(int i = 0; i < vlist.size(); i++) {
			SellBean Sbean = vlist.get(i);
%>
		{value: <%=Sbean.getP_quantity()%>, label: '<%=Sbean.getP_name()%>'},	
<%
		}
%>
  ],
  formatter: function (x) {
	  return x + "개"
	  }
}).on('click', function(i, row){
  console.log(i, row);
});
</script>
	
</body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>