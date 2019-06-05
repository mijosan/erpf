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
        $("document").ready(function() {
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
</head>

<body>
     

    <div>
        <div class="head">
            <div class="T1"></div>
        </div>

    <div class="wrap">
        <article class="story" style="margin-top: 0;">
            <h1>Review</h1>
    <div class="conten" style="margin-left: 30px;">

        <div class="box3">Problem</div><br/>
        
        <div class="cir2"><img src="img/r1.png" ><b>Authority</b><br/><br/>데이터 베이스에 대한 <br/>권한부여 미흡</div>
        
        <div class="cir2"><img src="img/r2.png"><b>Database</b><br/><br/>데이터 베이스의 <br/>활용도가 다소 미흡</div>
        <div class="cir2"><img src="img/r3.png"><b>Coding</b><br/><br/>깔끔하지않은 코딩<br/></div>
        <div class="cir2"><img src="img/r4.png"><b>Design</b><br/><br/>조금 부족해 보이는 <br/>디자인</div>
        <div class="cir2"><img src="img/r5.png"><b>Security</b><br/><br/>웹페이지 접근 보안이<br/>다소 떨어짐</div>

        </div>
          </article>
    </div>
       
          
</div>
</body></html>
    