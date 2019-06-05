<%@ page contentType="text/html; charset=utf-8" %>
<%
	request.setCharacterEncoding("utf-8");
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
            #Sfull {
                margin: 10px;
                height: 400px;
            }
            .StblCHECK {
                width: 477px;
                border-collapse: collapse;
                background-color: rgb(250,250,250);
            }
            .Std_ti {
                width: 60px;
                text-align: center;
            }
            table.StblCHECK td {
                padding: 7px;
            }
            .Sra {
                vertical-align: sub;
                margin:8px 10px 8px 10px;
            }
            table.StblCHECK tr:hover {
                background-color: rgb(220,220,220);
            }
            .Scall_in {
                width: 477px;
                height: 70px;
                padding-top: 10px;
            }
            .Scall_txt {
                width: 402px;
                height: 70px;
                display: inline-block;
                float: left;
            }
            .Scall_btn {
                height: 70px;
                width: 70px;
                background-color: rgb(46,117,182);
                border: 1px solid rgb(46,117,182);
                color: white;
                vertical-align: super;
                display: inline-block;
                margin-left: 5px;
            }
        </style>
    </head>
    <body>
        
        <div id="Sfull">
            <form name="callFrm" action="callSend.jsp">
            <table class="StblCHECK">
                <tr>
                    <td class="Std_ti">초급</td>
                    <td>
                        <input type="radio" name="check" value="각종 기초코드 등록" class="Sra" checked>각종 기초코드 등록
                        <br>
                        <input type="radio" name="check" value="초기 사용자의 기타 문의" class="Sra">초기 사용자의 기타 문의
                    </td>
                    <td>
                        <input type="radio" name="check" value="ERP 사용자 ID 등록" class="Sra">ERP 사용자 ID 등록
                        <br>
                        <input type="radio" name="check" value="웹, 엑셀-자료 올리기" class="Sra">웹, 엑셀-자료 올리기
                    </td>
                </tr>
                <tr>
                    <td class="Std_ti">테마</td>
                    <td>
                        <input type="radio" name="check" value="인사-기능 활용법" class="Sra">인사-기능 활용법
                        <br>
                        <input type="radio" name="check" value="인사-기능 오류" class="Sra">인사-기능 오류
                    </td>
                    <td>
                        <input type="radio" name="check" value="재고-기능 활용법" class="Sra">재고-기능 활용법
                        <br>
                        <input type="radio" name="check" value="재고-원가, 수량 문제" class="Sra">재고-원가, 수량 문제
                    </td>
                </tr>
                <tr>
                    <td class="Std_ti">중급</td>
                    <td>
                        <input type="radio" name="check" value="급여 대장 문의" class="Sra">급여 대장 문의
                        <br>
                        <input type="radio" name="check" value="기초잔액 입력" class="Sra">기초잔액 입력
                    </td>
                    <td>
                        <input type="radio" name="check" value="재고조정" class="Sra">재고조정
                        <br>
                        <input type="radio" name="check" value="그룹웨어" class="Sra">그룹웨어
                    </td>
                </tr>
                <tr>
                    <td class="Std_ti">기타</td>
                    <td>
                        <input type="radio" name="check" value="사용료(환불, 탈되 등)" class="Sra">사용료(환불, 탈되 등)
                        <br>
                        <input type="radio" name="check" value="ERP 작동 불량" class="Sra">ERP 작동 불량
                        <br>
                        <input type="radio" name="check" value="진짜로 기타" class="Sra">진짜로 기타
                    </td>
                    <td>
                        <input type="radio" name="check" value="부가서비스(신청, 해지)" class="Sra">부가서비스(신청, 해지)
                        <br>
                        <input type="radio" name="check" value="영업 및 교육(신청)" class="Sra">영업 및 교육(신청)                        
                    </td>
                </tr>
            </table>
            <div class="Scall_in">
                <textarea class="Scall_txt" name="content" placeholder="문의 내용을 입력하세요"></textarea>
                <button class="Scall_btn">문의요청</button>
            </div>
            </form>
        </div>
        

        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            $(document).ready(function(){
                $(".Scall_btn").click(function(){
                    if ($(".Scall_txt").val()) {
                    	$("callFrm").submit();                       
                    } else {
                    	alert("문의 내용을 입력하세요");
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