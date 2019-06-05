<%@ page  contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>

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
        .T1 {
            position: fixed;
            top: 30px;
            display: inline-block;
        }

        
    </style>
    
    
</head>

<body>
  <div>
   <div class="head">
    <div class="T1"></div>
</div>
    <div class="wrap">
<!--
          <div class="garo">
                <ol>Overview</ol>
                <li>Web-overview</li>
            </div>
-->
       <div>
        <article class="story">
            <h1>Outline</h1>
                    <div style="margin-top: 30px;">
            <div style="align-items: center">
            <div class="box1">Java</div>
                        <div class="box1">Jsp</div>

            <div class="box1">Oracle</div>
            <div class="box1">HTML/CSS</div>
            <div class="box1">Javascript</div>

            </div>
            <div class="conten" style="margin-left: 180px; margin-top: 10px">
            <img src="img/out1.png" width="150px">
            <br />
            <img src="img/out2.PNG">
        </div>
          </div>
           </article>
            </div>
            
        
    </div>
    
    </div>
</body>

</html>
