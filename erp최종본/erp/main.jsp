<%@ page contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<html>
    <head>
    	<title>ERP F팀</title>
   		<link rel='stylesheet' href='fullcalendar.min.css'/>
        <link rel='stylesheet' href='fullcalendar.print.min.css' media="print"/>
        <link href="https://fonts.googleapis.com/css?family=Ubuntu+Condensed" rel="stylesheet">        
        <script src='moment.min.js'></script>
        <script src='jquery.min.js'></script>
        <script src='fullcalendar.min.js' ></script>
        <script src='bpopup.min.js' ></script>
        <script src='ko.js' ></script>
        <style>
            .container{
                min-width: 1200px;
                margin: 0 auto;
            }
            .top{              
                width: 100%;
                height: 50px;
                margin: 0;
            }
            .navigation_111{
                 margin:0;
                 height: 65px; 
            }                
            .contents{                
                width: 1400px;
                height: 900px;
                border: 1px solid #dee3eb;
                background-color: #eeeeee;
                margin:0 auto;
            }
            .contents-left {
                margin-left: 3px;
                margin-top: 5px;
                display: inline-block;
                border: 1px solid #dee3eb; 
                width: 900px;
                float: left;
                background-color: white;
            }
            .contents-right {
                margin-top: 5px;
                margin-left: 10px;
                display: inline-block;
                border: 1px solid #dee3eb;
                width: 480px;
                background-color: #eeeeee;
            }
            .contents-right-top{
                background-color: white;
                margin-bottom: 10px;
                overflow-y:scroll;
            }
            .contents-right-mid{
                background-color: white;
                height: 320px;
                overflow-y:scroll;
            }
            .contents-right-btm{
                margin-top: 10px;
                background-color: white;
                overflow-y:scroll;
            }
            .board{
                width: 400px;
            }
            *{
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .foot{
                text-align: center;
                color : gray; 
            }
            /* 탑부분 css */
             .customer-center img{
			        width:35px;
			        height:30px;
			        margin: 5px;
			    }    
			    .top1{        
			        min-width: 100%;
			        height: 40px;
			        margin: 0;
			    }
			    .menuimg img{
			        width:20px;
			        height:20px;
			        margin: 5px; 
			    }
			    .logo img{
			        width:35px;
			        height:30px;
			        margin: 5px; 
			    }
			    .customer-center button{
			        background-color: white;
			        border: none;
			    }
			    .search{
			        border: 1px solid #dee3eb;
			        border-radius: 0.5em;
			        width: 340px;
			        height: 30px;
			        margin-left: 10px;
			    }
			    .search img{
			        width: 15px;
			        height: 15px;
			        margin: 0;
			    }
			    .search button{
			        border: none;
			        width: 15px;
			        height: 15px;
			        margin-top: 8px;
			        background-image: url(img/search.png);
			        background-size: cover;
			        background-color: white;
			    }
			    .searchBox{
			        border: none;
			        width: 90%;
			        height: 20px;
			        margin-left: 3px;
			    }
			    /*메뉴부분 css*/
			                #topMenu {
                min-width: 1300px;
                height: 50px;
                font-size: 12px;
            }
            
            .topMenuLi {
                margin-left: 5px;
                margin-right: 50px;
                cursor: pointer;
                color:black;
            }
            .topMenuLi a{
                  text-decoration:none;
                  color:black;
            }           
            #topMenu ul { /* 메인 메뉴 안의 ul을 설정함: 상위메뉴의 ul+하위 메뉴의 ul */ 
                list-style-type: none;
                margin: 0px;
                padding: 0px;
            }            
            #topMenu ul li { /* 메인 메뉴 안에 ul 태그 안에 있는 li 태그의 스타일 적용(상위/하위메뉴 모두) */ 
                float: left;
                line-height: 30px;
                text-align: center;
                /*position: relative;*/
            }            
            .subMenu li{
                margin-left: 10px;
                margin-right: 20px;
                color:white;
            }
            .subMenu li a{
            	color:white;
            }
            .subMenu li a:visited{
            	color:white;
            }            
            .subMenu { /* 하위 메뉴 스타일 설정 */
                position: absolute;
                height: 0px;   /*하위 메뉴 숨기기*/
                overflow: hidden;   /*하위 메뉴 숨기기*/
                width: 500px; /* 가로 드랍다운 메뉴의 넓이 */
                transition: height .2s;                
            }            
            .topMenuLi:hover .submenu { /* 상위 메뉴에 마우스 모버한 경우 그 안의 하위 메뉴 스타일 설정 */ 
                height: 30px; /* 높이를 32px로 설정 */
                color: white;
                font-weight: normal;
            }
            a{
            	text-decoration:none;
            }
        </style>        
   		
 
    </head>
    <body>
        <div class="container">
            <div class="top">
            	<!-- <table class="top1">
			      <tr> 
			        <td align="left"><div class='logo'><a href="main.jsp"><img src="img/erp.png"></a></div></td>
			          <td><font color=gray>ERP_Program by F-team</font></td>
			          <td><div class="search"><input type="text" class="searchBox" placeholder="게시판 이름을 입력하세요."><button></button></div></td>
			        <td width=30%><div></div></td>
			        <td><div class="customer-center" style="margin-top: 5px"><button><img src='img/phone.png' style="vertical-align: middle;margin-right: 0px;margin-top: 0px;">고객센터</button></div></td>
			        <td><div class='menuimg'><img src="img/person.png"></div></td> 알림
			
			        <td><div class='menuimg'><img src="img/125-Bell.png"></div></td> 알림
			        <td><div class='menuimg'><img src="img/13-Check.png"></div></td> 공지사항
			        <td><div class='menuimg'><img src="img/25-Communication.png"></div></td> 쪽지
			        <td><div class='menuimg'><img src="img/settings@3x.png"></div></td> 설정
			        <td><div class='menuimg'><img  src="img/151-Arrow-Right.png"></div></td> 로그아웃
			        <td><div class='menuimg'><img src="img/home@3x.png"></div></td> 홈
			      </tr>
			     </table> -->
			      <%@ include file="top.jsp" %>
				   </div>
				  <%@ include file="menu.jsp" %>
           <!--  <div class="navigation_111">
            	        <div id="topMenu">
            <ul>
                
                <li id="IdtopMenu1" class="topMenuLi"><a href="hrMenu.jsp">인사/급여 관리</a>                    
                    <ul class="subMenu">
                        <li><a href="hrMenu.jsp">인사기초</a></li>
                                             
                        <li><a href="salaryPage.jsp">급여대장</a></li>
                        
                        <li><a href="retirement.jsp">퇴직정산</a></li>
                        
                        <li><a href="certification.jsp">증명관리</a></li>
                    </ul>
                </li>
                
                
                
                <li id="IdtopMenu2" class="topMenuLi">생산/재고 관리
                    <ul class="subMenu">
                        <li>생산관리</li>
                        
                        <li>생산관리 조회</li>
                        
                        <li>재고 차트</li>
                    </ul>
                    
                </li>
                
                
                
                <li id="IdtopMenu3" class="topMenuLi">영업/구매 관리
                    <ul class="subMenu">
                        <li>판매 등록</li>
                        
                        <li class="subMenuLi">판매 조회</li>
                        
                        <li class="subMenuLi">거래처 등록</li>
                    </ul>
                    
                </li>
                
                
                <li id="IdtopMenu4" class="topMenuLi">근태 관리
                    <ul class="subMenu">
                        <li class="subMenuLi">근태 등록</li>
                    </ul>
                    
                </li>
                
                
                
                <li id="IdtopMenu5" class="topMenuLi">그룹웨어
                    <ul class="subMenu">
                        <li class="subMenuLi">게시판</li>
                        
                        <li class="subMenuLi">부서별 게시판(이사부)</li>
                    </ul>
                    
                </li>
                
            </ul>
            
        </div>
        
        <div style="background: rgb(46,117,182); margin-top: -20px; min-width: 1300px; height: 30px;"></div>
            </div> -->
            
            <div class="submenu"></div>
            <div class="contents">
                <div class="contents-left">                	        		
                    <%@ include file="calendar.jsp"%>
                 </div> 
                <div class="contents-right">
                <div class="contents-right-top">
                <div class="contents-board">
                <%@ include file="board.jsp" %>	
                </div>
                </div>
                <div class="contents-right-mid"><%@ include file="JobBoard.jsp" %>	</div>
                <div class="contents-right-btm">
                <div class="memo">
                <%-- <%@ include file="memo.jsp" %> --%>
                </div>
                </div>
                
            	</div>
            </div>
            <div class="foot">모든 저작권은 ERP_F팀에 있으며 포트폴리오용으로 제작되었습니다.<br>
                 Copyright ⓒ ERP_F Team. All Rights Reserved.
            </div>
            
	</div>
     
    </body>
</html>