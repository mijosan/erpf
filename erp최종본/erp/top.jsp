<%@ page contentType="text/html; charset=utf-8" %>
<%
	request.setCharacterEncoding("utf-8");
	if (session.getAttribute("idKey") != null) {
		int idE = (Integer) session.getAttribute("idKey");
%>
<html>
    <head>
    	
        <style>
            * {
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .Sfull {
                width: 100%;
            }
            .Stop1{        
                width: 100%;
                height: 40px;
                border-collapse: collapse;
            }
            .Smenuimg img{
                width:21px;
                height:20px;
                margin: 0px 7px; 
            }
            .Slogo img{
                width:40px;
                height:40px;
                margin: 0px 7px; 
            }
            .Scustomer-center button{
                background-color: white;
                border: none;
            }
            .Sd_alt {
                background-color: white;
                position: absolute;
                border: 1px solid rgb(0,90,129);
                border-radius: 4px;
                padding: 5px 10px;
                text-align: center;
                z-index: 15;
                left: 990px;
            }
            .Spersonal {
                width: 350px;
                height: 310px;
                position: absolute;
                left: 900px;
                z-index: 15;
            }
            .Scall {
                border: 1px solid rgb(0, 90, 129);
                background-color: white;
                width: 500px;
                height: 450px;
                position: absolute;
                left: 400px;
                top: 50px;
                z-index: 15;
            }
            .Scall_tool {
                background-color: rgb(46,117,182);           
                border-bottom: 1px solid rgb(0,90,129);
                height: 30px;
            }
            .Scall_rmf {
                color: white;
                font-weight: bold;
                display: inline-block;
                width: 450px;
                height: 20px;
                margin-left: 8px;
            }
            .Scall_clo{
                vertical-align: bottom;
                display: inline-block;
                border-left: 1px solid rgb(0,90,135);
                width: 30px;
                height: 30px;
                background-position: center;
                background-repeat: no-repeat;
                background-image: url(./img/clo.png);
            }
         	.Salram_count {
                position: absolute;
                left: 1155px;
                top: 15px;
                z-index: 15;
         	}
         	
         	.Smessage {
                border: 1px solid rgb(0, 90, 129);
                background-color: white;
                width: 700px;
                height: 435px;
                position: absolute;
                left: 400px;
                top: 50px;
                z-index: 15;
            }
            .Smessage_tool {
                background-color: rgb(46,117,182);           
                border-bottom: 1px solid rgb(0,90,129);
                height: 30px;
            }
            .Smessage_rmf {
                color: white;
                font-weight: bold;
                display: inline-block;
                width: 655px;
                height: 20px;
                margin-left: 8px;
            }
            .Smessage_clo{
                vertical-align: bottom;
                display: inline-block;
                border-left: 1px solid rgb(0,90,135);
                width: 30px;
                height: 30px;
                background-position: center;
                background-repeat: no-repeat;
                background-image: url(./img/clo.png);
            }
            
            .SmemoIn {
                border: 1px solid rgb(0, 90, 129);
                background-color: white;
                width: 380px;
                height: 262px;
                position: absolute;
                left: 400px;
                top: 50px;
                z-index: 15;
            }
            .SmemoIn_tool {
                background-color: rgb(46,117,182);           
                border-bottom: 1px solid rgb(0,90,129);
                height: 30px;
            }
            .SmemoIn_rmf {
                color: white;
                font-weight: bold;
                display: inline-block;
                width: 335px;
                height: 20px;
                margin-left: 8px;
            }
            .SmemoIn_clo{
                vertical-align: bottom;
                display: inline-block;
                border-left: 1px solid rgb(0,90,135);
                width: 30px;
                height: 30px;
                background-position: center;
                background-repeat: no-repeat;
                background-image: url(./img/clo.png);
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
			    #searchS{
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
        </style>
    </head>     
    <body>
        <div class="Sfull">
            <table class="Stop1">
                <tr> 
             
                    <td align="left"><div class='Slogo'><img src="./img/erp.png"></div></td>
                    <td style="width:110px;"><font color=gray>ERP_Program by F-team</font></td>
                    <td>
                    
                    
                    <div class="search">
                    
                    <form action="searchProc.jsp">
                    	<input name="search_content" type="text" class="searchBox" placeholder="게시판 이름을 입력하세요.">
                    	<input id="searchS" value="" type="submit">
                    </form>
                    
                    </div></td>
                    <td><div class='Smenuimg'><img src="./img/home@3x.png" name="홈"></div></td> <!--홈-->
                    <td><div class='Smenuimg'><img src="./img/125-Bell.png" name="알림"></div></td> <!--알림-->
                    <td><div class='Smenuimg'><img src="./img/13-Check.png" name="메모"></div></td> <!--메모-->
                    <td><div class='Smenuimg' id="Salram"><img src="./img/25-Communication.png" name="쪽지"></div></td> <!--쪽지-->
                    <td><div class='Smenuimg'><img src="./img/phone.png" name="문의요청"></div></td> <!--문의사항-->
                    <td><div class='Smenuimg'  id="Sper"><img src="./img/person.png" name="개인정보"></div></td> <!--개인정보-->
                    <td><div class='Smenuimg'><img  src="./img/151-Arrow-Right.png" name="로그아웃"></div></td> <!--로그아웃-->
                </tr>
            </table> 
			<div class="Salram_count"></div>
			<div class="Sd_alt"><span class="St_alt"></span></div>
        </div>
        
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            $(document).ready(function(){
          		
                $(".Sd_alt").hide();
                
                
				$(".Salram_count").css("left",$("#Salram").offset().left+25);
				
			
				var where = window.location.pathname;
				if ( where != "/erp/main.jsp" ) {
                	$(".Salram_count").load("alramCount.jsp");
				}
                
                
                $(window).resize(function(){
                	$(".Salram_count").css("left",$("#Salram").offset().left+25);
                });
                
                $(".Smenuimg").hover(function(){
                    var chu = $(this).children().attr("name");
                    var lef = $(this).offset().left;
                    $(".Sd_alt").toggle(); 
                    $(".St_alt").text(chu);
                    if (chu == "홈") {                    	
                        $(".Sd_alt").css("left",lef);
                    } else if (chu == "알림") {
                        $(".Sd_alt").css("left",lef-5);
                    } else if (chu == "메모") {
                        $(".Sd_alt").css("left",lef-5);
                    } else if (chu == "쪽지") {
                        $(".Sd_alt").css("left",lef-5);
                    } else if (chu == "문의요청") {
                        $(".Sd_alt").css("left",lef-15);
                    } else if (chu == "개인정보") {
                        $(".Sd_alt").css("left",lef-15);
                    } else if (chu == "로그아웃") {
                        $(".Sd_alt").css("left",lef-40);
                    }
                });
                
                 $(".Smenuimg").click(function(){
                    var chu = $(this).children().attr("name");
                    if (chu == "홈") {
                        location.href="main.jsp";
                    } else if (chu == "알림") {
                        
                    } else if (chu == "메모") {
						$(".Sfull").append(" <div class='SmemoIn'><div class='SmemoIn_tool'><div class='SmemoIn_rmf'>메모장</div><div class='SmemoIn_clo'></div></div><div class='SmemoIn_include'></div></div>");
                    	$(".SmemoIn_include").load("memo.jsp");
                    	$(".SmemoIn").draggable();
                    } else if (chu == "쪽지") {
                    	$(".Sfull").append("<div class='Smessage'><div class='Smessage_tool'><div class='Smessage_rmf'>쪽지함</div><div class='Smessage_clo'></div></div><div class='Smessage_include'></div></div>");
                        $(".Smessage_include").load("message.jsp");
                        $(".Smessage").draggable();
                    } else if (chu == "문의요청") {
                    	$(".Sfull").append("<div class='Scall'><div class='Scall_tool'><div class='Scall_rmf'>문의요청하기</div><div class='Scall_clo'></div></div><div class='Scall_include'></div></div>");
                        $(".Scall_include").load("call.jsp");
                        $(".Scall").draggable();
                    } else if (chu == "개인정보") {
                    	var lef2 = $("#Sper").offset().left;
                        $(".Sfull").append("<div class='Spersonal'></div>");
                        $(".Spersonal").css("left",lef2-320);
                        $(".Spersonal").load("personal.jsp");
                    } else if (chu == "로그아웃") {
                        location.href="erpLogout.jsp";
                    }
                }); 
                 
                 $(document).on("mouseleave",".Spersonal",function(){
                	 $(".Spersonal").detach();
                 });
                $(document).on("click",".Smessage_clo",function(){
                	$(".Smessage").nextAll().detach();
                	$(".Smessage").detach();
                });
                $(document).on("click",".Scall_clo",function(){
                	$(".Scall").nextAll().detach();
                	$(".Scall").detach();
                });
                $(document).on("click",".SmemoIn_clo",function(){
                	$(".SmemoIn").nextAll().detach();
                	$(".SmemoIn").detach();
                }); 
            });
        </script>
    </body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>