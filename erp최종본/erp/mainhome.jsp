<%@ page  contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<html lang='ko'>
<head>

    <meta charset='utf-8'>
    <title>ERP_Fteam | Portfolio</title>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="estyle.css">

    <script>
        $("document").ready(function(){
                $(".T1").load("menuindex.jsp");
            });
        </script>

    <style>

            .videonotice{
                color: white;
                padding-top: 246px;
                text-align: center;
                font-size: 2em;
                
            }           
            .vcontainer{
                width: 100%;
                margin-top: 100px;
                
            }
            .contents1{
                margin-top: 10px
                height: 600px;
            }
            #myVideo {
              position: fixed;
              right: 0;
              bottom: 0;
              top: 90px;
              min-width: 100%; 
              min-height: 100%;
              z-index: -1000;
            }
            *{
                font-family: 'Noto Sans KR', sans-serif;
            }
            .foot{
                padding-top: 250px;
                color: white;
                text-align: center;
            }
            
            
        </style>
</head>

<body>
    <div>

        <div class="head">
            <div class="T1"></div>
        </div>


        <div class="vcontainer">
            <section class="contents1">
                <video autoplay muted loop id="myVideo">
                    <source src="mainvideo.mp4" type="video/mp4">
                </video>

                <div class="videonotice">
                    <p><font color="#ffffff">Welcome !<br>F팀의 포트폴리오 홈페이지입니다.<br><br>ERP 웹프로젝트 내용 확인과 </font><font color="yellow">데모</font><font color="#ffffff">를 사용할 수 있습니다.</font></p>
                </div>
            </section>
            <section class="contents2">

            </section>
        </div>
    </div>
    <footer>
        <div class="foot">Copyright ERP_F Team. All Rights Reserved.</div>
    </footer>
</body>

</html>