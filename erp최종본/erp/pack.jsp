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


            <article class="story" style="">
                <h1>Package</h1>

                <div style="margin-left: 30px;">
                    <div class="box4">
                        <div class="sbox"><img src="img/cal_icon.png"></div>
                        <div class="sboxside">
                            <h2>calendar</h2>


                        </div>
                    </div>


                    <div class="box4">
                        <div class="sbox"><img src="img/memo_icon.png"></div>
                        <div class="sboxside">
                            <h2>MEMO</h2>



                        </div>
                    </div>

                    <div class="box4">
                        <div class="sbox"><img src="img/db_icon.png"></div>
                        <div class="sboxside">
                            <h2>Database</h2>

                           


                        </div>
                    </div>
                    <div class="box4">
                        <div class="sbox"><img src="img/chart_icon.png"></div>
                        <div class="sboxside">
                            <h2>Chart</h2>


                        </div>
                    </div>

                    <div class="box4">
                        <div class="sbox"><img src="img/human_icon.png"></div>
                        <div class="sboxside">
                            <h2>Human Resource<br>& Holiday</h2>



                        </div>
                    </div>

                    <div class="box4">
                        <div class="sbox"><img src="img/pro_icon.png"></div>
                        <div class="sboxside">
                        
                            <h2>Production & Sell</h2>


                        </div>
                    </div>


                </div>




            </article>
        </div>
    </div>



</body>
</html>
