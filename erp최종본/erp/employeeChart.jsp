<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR"); 
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawVisualization);
	
		function drawVisualization() { 
			var data = google.visualization.arrayToDataTable([
<%
					/* Vector<SellBean> vlist = SMgr.getMaxEmployee();
					for(int i = 0; i < vlist.size(); i++) {
						
					} */
%>					String p1 = "û�ұ�";
					String sa = "���»�";
					
					['Month', '��ǰ1', '��ǰ2', '��ǰ3', '��ǰ4', '��ǰ5', '��ǰ6'],
					['���A',  165,      938,         522,             998,           450,      614.6],
					['���B',  135,      1120,        599,             1268,          288,      682],
					['���C',  157,      1167,        587,             807,           397,      623],
					['���D',  139,      1110,        615,             968,           215,      609.4],
					['���E',  136,      691,         629,             1026,          366,      569.6],
					['���F',  136,      691,         629,             1026,          366,      569.6],
				]);
			var options = {
					title : '����� �Ǹ� ��Ʈ(����)',
					vAxis: {title: '����'},
					hAxis: {title: '��'}, 
					seriesType: 'bars',
					series: {5: {type: 'line'}}
				};
			
			var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
			chart.draw(data, options);
		}
	</script>
</head>
<body>
	<div id="chart_div" style="width:900px; height: 500px;"></div>
</body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>