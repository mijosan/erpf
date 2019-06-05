<%@page import="erp.EmployeeBean"%>
<%@page import="java.util.Vector"%>
<%@page import="erp.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<jsp:useBean id="PMgr" class="erp.ProductMgr"/>
<%
		request.setCharacterEncoding("utf-8");			
		int totalRecord = PMgr.getTotalCount(); //전체 레코드 수
		int numPerPage = 10; //페이지당 레코드 수
		int pagePerBlock = 10; //블럭당 페이지 수
		int totalPage = 0; //전체 페이지 수
		int totalBlock = 0; //전체 블럭 수
		int nowPage = 1; //현재 페이지
		int nowBlock = 1; //편재 블럭
		
		int start = (nowPage*numPerPage)-numPerPage; //디비의 select 시작번호
		int end = numPerPage; //시작번호로 부터 가져올 select 갯수
		
		if(request.getParameter("nowPage")!=null) { //다른 페이지로 넘어갈 때 nowPage값을 넘겨줘야 해서 null이 아닐경우 nowPage값을 받아옴.
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
			start = (nowPage * numPerPage)-numPerPage+1;  //페이지당 레코드가 10개면 2페이지는 11번 부터 시작. --> (2*10)-10 = 10. 이렇게 되면 10페이지가 두번 나와서 +1을 해줘야 한다.
		}
		
		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
		totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
%>


<%@ include file="top.jsp" %>
<%@ include file="menu.jsp" %>
<html>
    <head>
        <style>
            
            .full { /*전체 div 감싸기*/
                width: 1000px;
                margin: auto;
                height: 100%;
            }
            
            .Ptbl th{   /*테이블 제일 윗칸*/
                border: 1px solid rgb(210,210,210);
                background: rgb(249,249,249);
                height: 50px;
            }
            
            .Ptbl td {
            	border: 1px solid rgb(210,210,210);
                text-align: center;
                height: 50px;
            }
            
            .Phref {
            	color: black;
				text-decoration: none;
            } 
            
            input[id=allcheck]{
                transform: scale(1.5);
			}
			input[class=productCheckbox] {
			    transform: scale(1.5);
			}
			
        </style>
        
        
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            
            $(document).ready(function(){
               $(".top1").load("top.html");
               $(".top2").load("menubar.html");
               
               $("#allcheck").click(function(){
            	   $(".productCheckbox").prop("checked", this.checked);
               });//---#allcheck
               
               
            }); //---ready
            
            function add1() {
            	var frmX = (window.screen.width/2) - (1200 / 2);
            	var frmY = (window.screen.height/2) - (400 / 2);
            	window.open("insertProduct.jsp","제품추가","width=1200, height=400 left="+frmX+", top="+frmY);
            }
            
            function delete1() {
            	var checkb = document.getElementsByClassName("productCheckbox");
            	document.productFrm.action = "deleteProduct.jsp";
            	document.productFrm.submit();
            }
            
            function read(add_num) { //---productRead.jsp로 sellnum 값 넘기기
       		 var frmX = (window.screen.width/2) - (1000 / 2);
           	 var frmY = (window.screen.height/2) - (300 / 2);
           	 var url = "productRead.jsp?add_num="+add_num;
           	window.open(url,"_blank","width=1000, height=300, left="+ frmX +", top="+ frmY);
       	}
            
            function pageing(page) {
            	if(page<=0) {
            		page=1;
            	}
            	if(page><%=totalPage%>) {
            		page=<%=totalPage%>
            	}
            	document.readFrm.nowPage.value = page;
            	document.readFrm.submit();
            }
            
            function block(blockValue) {
            	if(blockValue <= 0) {
            		blockValue = 1;
            	}
            	if(blockValue><%=totalBlock%>) {
            		blockValue = <%=totalBlock%>
            	}
            	document.readFrm.nowPage.value = <%=pagePerBlock%>*(blockValue-1)+1;
            	document.readFrm.submit();
            }
            
            
        </script>
    </head>
    
    <body>

        
        <div class="full">
            
            <div> <!--별, 생산등록 div1-->
            <br>
                <table style="border-bottom: 1px solid rgb(210,210,210); border-top: 1px solid rgb(210,210,210);">
                    <tr>
                        <td style="width: 100px; text-align: center;"><img src="img/star2.png"></td>
                        <td style="width: 750px;"><a href="product.jsp" class="Phref">생산 조회</a></td>
                        <td style="width: 50px;">
                        <input type="button" onclick="delete1()" value="선택 삭제" style="background: rgb(46,117,182); color: white; font-weight: 500; border: 0px; width: 70px; height: 30px;">
                        </td>
                        <td style="width: 50px;">
                        <input type="button" onclick="add1()" value="등   록" style="background: rgb(46,117,182); color: white; font-weight: 500; border: 0px; width: 50px; height: 30px;">
                        </td>                        
                    </tr>
                </table>
            </div> <!--별, 생산등록 div1-->
            
            
           
	                    
	<%
						Vector<ProductBean> vlist = PMgr.getProductList(start, end);
						int listSize = vlist.size();
						if(vlist.isEmpty()) {
							out.println("등록된 제품이 없습니다.");
						}else {
%>
 <!--생산등록 테이블 시작-->
            <form name="productFrm" method="post">
	            <div style="margin-left: 50px; margin-top: 30px;">
	                <table style="border-collapse: collapse;" class="Ptbl">
						<tr>
	                        <th style="width: 40px;">
	                        <input type="checkbox" id="allcheck">
	                        </th>
	                        <th style="width: 80px;">생산 번호</th>
	                        <th style="width: 100px;">제품 번호</th>
	                        <th style="width: 170px;">제&emsp;품</th>
	                        <th style="width: 60px;">수량</th>
	                        <th style="width: 100px;">가격</th>
	                        <th style="width: 150px;">생산 공장</th>
	                        <th style="width: 150px;">생산일</th>
	                    </tr>
<%
						for(int i = 0; i < vlist.size(); i++) {
							ProductBean Pbean = vlist.get(i);
%>
						<tr>
	                        <td style="width: 40px;">
	                        <input type="checkbox" name="checkbox" class="productCheckbox" value=<%=Pbean.getAdd_num()%>>
	                        </td>
	                        <td>
	                        <a href="javascript:read('<%=Pbean.getAdd_num()%>')" style="color: rgb(46,117,182); text-decoration: none;" class="Phref"><%=Pbean.getAdd_num() %></a>
	                        </td>
	                        <td><%=Pbean.getP_num()%></td>
	                        <td><%=Pbean.getP_name()%></td>
	                        <td><%=Pbean.getP_quantity()%></td>
	                        <td><%=Pbean.getP_price()%></td>
	                        <td><%=Pbean.getP_container()%></td>
	                        <td><%=Pbean.getP_date()%></td>
	                     </tr>
	                  
	<%
						}//---for
	%>
		                </table>
            <div style="text-align: center; margin-top: 30px;">
            
            			<!-- 이전 블럭으로 이동 시작 -->
            				<a href="javascript:block('<%=nowBlock-1%>')"><img src="img/1.gif"></a>
            
		                <!-- 이전 페이지로 이동 시작  -->
		                	<a href="javascript:pageing('<%=nowPage-1%>')"><img src="img/2.gif"></a>
		                

		                <!-- 페이징 시작 -->
<%
							int pageStart = (nowBlock-1)*pagePerBlock+1;
							int pageEnd = (pageStart + pagePerBlock) <= totalPage? (pageStart+pagePerBlock):totalPage+1;
							for(int i = pageStart; i < pageEnd; i++) {
%>
								<a href="javascript:pageing('<%=i%>')" class="Phref">
								<%if(i==nowPage) {%> <font color="red"><%} %>
								[<%=i %>]
								<%if(i==nowPage) {%></font><%} %>
								</a>
<%
							}
%>
		                <!-- 페이징  끝 -->
		                
		                
		                <!-- 다음 페이지로 이동 시작 -->
		                	<a href="javascript:pageing('<%=nowPage+1%>')"><img src="img/3.gif"></a>
		                
		                <!-- 다음 블럭으로 이동 시작 -->
		                	<a href="javascript:block('<%=nowBlock+1%>')"><img src="img/4.gif"></a>
		                
	                </div>
	                </div>
	              </form>
<%}//---else %>
            <!--생산등록 테이블 끝-->
            
            <form name="readFrm">
            	<input type="hidden" name="totalRecord" value="<%=totalRecord%>">
            	<input type="hidden" name="nowPage" value="<%=nowPage%>">
            </form>
            
            
            
            
        </div><!--full div-->
        
    </body>
</html>
