<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
if (session.getAttribute("idKey") != null) {
	int id = (Integer) session.getAttribute("idKey");
%>
<html>
    <head>
        <style>
            * {
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .Ssmsg_full {
                width: 400px;
                height: 420px;
            }
            .Ssmessage_header {
                border-bottom: 1px solid rgb(220,220,220);
            }
            .Ssmessage_body {
                height: 350px;
                overflow-y: scroll;
                overflow-x: hidden;
            }
            .Ssmessage_footer {
                border-top: 1px solid rgb(220,220,220);
                height: 30px;
                padding-top: 5px;
            }
            .Ssmsg_icon, .Ssmsg_rmf {
                display: inline-block;
                height: 20px;
            }
            .Ssmsg_icon {
                border-right: 1px solid rgb(220,220,220);
                width: 20px;
                background-image: url(./img/msg.png);
                background-repeat: no-repeat;
                background-position: center;
                padding: 5px;
                vertical-align: bottom;
                display: inline-block;
                height: 20px;
            }
            .Ssmsg_rmf {
                display: inline-block;
                height: 20px;
                font-size: 10pt;
                font-weight: bold;
                padding-bottom: 3px;
            }
            .Ssmsg_send_btn {
                margin-left: 5px;
                width: 50px;
                height: 25px;
                border: 1px solid rgb(46,117,182);
                background-color: rgb(46,117,182);
                color: white;
            }
            .Ssmsg_clo_btn {
                border: 1px solid rgb(220,220,220);
                background-color: rgb(250,250,250);
                height: 25px;
            }
            .SaddPee {
                background-color: rgb(220, 240,255);
                display: inline-block;
                border-radius: 15px;
                padding: 3px 7px 3px 7px;
                color: rgb(46,117,182);
                height: 13px;
                margin-left: 10px;
            }
            .SdelPee {
                background-image: url(./img/delPee.png);
                display: inline-block;
                width: 13px;
                height: 13px;
                border-radius: 50%;
                background-position: center;
                vertical-align: top;
            }
            .SgetPee {
                background-image: url(./img/addPee.png);
                width: 18px;
                height: 18px;
                display: inline-block;
                border-radius: 50%;
                background-position: center;
                vertical-align: middle;
            }
            .Str_back {
                background-color: rgb(245,245,245);
                color: rgb(46,117,182);
                height: 30px;
            }
            .Stblsmsg {
                border-collapse: collapse;
                width: 371px;
                margin: 5px;
                margin-top: 10px;
            }
            .Ssmsg_tarea {
                margin-top: 10px;
                width: 371px;
                height: 280px;
            }
            
            
            
            
            
            
            .SsearchPee {
                width: 400px;
                height: 415px;
                position: absolute;
                top: 31px;
                background-color: white;
            }
            .SsearchPee_body {
                margin: 5px 0px 5px 10px;
                height: 335px;
            }
            .SsearchPee_content {
                height: 330px;
                overflow: hidden;
                overflow-y: visible;
            }
            .SsearchPee_footer {
                margin-top: 0px;
                border-top: 1px solid rgb(220,220,220);
                padding-top: 5px;
            }
            .StblsearchPee {
                width: 367px;
                text-align: center;
                border-collapse: collapse;
                border-top: 2px solid rgb(200,220,220);
                border-bottom: 2px solid rgb(200,220,220);
            }
            table.StblsearchPee tr, table.StblsearchPee td {
                border: 1px solid rgb(220,220,220);
                padding: 3px;
            }
            table.StblsearchPee .Str_title {
                background-color: rgb(250,250,250);
                height: 40px;
                color: dimgray;
            }
            .SsearchPee_icon, .SsearchPee_rmf, .SsearchPee_search {
                display: inline-block;
                border-bottom: 1px solid rgb(220,220,220);
                height: 25px;
            }
            .SsearchPee_icon {
                border-right: 1px solid rgb(220,220,220);
                width: 25px;
                background-image: url(./img/msg.png);
                background-repeat: no-repeat;
                background-position: center;
                padding: 5px;
                vertical-align: bottom;
            }
            .SsearchPee_rmf {
                width: 158px;
                font-size: 10pt;
                font-weight: bold;
                vertical-align: baseline;
                margin-left: -4px;
                padding-left: 10px;
            }
            .SsearchPee_search {
                padding-right: 10px;
                vertical-align: bottom;
                margin-left: -4px;
            }
            .Si_searchPee_search {
                height: 20px;
                border: 1px solid rgb(220,220,220);
            }
            .Sbtn_searchPee_search {
                border: 1px solid rgb(46,117,182);
                background-color: rgb(46,117,182);
                color: white;
                height: 20px;
            }
            .SsearchPee_get_btn {
                margin-left: 5px;
                width: 50px;
                height: 25px;
                border: 1px solid rgb(46,117,182);
                background-color: rgb(46,117,182);
                color: white;
            }
            .SsearchPee_clo_btn {
                border: 1px solid rgb(220,220,220);
                background-color: rgb(250,250,250);
                padding: 5px;
            }
        </style>
        <script src="messageJS.js"></script>
        <script type="text/javascript">
        
        function searchRemove() {
    		$(".SsearchPee_tr_title").nextAll().detach();
    	}
 	 
        function RGO() {
        	var tos = new Array();
        	$(".SdelPee").each(function(i){
        		tos.push(""+$(this).attr("id")+"");
        	});
        	var to = tos.join('/');
        	var smsg = $(".Ssmsg_tarea").val();
        	var send = <%=id%>;
        	$.ajax({
        		type:"POST",
        		url:"./goreally",
        		data: {
        			send: send,
        			smsg: decodeURIComponent(smsg),
        			to: decodeURIComponent(to)
        		}, 
        		success: function(data) {
        			if ( data == "" ) {
        				alert("쪽지를 보낼 수 없습니다.");
        			}
        			
        			if ( data == "성공쓰" ) {
        				YouClo();
        			}
        		}
        	});
        }

    	function search(who) {
    		searchRemove();
    		$.ajax({
    			type: "POST",
    			url: "./sendmessage",
    			data: {
    				who: decodeURIComponent(who)
    			},
    			success: function(data) {
    				if ( data == "" )	 {
    					$(".SsearchPee_tr_title").after("<tr><td colspan=4>검색어를 다시 입력해주세요.</td></tr>")
    				}
    				
    				if ( who == "전체검색" ) {
        				var parsed = JSON.parse(data);
        				var empList = parsed.empList;
        				var deptList = parsed.deptList;
        				var dele = 0;
        				for ( var i = 0; i < deptList.length; i++ ) {
        					dele += Number(deptList[i].empCount);
        					for (var j = 0; j < empList.length; j++ ) {
        						if (deptList[i].dept == empList[j].dept) {
	        						if ( j == (dele-1) ) {
	        							$(".SsearchPee_tr_title").after("<tr><td rowspan='"+deptList[i].empCount+"'><input type='checkbox' class='Scb"+i+"' name='Sdeptcb' value="+i+"></td><td rowspan='"+deptList[i].empCount+"'>" + deptList[i].dept + "</td><td><input type='checkbox' class='Scb"+i+"' name='ScbEmp' value=" + empList[j].emp_num + " id="+empList[j].emp_name+"></td><td>" + empList[j].emp_name + "</td></tr>");
	        						} else {
	        							$(".SsearchPee_tr_title").after("<tr><td><input type='checkbox' class='Scb"+i+"' name='ScbEmp' value=" + empList[j].emp_num + " id="+empList[j].emp_name+"></td><td>" + empList[j].emp_name + "</td></tr>");
	        						}
        						}
        					} 
        				}
        			} else {
        				var parsed = JSON.parse(data);
        				var sempList = parsed.sempList;
        				for ( var i = 0; i < sempList.length; i++ ) {
							$(".SsearchPee_tr_title").after("<tr><td><input type='checkbox' name='ScbEmp' value="+sempList[i].emp_num+" id="+sempList[i].emp_name+"></td><td>"+sempList[i].dept+"</td><td>★</td><td>"+sempList[i].emp_name+"</td></tr>");	        					
        				}
        			} 
    			}
    		});
    	}
    	</script>
    </head>
    <body>
        
        <div class="Ssmsg_full">
            <div class="Ssmessage_header">
                <div class="Ssmsg_icon"></div>
                <div class="Ssmsg_rmf">새 쪽지</div>
            </div>
            <div class="Ssmessage_body">
                <table class="Stblsmsg">
                    <tr class="Str_back">
                        <td width="80">받는 사람</td>
                        <td>
                            <div class="SgetPee"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <textarea class="Ssmsg_tarea"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="Ssmessage_footer">
                <button class="Ssmsg_send_btn">작성</button>
            </div>
        </div>
        
        
        <div class="SsearchPee">
            <div class="SsearchPee_header">
                <div class="SsearchPee_icon"></div>
                <div class="SsearchPee_rmf">사용자검색</div>
                <div class="SsearchPee_search">
                    <input type="text" class="Si_searchPee_search">
                    <button class="Sbtn_searchPee_search">Search</button>
                </div>
            </div>
            <div class="SsearchPee_body">
                <div class="SsearchPee_content">
                    <table class="StblsearchPee">
                        <tr class="SsearchPee_tr_title">
                            <td class="SsearchPee_td_title" width="20"><input type="checkbox" name="allCk"></td>
                            <td class="SsearchPee_td_title" width="130">소속부서</td>
                            <td class="SsearchPee_td_title" width="20"><input type="checkbox" name="allCk"></td>
                            <td class="SsearchPee_td_title" width="130">성명</td>
                        </tr>
                        <!-- ajax로 넣는 부분 -->
                    </table>
                </div>
            </div>
            <div class="SsearchPee_footer">
                <button class="SsearchPee_get_btn">적용</button>
                <button class="SsearchPee_clo_btn">닫기</button>
            </div>
        </div>
        
        
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            $(document).ready(function(){
            	
                $(".SsearchPee").hide();
                
                $(".SgetPee").click(function(){
                    $(".SsearchPee").fadeIn();
                    search("전체검색");
                });     
                
                // 쪽지 보내기 버튼
                $(".Ssmsg_send_btn").click(function(){
                	RGO();
                });
                
              	// 이름 검색 버튼
                $(".Sbtn_searchPee_search").click(function(){
                	search($(".Si_searchPee_search").val());
                });
              	
                // 쪽지 보낼 대상 선택 버튼
                $(".SsearchPee_get_btn").click(function(){
                	$(".SsearchPee").hide();
                	$("input[name=ScbEmp]:checked").each(function (index) {  
                        $(".SgetPee").after("<div class='SaddPee'>"+ $(this).attr("id") +"<div class='SdelPee' id='"+$(this).val() +"'></div></div>");
                    }); 
                });
                
                $(".SsearchPee_clo_btn").click(function(){
                	$(".SsearchPee").hide();
                });
                
                $(document).on("click",".SdelPee",function() {
                	$(this).parent().detach();                	
                });
                
                $(document).on("click", "input:checkbox", function() { 
                	if ( $(this).prop('checked') ) {
                		if ( $(this).attr("name") == "allCk" ) {
                			$("input[name=ScbEmp]:checkbox").each(function() {
                				$(this).attr("checked", true);
                			});
                		} else {
                			var cb = $(this).attr("class");
                			$("input[class="+cb+"]:checkbox").each(function() {
                				$(this).attr("checked", true); 
                			});
                		}
					} else if ( !$(this).prop('checked') ) { 
						if ( $(this).attr("name") == "allCk" ) {
                			$("input[name=ScbEmp]:checkbox").each(function() {
                				$(this).attr("checked", false);
                			});
                		} else {
                			var cb = $(this).attr("class");
                			$("input[class="+cb+"]:checkbox").each(function() {
                				$(this).attr("checked", false); 
                			});
                		}	
					} 
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