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
%>					String p1 = "청소기";
					String sa = "최태산";
					
					['Month', '제품1', '제품2', '제품3', '제품4', '제품5', '제품6'],
					['사원A',  165,      938,         522,             998,           450,      614.6],
					['사원B',  135,      1120,        599,             1268,          288,      682],
					['사원C',  157,      1167,        587,             807,           397,      623],
					['사원D',  139,      1110,        615,             968,           215,      609.4],
					['사원E',  136,      691,         629,             1026,          366,      569.6],
					['사원F',  136,      691,         629,             1026,          366,      569.6],
				]);
			var options = {
					title : '사원별 판매 차트(수량)',
					vAxis: {title: '수량'},
					hAxis: {title: '월'}, 
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