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
            
        });
    </script>

    <style>
        .ff{
            
            display: flex;
        }
        
        .lef{
            width: 40%;
            align-items: center;
            flex-shrink: 0;

        }
    </style>
</head>

<body>

    <div>

        <div class="head">
            <div class="T1"></div>
        </div>

        <div class="wrap">


            <article class="story">
                <h1>Introduction</h1>
                
                <div class="ff">
                <div class="lef">

                    <img src="img/d.PNG">
                </div>
                <div class="lef" style="margin-top: 50px; margin-left: 20px;">
                    <div class="box3">ERP_F</div><br/>

                    <hr style="border:1px color= silver; width: 450px;">


                    <div class="name">최태산</div>
                    <div class="name">이정환</div>
                    <div class="name">김희권</div>
                    <div class="name">김승주</div>
                    <div class="name">최유영</div>

                </div>




</div>

            </article>
        </div>
    </div>



</body>
</html>
