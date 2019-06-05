<%@ page contentType="text/html; charset=utf-8" %>
<%
	request.setCharacterEncoding("utf-8");
	if ( session.getAttribute("idKey") != null ) {
	int id = (Integer) session.getAttribute("idKey");
%>
<html>
    <head>
        <style>
           * {
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .SbossMemo {
                width: 380px;
            }
            .Smemo {
                width: 380px;
                height: 200px;
            }
            .Smemo1 {
                width: 379px;
                height: 30px;
            }
            .Smemo2 {
                width: 357px;
                height: 155px;
                padding: 6px 0px 0px 23px;
                background-color: transparent;
                overflow: hidden;
                overflow-y: auto;
            }
            .Smemo2_txt {
            	width: 350px;
            	margin-top: 0px;
            	line-height: 22px;
            }
            .Stitle {
                width: 230px;
                overflow: hidden;
                display: inline-block;
                float: left;
                margin-top: 13px;
                margin-left: 24px;
                margin-right: 30px;
                font-size: 13px;
                font-weight: bold;
            }
            .Sdate {
            	font-size: 13px;
                width: 90px;
                display: inline-block;
                margin-top: 16px;
            }
            .SselectMemo {
                width: 380px;
                height: 30px;
                border-bottom: 1px solid rgb(220,220,220);
            }
            .Srmf { 
                width: 260px;
                height: 30px;
                display: inline-block; 
                float: left;
                margin-left: 10px;
                padding-top: 8px;
                font-weight: bold;
				font-size: 14px;
            }
            .Simage {
                width: 100px;
                height: 30px;
                display: inline-block;
                text-align: right;
                padding-top: 5px;
            }
            .Snew {
            	background-image: url(./img/plus.png);
                width: 30px;
                height: 20px;
                display: inline-block;
                float: right;
                background-position: center;
                background-repeat: no-repeat;
            }
            .Ssave {
            	background-image: url(./img/save.png);
                width: 30px;
                height: 20px;
                display: inline-block;
                float: right;
                background-position: center;
                background-repeat: no-repeat;
            }
            .Sdelete {
            	background-image: url(./img/trash.png);
                width: 30px;
                height: 20px;
                display: inline-block;
                float: right;
                background-position: center;
                background-repeat: no-repeat;
            }
            .Smemo3 {
                width: 370px;
                margin-left: 7px;
                background-color: transparent;
            }
            .StblMemo {
           	 	width: 350px;
                margin-left: 7px;
                background-color: transparent;
            	border-collapse: collapse;
            }
            table.StblMemo tr {
            	border-bottom: 1px solid rgb(220,220,220);
            }
            table.StblMemo td {
            	padding-left: 3px;
            }
            .Smemo4 {
                width: 350px;
                border: 0px solid white;
                padding: 10px 0px 0px 17px;
                background-color: transparent;
            }
             .Si_title {
            	width: 335px;
            	background-color: transparent;
            	margin-left: 5px;
            	height: 25px;
            }
            .Smemo4_tarea {
                width: 340px;
                height: 150px;
                border: 0px solid white;
                margin-left: 5px;
                margin-top: 6px;
                background-color: transparent;
                line-height: 22px;
            }
        </style>
        <script>
        	function getList() {
        		$(".Smemo3_List").nextAll().detach();
        		$(".Stitle").text("");
				$(".Sdate").text("");
				$(".Smemo2").val("");
				$(".Si_title").val("");
        		$(".Smemo4_tarea").val("");
        		var id = <%=id %>;
        		var how = "전체목록";
        		var title = "전체목록 타이틀";
        		var content = "전체목록 내용";
        		$.ajax({
        			type: "POST",
        			url: "./memo",
        			data: {
        				id: id,
        				how: decodeURIComponent(how),
        				title: decodeURIComponent(title),
        				content: decodeURIComponent(content)
        			},
        			success: function(data) {
        				if ( data == "" )	 {
        					$(".Smemo3_List").after("<tr><td colspan=3>메모가 존재하지 않습니다.</td></tr>");
        				}
        				var parsed = JSON.parse(data);
        				var mList = parsed.mList;
        				for ( var i = 0; i < mList.length; i++ ) {
        					$(".Smemo3_List").after("<tr class='SviewMemo' name="+mList[i].date+"><td width='20'>★</td><td width='240'>"+mList[i].title+"</td><td>"+mList[i].date+"</td></tr>");
        				}
        			}
        		});
        	}
        	
        	function saveMemo() {
        		var id = <%=id %>;
        		var how = "메모저장";
        		var title = $(".Si_title").val();
        		var content = $(".Smemo4_tarea").val();
        		$.ajax({
        			type: "POST",
        			url: "./memo",
        			data: {
        				id: id,
        				how: decodeURIComponent(how),
        				title: decodeURIComponent(title),
        				content: decodeURIComponent(content)
        			},
        			success: function(data) {
        				if ( data == "" )	 {
        				}
        				getList();
        			}
        		});
        	}
        	function getMemo(title, content) {
        		var id = <%=id %>;
        		var how = "메모조회";
        		$.ajax({
        			type: "POST",
        			url: "./memo",
        			data: {
        				id: id,
        				how: decodeURIComponent(how),
        				title: decodeURIComponent(title),
        				content: decodeURIComponent(content)
        			},
        			success: function(data) {
        				if ( data == "" )	 {
        				}
        				var parsed = JSON.parse(data);
        				var memo = parsed.memo;
        				$(".Stitle").text(memo[0].title.replace(/&nbsp;/gi, " "));
        				$(".Sdate").text(memo[0].date);
        				$(".Smemo2_txt").html(memo[0].content);
        			}
        		});
        	}
        	function delMemo(title, content) {
        		var id = <%=id %>;
        		var how = "메모삭제";
        		$.ajax({
        			type: "POST",
        			url: "./memo",
        			data: {
        				id: id,
        				how: decodeURIComponent(how),
        				title: decodeURIComponent(title),
        				content: decodeURIComponent(content)
        			},
        			success: function(data) {
        				if ( data == "" )	 {
        				}
        				getList();
        			}
        		});
        	}
        	function upMemo() {
        		var id = <%=id %>;
        		var how = "메모수정";
        		var title = $(".Stitle").text();
        		title += ":" + $(".Sdate").text();
        		var content = $(".Smemo2").val();
        		$.ajax({
        			type: "POST",
        			url: "./memo",
        			data: {
        				id: id,
        				how: decodeURIComponent(how),
        				title: decodeURIComponent(title),
        				content: decodeURIComponent(content)
        			},
        			success: function(data) {
        				if ( data == "" )	 {
        				}
        				getList();
        			}
        		});
        	}
        </script>
    </head>
    <body>
        <div class="SbossMemo">
            <div class="SselectMemo">
                <span class="Srmf">Memo</span>
                <div class="Simage">
                	<div class="Sdelete"></div>
                    <div class="Ssave" ></div>
                    <div class="Snew"></div>
                </div>
            </div>
            <div class="Smemo">
                <div class="Smemo3">
                    <table class="StblMemo">
                        <tr height="7" class="Smemo3_List"></tr>
                        <!-- ajax로 목록 불러오는 부분임 -->
                    </table>
                </div>
                <div class="Smemo4">
	                <input type="text" class="Si_title">
                   	<textarea class="Smemo4_tarea"></textarea>
                </div>
                <div class="Smemo1">
	              	<span class="Stitle" ></span>
	     		     <span class="Sdate"></span>
	     		</div>
	     		<div class="Smemo2">
	     			<pre class="Smemo2_txt"></pre>	
	     		</div>
			</div>
        </div>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            $(document).ready(function(){
                getList();
                $(".Smemo3").show();
                $(".Smemo1").hide();
                $(".Smemo2").hide();
                $(".Smemo4").hide();
                $(".Ssave").hide();
                $(".Sdelete").hide();
                
                $(".Ssave").click(function(){
                    saveMemo();
                	$(".Smemo3").fadeIn();
                    $(".Smemo4").hide();
                    $(".Smemo1").hide();
                    $(".Smemo2").hide();
                    $(".Ssave").hide();
                    $(".Snew").show();
                    $(".Sdelete").hide();
                    $(".Smemo").css("background-image","url(./img/note8.png)");
                });
                $(".Snew").click(function(){
                	//새글 쓰겠다
                    $(".Smemo4").fadeIn();
                    $(".Smemo3").hide();
                    $(".Smemo1").hide();
                    $(".Smemo2").hide();
                    $(".Ssave").show();
                    $(".Snew").hide();
                    $(".Sdelete").hide();
                    $(".Smemo").css("background-image","url(./img/note7.png)");
                });
                $(document).on("click",".SviewMemo",function(){
                	//내용을 보여라
                	//값 가져옴
                	var title = $(this).find("td").eq(1).html();
                	var content = $(this).attr("name");
                	getMemo(title, content);
                	//////////
                    $(".Smemo3").hide();
                    $(".Smemo4").hide();
                    $(".Smemo1").fadeIn();
                    $(".Smemo2").fadeIn();
                    $(".Ssave").hide();
                    $(".Snew").show();
                    $(".Sdelete").show();
                    $(".Smemo").css("background-image","url(./img/note7.png)");
                });
                $(".Srmf").click(function(){
                	getList();
                	//목록을 보여라
                    $(".Smemo1").hide();
                    $(".Smemo2").hide();
                    $(".Smemo3").fadeIn();
                    $(".Smemo4").hide();
                    $(".Ssave").hide();
                    $(".Snew").show();
                    $(".Sdelete").hide();
                    $(".Smemo").css("background-image","url(./img/note8.png)");
                });
                $(".Sdelete").click(function() {
                	var title = $(".Stitle").text();
                	var content = $(".Sdate").text();
                	delMemo(title, content);
                	//목록을 보여라
                    $(".Smemo1").hide();
                    $(".Smemo2").hide();
                    $(".Smemo3").fadeIn();
                    $(".Smemo4").hide();
                    $(".Ssave").hide();
                    $(".Snew").show();
                    $(".Sdelete").hide();
                    $(".Smemo").css("background-image","url(./img/note8.png)");
				});
            });
        </script>
    </body>
</html>
<% } %>