<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>

<head>
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="menustyles.css">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet">

    <link rel="stylesheet" href="estyle.css">
            <title>ERP_Fteam | Portfolio</title>

    <script src="menuscript.js"></script>

    <style>
        * {
            font-family: 'Noto Sans KR', sans-serif;

        }

        .nav {
            margin-top: 0px;
            height: 80px;
            position: fixed;
           
        }

        .logo {
            float: left;
            width: 500px;
            background: white;
        }

        .logo img {
            margin-left: 30px;
            margin-top: -10px;
            width: 50px;
            height: 50px;
            backgound: white;
        }

        .menuArea div {
            display: inline-block;
        }

        .menu {
            float: left;
            width: 1600px;
            height:70px;
            margin-top:-10px;
            padding-top: 20px;
            background:#ffffff;
            display: flex;
            flex-shrink: 0;
        }
        
        .last2 {
        	padding-top: 2px; 
        	padding-bottom: 2px;
        }

    </style>
</head>

<body>
    <div>
        <nav class="nav">
            <div class="menuArea">
                <div class="menu">
                    <div class="logo"><a href="mainhome.jsp">
                            <img src="erp.png"></a>
                        <font color="gray" size="1">WEB Project by ERP_F team</font>
                    </div>


                    <div id='cssmenu'>

                        <ul>
                            
                            <li class='active has-sub'><a href='intro.jsp'>Introduction</a>
                                <ul>
                                 <li class='has-sub'><a href='contents.jsp'>Contents</a>
                                        
                                    </li>
                                    <li class='has-sub'><a href='intro.jsp'>Introduction</a>
                                        
                                    </li>
                                    
                                    <li class='has-sub'><a href='pur.jsp'>Purpose</a>
                                        
                                    </li>
                                </ul>
                            </li>

                            <li class='active has-sub'><a href='#'>Overview</a>
                                <ul>
                                    <li class='has-sub'><a href='#'>WebOverview</a>
                                        <ul>
                                            <li><a href='outline.jsp'>Outline</a></li>
                                            <li><a href='overview.jsp'>Overview</a></li>
                                            <li class='last'><a href='command.jsp'>Command</a></li>
                                        </ul>
                                    </li>
                                    <li class='has-sub'><a href='pack.jsp'>Package</a>

                                    </li>
                                </ul>
                            </li>

                            <li><a href='db.jsp'>Database</a></li>
                            <li><a href='frame.jsp'>Frame</a></li>

                            
                            <li class='last'><a href='review.jsp'>Review</a></li>
                            
                            
                            <!--erp 홈페이지 이동--> 

                            <li class='last2'><a href='erpLogin.jsp'><font color="red">데모 체험</font></a></li>
                            
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    </div>
</body>
<html>
