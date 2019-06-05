<%@ page  contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

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
                <h1>Purpose</h1>
                <div class="content">

                    <div class="half">
                        <div class="card"><img src="img/jsp.png"></div>
                        <div class="card"><img src="img/oracledb.png"><br />
                            <font size="6px;">Oracle</font>
                        </div>

                        <div class="cardas" style="text-align: left;">
                            <br />
                            <li>교육기간 동안 배웠던 모든 지식을 동원하여 <br><br/>프로그래밍을 함으로써 <b>실전</b>에 활용 <br /><br /><br /></li>

                            <li><b>Oracle DB 연동</b>을 통한 데이터 보관과 <br>배웠던 쿼리문을 활용 <br /></li>

                        </div>

                    </div>
                    <div class="half">
                        <div class="card">
                            <img src="img/htmlicon.png" style="width: 100px"><img src="img/css.png" style="width: 90px">
                        </div>
                        <div class="card"><img src="img/jscript.png"></div>
                        <div class="cardas" style="text-align: left;">
                            <br />
                            <li>개인 프로젝트가 아닌 팀원들과의 <b>협업</b>을 통한 보다 더 큰 규모와 높은 퀄리티의 프로그램을 제작<br /><br /><br /></li>

                            <li>배웠던 내용 이외에 구글링, 웹서칭을 통해 기술적인 요소를 확대하여 <b>실력 향상</b><br /></li>


                        </div>
                    </div>

                </div>
            </article>



        </div>
    </div>
</body>

</html>
