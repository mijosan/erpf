<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%
 	if (session.getAttribute("idKey") != null) {
 		int id = (Integer) session.getAttribute("idKey");
 %>
<html>
<head>
<style>
	.Sac_in {
		height: 12px;
		color: white;
		font-weight: bold;
		border-radius: 50%;
		background-color: rgb(46,117,182);
		padding: 2px 3px;
	}
</style>
<script src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var preCount = 0;
	function getAC() {
		var id = <%=id%>+"";
		$.ajax({
			type: "POST",
			url: "./alramCount",
			data: {
				id: id
			}, success: function(data) {
				if (data == "") return;
				var parsed = JSON.parse(data);
				var result2 = Number(parsed.result2);
				$(".Sac_in").text(result2);
				if ( preCount < result2 ) {
					$(".Sac_in").effect("shake");				
					preCount = result2;
				}
			}
		});
	}
	 function getInfiniteCount() {
		setInterval(function(){
			getAC();
		}, 3000);
	} 
</script>
</head>
<body>
<span class="Sac_in"></span>
<script>
	$(document).ready(function(){
		getAC();
		getInfiniteCount();
	});
</script>
</body>
</html>
<%}else {
		response.sendRedirect("erpLogin.jsp");
	}%>