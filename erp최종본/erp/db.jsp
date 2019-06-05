<%@ page  contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="estyle.css">

  <script>
            $("document").ready(function(){
                $(".T1").load("menuindex.jsp");

                var width = $(window).width();
                if ( 1200 < width ) {
	                width = ( width - 1200 ) / 2;
	                $(".wrap").css("left",width+"px");
                } else {
                	$(".wrap").css("left","0px");
                }
                $(window).resize(function(){
                	width = $(window).width();
                    if ( 1200 < width ) {
    	                width = ( width - 1200 ) / 2;
    	                $(".wrap").css("left",width+"px");
                    } else {
                    	$(".wrap").css("left","0px");
                    }
                });
            });
        </script>
    
    <style>
     

 
    </style>
    
    
</head>

<body>
  <div>
   <div class="head">
    <div class="T1"></div>
</div>
    <div class="wrap">
        
        <article class="story">
            <h1>Database</h1>
        <img src="img/db.png">

        </article>
    </div>
    </div>
</body>

</html>
