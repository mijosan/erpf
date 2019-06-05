<%@ page contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8");
////////////////////////////////////////////
	if (session.getAttribute("idKey") != null) {
	int id = (Integer) session.getAttribute("idKey");
	/////////////////////////////////////////////%>
<html>
    <head>      
        <link rel='stylesheet' href='fullcalendar.min.css'/>
        <link rel='stylesheet' href='fullcalendar.print.min.css' media="print"/>
        <link href="https://fonts.googleapis.com/css?family=Ubuntu+Condensed" rel="stylesheet">
        <script src='jquery.min.js'></script>
        <script src='moment.min.js'></script>
        <script src='fullcalendar.min.js' ></script>
        <script src='bpopup.min.js' ></script>
        <script src='ko.js' ></script>
        <style type="text/css">
        	 *{
             font-family: 'Ubuntu Condensed', sans-serif;   
           }
           #calendar{
           	width:900px;
           }
		  .fc-sat span{
		      color:blue;
		  }
		  .fc-sun span{
		       color:red;
		   }
		  .fc-today-button{
		        font-family: 'Ubuntu Condensed', sans-serif;   
		   }
		  .fc-day:hover{
		        background-color: antiquewhite;
		   }
           .box-title{
           		color:white;
           }
           .newButton{
           		background-color: rgb(46,117,182);
	        	border-radius: 25px;
	        	border: 1px solid #dee3eb;
	        	color: white;
	        	height:30px;
	        	margin-top:5px;
	        	float:right;
	        	width:80px;
           }
           
        </style>
        <script>
            $(document).ready(function(){
               $('#calendar').fullCalendar({
                   editable:false,
                   navLinks:true,
                   eventLimit:false,
                   dayClick: function(date, jsEvent, view) {                	
                	   addSchedule();
						$('#calendar_start_date').val(date.format());
                	  },
                   events:{
                	   url:'calendarGetServlet',
                	   error:function(){
                		   $('#script-warning').show();
                	   }
                   }
               });
               var add_button = "<button onclick='javascript:addSchedule()'>일정등록</button>";
               $('.fc-right').append(add_button);
           
            });
            function addSchedule(){
            	var htmlsContents="";
            	htmlsContents += "<div style='width:100%; height:30px'> <div style='width:30%;float:left; padding-left:30px'>일정 명칭</div><div style='width:60%;float:right'><input type='text' id='calendar_title' value=''></div></div>";
            	htmlsContents += "<div style='width:100%; height:30px'> <div style='width:30%;float:left; padding-left:30px'>시작 날짜</div><div style='width:60%;float:right'><input type='text' id='calendar_start_date' value='' style='width:100px; text-align:center; font-size:14px' placeholder='0000-00-00'></div></div>";
            	htmlsContents += "<div style='width:100%; height:30px'> <div style='width:30%;float:left; padding-left:30px'>마침 날짜</div><div style='width:60%;float:right'><input type='text' id='calendar_end_date' value='' style='width:100px; text-align:center; font-size:14px' placeholder='0000-00-00'></div></div>";
            	htmlsContents += "<div style='width:100%; text-align:center; height:30px;margin-bottom:15px; margin-top:10px '><button class='newButton' onclick='javascript:saveSchedule()'>저 장</button></div>";
            	openPopup('일정등록',htmlsContents,400);
            }
            function saveSchedule(){
            	var calendar_title=$('#calendar_title').val();
            	var calendar_start_date= $('#calendar_start_date').val();
            	var calendar_end_date= $('#calendar_end_date').val();
            	
            	if(!calendar_title){
            		alert('일정 제목을 입력하십시오.');
            		return false;
            	}
            	if(!calendar_start_date){
            		alert('시작 날짜를 입력하십시오.');
            		return false;
            	}
            	if(!calendar_end_date){
            		alert('마감 날짜를 입력하십시오.');
            		return false;
            	}
            	$.ajax({
            		type:'POST',
            		url:'calendarServlet',
            		data:{
            			calendar_title: decodeURIComponent(calendar_title), 
            			calendar_start_date: decodeURIComponent(calendar_start_date), 
            			calendar_end_date: decodeURIComponent(calendar_end_date)
            			},
            		success:function(result){
            			if(result=="true"){
            				closeMessage('winAlert');
            				alert('저장완료 !');
            				$('#calendar').fullCalendar('refetchEvents');
            			}
            		}	
            	})
            }

            function openPopup(subject,contents,widths){
            	
            	$('#alert_subject').html(subject);
            	$('#alert_contents').html(contents);
            	openMessage('winAlert',widths);
            }
            function openMessage(IDS, widths){
            	$('#'+IDS).css('width',widths+'px');
            	$('#'+IDS).bPopup();
            }
            function closeMessage(IDS){
            	$('#'+IDS).bPopup().close();
            }
       
        </script>
    </head>
    <body>
    <div id='script-warning' style='background:#eee; color:red; display:none'>
    실행 오류 !<!-- 이벤트 로딩 실패시에 활성화 되는 부분 -->
    </div>
        <div id="calendar"></div>
        <div class='box box-success' style='width:500px; display:none; background-color:white' id='winAlert'>
        	<div class='box-header with-border' style='background-color:white; padding-left:0px'>
        		<h3 class='box-title' id='alert_subject' style='background-color:rgb(46,117,182); margin-top:0;'></h3>
        	</div>
        	<div class='box-body' id='alert_contents' style='font-size:15px; background-color:white'></div>
        </div>
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>