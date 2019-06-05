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
    <style>
        .fconten {
            float: left;
            width: 850px;
            margin: 10px;
            display: inline-block;
            margin-bottom: 30px;
            
        }
        
    </style>
</head>

<body>

    <div>
        <div class="head">
            <div class="T1"></div>
        </div>

        <div class="wrap" style="position:absolute;">
            <article class="story">
                <h1>Frame</h1>
                <div class="fconten">
                    <img src="img/first_cap.PNG">
                </div>
            </article>
            <div class="as">
                <div class="ast">
                    <h1>First_frame</h1>
                    <p>User interface</p>

                </div>
                <ul>
                    <li>Notice</li>
                    <li>Memo</li>
                    <li>Calendar</li>
                </ul>

            </div>



<!-- Calendar-->
           
            <div style="margin-bottom: 30px">

                <article class="story">
                    <div class="fconten">
                       <h1>Calendar</h1>
                        <div class="frame">
                            <img src="img/cal1.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Calendar</h1>
                        <p>User interface</p>

                    </div>
                    <ul>

                        <li><b>Today_focus</b></li>
                        <li>Add Schedule</li>
                        <li>Show Schedule</li>
                    </ul>

                </div>
            </div>

            <div>

                <article class="story">
                    <div class="conten">
                        <div class="frame">
                            <img src="img/cal2.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Calendar</h1>
                        <p>User interface</p>

                    </div>
                    <ul>

                        <li>Today_focus</li>
                        <li><b>Add Schedule</b></li>
                        <li>Show Schedule</li>

                    </ul>

                </div>
            </div>

            <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/cal3.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Calendar</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>Today_focus</li>
                        <li>Add Schedule</li>
                        <li><b>Show Schedule</b></li>
                    </ul>

                </div>
            </div>

    
<!--  Memo         -->

    <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Memo</h1>
                        <div class="frame">
                            <img src="img/memo_cap1.PNG">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Memo</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>LayerPopup</li>
                        
                        
                        
                    </ul>

                </div>
            </div>
            
             <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/memo_cap2.PNG">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Memo</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>Add</li>
                        <li>Delete</li>
                        
                        
                        
                    </ul>

                </div>
            </div>
            
<!-- Message            -->
             <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Message</h1>
                        <div class="frame">
                            <img src="img/memo_cap3.PNG">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Message</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>실시간 알림</li>
                        <li>LayerPopup</li><br>
                        
                        
                        
                    </ul>

                </div>
            </div>
            
            
                <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/memo_cap4.PNG">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Message</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>실시간 알림</li>
                        <li>LayerPopup</li><br>
                        
                        
                    </ul>

                </div>
            </div>
            
            
                <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/memo_cap5.PNG">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Message</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                       <li>실시간 알림</li>
                        <li>LayerPopup</li><br>
                        
                    </ul>

                </div>
            </div>
            
<!--HR-->

      <div>

                <article class="story">
                    <div class="fconten">
                       <h1>H/R</h1>
                        <div class="frame">
                            <img src="img/hr1.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>H/R</h1>
                        <p>Web Page</p>

                    </div>
                    <ul>
                        <li>등록</li>
                        <li>조회</li>
                        <li>수정</li>
                    </ul>

                </div>
            </div>
            
            
       <!--Salary-->
        <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Salary</h1>
                        <div class="frame">
                            <img src="img/salary1.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Salary</h1>
                        <p>Web Page</p>

                    </div>
                    <ul>
                         <li>승인</li>
                        <li>등록</li>
                        <li>조회</li>
                    </ul>

                </div>
            </div>
            
<!--  기능     -->
<!--  생산     -->
         <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Production</h1>
                        <div class="frame">
                            <img src="img/g1.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Production</h1>
                        <p>Web Page</p>

                    </div>
                    <ul>
                        <li><b>조회</b></li>
                        <li>등록</li>
                        <li>수정</li>
                        
                    </ul>

                </div>
            </div>
       
          <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/g2.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Production</h1>
                        <p>Web Page</p>

                    </div>
                    <ul>
                        <li>조회</li>
                        <li><b>등록</b></li>
                        <li>수정</li>
                        
                    </ul>

                </div>
            </div>
            
               <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/g3.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Production</h1>
                        <p>Web Page</p>

                    </div>
                    <ul>
                        <li>조회</li>
                        <li>등록</li>
                        <li><b>수정</b></li>
                        
                    </ul>

                </div>
            </div>
       
<!--  판매     -->
       
               <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Sell</h1>
                        <div class="frame">
                            <img src="img/g4.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Sell</h1>
                        <p>Web Page</p>

                    </div>
                    <ul>
                        <li><b>조회</b></li>
                        <li>등록</li>
                        <li>수정</li>
                        
                    </ul>

                </div>
            </div>
       
         <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/g5.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Sell</h1>
                        <p>Web Page</p>

                    </div>
                    <ul>
                        <li>조회</li>
                        <li><b>등록</b></li>
                        <li>수정</li>
                        
                    </ul>

                </div>
            </div>
       
         <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/g6.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Sell</h1>
                        <p>Web Page</p>

                    </div>
                    <ul>
                        <li>조회</li>
                        <li>등록</li>
                        <li><b>수정</b></li>
                        
                    </ul>

                </div>
            </div>
       
<!--   퇴직금    -->
      
      
               <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Retirement</h1>
                        <div class="frame">
                            <img src="img/g7.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Retirement</h1>
                        <p>Web Page</p>

                    </div>
                    <ul>
                        <li>재직일수 계산</li>
                        <li>퇴직금 계산</li><br>
                        
                        
                    </ul>

                </div>
            </div>
       
       
<!--  Chart    -->
      
      
               <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Chart</h1>
                        <div class="frame">
                            <img src="img/chart.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Chart</h1>
                        <p>Web Page</p>

                    </div>
                    <ul>
                        <li>사원별 판매 현황</li>
                        <li>제품별 판매 현황</li><br>
                        
                        
                    </ul>

                </div>
            </div>
            
            
            
<!--Notice            -->

 <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Notice</h1>
                        <div class="frame">
                            <img src="img/notice.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Notice</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>Authority</li><br>
                        
                        
                    </ul>

                </div>
            </div>
            
            
            
 <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/notice2.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Notice</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>Download</li>
                        <li>Authority Update</li>
                        <li>Authority Delete</li>
                        
                        
                    </ul>

                </div>
            </div>

<div>

                <article class="story">
                    <div class="fconten">
                       <h1>Dept Notice</h1>
                        <div class="frame">
                            <img src="img/notice3.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Dept Notice</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>Download</li>
                        <li>Authority Update</li>
                        <li>Authority Delete</li>
                        
                        
                    </ul>

                </div>
            </div>

<div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/notice4.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Dept Notice</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>Download</li>
                        <li>Authority Update</li>
                        <li>Authority Delete</li>
                        <li>Comment</li>
                        
                        
                    </ul>

                </div>
            </div>
            
<!--  Holiday Board          -->
           
            <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Holiday Board</h1>
                        <div class="frame">
                            <img src="img/notice5.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Holiday Board</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>search</li>
                        <li>Authority</li>
                        <li>Update</li>
                        <li>Paging</li>
                        
                        
                    </ul>

                </div>
            </div>
            
                <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/notice6.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Holiday Board</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>search</li>
                        <li>Authority</li>
                        <li>Update</li>
                        <li>Paging</li>
                        
                        
                    </ul>

                </div>
            </div>
            
<!--Anony Board            -->
    <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Anony Board</h1>
                        <div class="frame">
                            <img src="img/notice7.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Anony Board</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>search</li>
                        <li>Authority</li>
                        <li>Update</li>
                        <li>Paging</li>
                        
                        
                    </ul>

                </div>
            </div>


    <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/notice8.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Anony Board</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>File</li>
                        <li>Authority</li>
                        <li>Create</li>
                        <li>Anonymous</li>
                        
                        
                    </ul>

                </div>
            </div>
            
                <div>

                <article class="story">
                    <div class="fconten">
                        <div class="frame">
                            <img src="img/notice9.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Anony Board</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>read</li>
                        <li>comment</li>
                        <li>Authority Update</li>
                        <li>Authority Delete</li>
                        
                        
                    </ul>

                </div>
            </div>
            
<!--  Log Board          -->
    <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Log Board</h1>
                        <div class="frame">
                            <img src="img/notice10.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Log Board</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>Authority LoginLog</li>
                        <li>Authority Search</li><br>
                        
                        
                        
                    </ul>

                </div>
            </div>
            
<!--  All Job Board          -->

    <div>

                <article class="story">
                    <div class="fconten">
                       <h1>All Job Board</h1>
                        <div class="frame">
                            <img src="img/notice11.png">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>All Job Board</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>Show All Board</li>
                        <li>Authority show</li>
                        <br>
                        
                    </ul>

                </div>
            </div>
        
            
<!--inquiry            -->
                <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Inquiry</h1>
                        <div class="frame">
                            <img src="img/memo_cap6.PNG">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Inquiry</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>search</li>
                        <li>Authority</li>
                        <li>Update</li>
                        <li>Paging</li>
                        
                        
                    </ul>

                </div>
            </div>
            
<!--commute               -->
                <div>

                <article class="story">
                    <div class="fconten">
                       <h1>Commute</h1>
                        <div class="frame">
                            <img src="img/memo_cap7.PNG">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>commute</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>database</li>
                        <br>
                        
                    </ul>

                </div>
            </div>
            
<!--Logout               -->
                <div>

                <article class="story">
                    
                    <div class="fconten">
                       <h1>LogOut</h1>
                        <div class="frame">
                            <img src="img/memo_cap8.PNG">
                        </div>
                    </div>
                </article>
                <div class="as">
                    <div class="ast">
                        <h1>Logout</h1>
                        <p>User interface</p>

                    </div>
                    <ul>
                        <li>logout</li><br>
                        
                        
                    </ul>

                </div>
            </div>
            
            
<!--       -->
        </div>

    </div>

</body>

</html>
