<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
%>
<%@ include file="top.jsp" %>
<%@ include file="menu.jsp" %>
<html>
<head>
<style>
.full1 { /*전체 div 감싸기*/
	position:absolute;
	min-width: 1300px;
	word-break: break-all;	
	left:50%; 
	transform:translateX(-50%);
	margin-top:10px;
}

.title2 { /*가, 나,다 등 제목(굵은 글자)*/
	font-weight: bold;
	margin-top: 30px;
	margin-left: 20px;
}

.firsttbl { /*오른쪽, 왼쪽 테이블 둘다 해당*/
	border-collapse: collapse;
	float: left;
	margin-bottom: 10px;
}

.secondtbl { /*가. 퇴직전 3개월간 임금총액(세전금액) 테이블*/
	border-collapse: collapse;
	text-align: center;
}

.secondtbl td { /*가. 퇴직전 3개월간 임금총액(세전금액) 테이블 td*/
	background: white;
	height: 60px;
}

.firsttbl td, .secondtbl th {
	border: 1px solid rgb(210, 210, 210);
}

.firsttd { /*왼쪽, 오른쪽 맨윗칸 배경색 설정*/
	background: rgb(242, 244, 251);
	text-align: center;
	font-weight: bold;
	color: rgb(46, 117, 182);
}

.secondtd { /*왼쪽, 오른쪽 테이블 넓이 설정 */
	width: 645px;
}

.classHr { /*왼쪽, 오른쪽 테이블 안에 있는 테이블들 위에 있는 hr 속성*/
	background: rgb(46, 117, 182);
	height: 1.5px;
	margin: 15px;
}

.secondtblTh {
	background: rgb(242, 244, 251);
	width: 150px;
	height: 40px;
	font-weight: bold;
	color: rgb(46, 117, 182);
}

/*왼쪽 테이블안에 있는 총액 계산 테이블 - input text크기 설정*/
.secondtbltext {
	width: 80px;
	height: 30px;
}

.leftdiv { /*왼쪽 테이블 밑쪽 글자들 왼쪽 margin 주기*/
	margin-left: 20px;
}

.companyyear td { /*왼쪽에 입사일자 입력 칸 테이블 td*/
	text-align: left;
	border: 0px;
	width: 100px;
	padding: 5px;
}

.pay1 { /*왼쪽 테이블 : 입사일자, 퇴직일자 input 크기조정*/
	width: 150px;
	height: 25px;
}

.paytbl td { /*왼쪽 연간상여금 총액 ~ 퇴직금*/
	border: 0px;
	padding: 5px;
}

.paytd1 { /*왼쪽 연간상여금 총액 ~ 퇴직금*/
	width: 150px;
}

}
.paytd2 { /*왼쪽 퇴직금 계산 input 크기 조정*/
	width: 100px;
	height: 30px;
}
</style>


<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
            
            var sdate;
            var edate;
            
            $(document).ready(function(){
                $(".top1").load("top.html");
                $(".top2").load("menubar.html");                
                
                
                
                $("#monthpay1,#monthpay2,#monthpay3").change(function(){/*왼쪽 테이블 기본급 합계 계산*/
                    var pay1 = Number($("#monthpay1").val());
                    var pay2 = Number($("#monthpay2").val());
                    var pay3 = Number($("#monthpay3").val());
                    var sumpay = pay1 + pay2 + pay3;
                $(".sumpay1").text(sumpay);
                
                });
                $("#monthpay4,#monthpay5,#monthpay6").change(function(){/*오른쪽 테이블 기본급 합계 계산*/
                    var pay1 = Number($("#monthpay4").val());
                    var pay2 = Number($("#monthpay5").val());
                    var pay3 = Number($("#monthpay6").val());
                    var sumpay = pay1 + pay2 + pay3;
                $(".sumpay2").text(sumpay);
                
                });
                
                $("#monthpay7, #monthpay8").change(function(){
                   var pay1 = Number($("#monthpay7").val());
                   var pay2 = Number($("#monthpay8").val());
                   var sumpay = pay1+pay2;
                    
                $(".sumpay3").text(sumpay);
                });
                    
            });
            
            
            
        
            function calculator1() { /*평균임금 계산 기간 보기 버튼*/
                var sdate = document.getElementById("startday").value;
                var time1 = new Date(sdate);
                var sdateTime = time1.getTime();
                
                var edate = document.getElementById("endday").value;
                var time2 = new Date(edate);
                var edateTime = time2.getTime();
                
                var minusTime = ((edateTime-sdateTime)/(1000*60*60*24));
                
                $("#workday").val(minusTime);
                
                return minusTime;
            };
            
            function calculator2() { /*평균임금 계산 버튼*/
                
                var pay1 = Number($("#monthpay1").val());
                var pay2 = Number($("#monthpay2").val());
                var pay3 = Number($("#monthpay3").val());
                var pay4 = Number($("#monthpay4").val());
                var pay5 = Number($("#monthpay5").val());
                var pay6 = Number($("#monthpay6").val());
                var pay7 = Number($("#monthpay7").val());
                var pay8 = Number($("#monthpay8").val());
                
                var monthpay7 = pay7/4;/*1일 평균 임금 -> 연간 상여금 구하기*/
                var monthpay8 = pay8/4;/*1일 평균 임금 -> 연차 수당 구하기 ->*/
                
                var sumpay = Math.floor((pay1+pay2+pay3+pay4+pay5+pay6+monthpay7+monthpay8)/90);
                $("#retirementpay1").val(sumpay);
                
                return sumpay;
            };
            
            function calculator3() { /*퇴직금 계산 버튼*/
                var retirementPay = Math.floor(calculator2() * 30 * (calculator1()/365));
                $("#retirementpay2").val(retirementPay);
            };
            
        </script>
</head>

<body>
	<!--퇴직금 정산 코드 시작-->
	<div class="full1">
		<!--전체 div 감싸기-->
		<span style="margin-left: 110px; font-size: 25px; font-weight: bold;">퇴직금
			정산</span>
		<hr
			style="background: rgb(46, 117, 182); height: 1.5px; width: 1300px;">

		<!--왼쪽 테이블 시작-->
		<div>
			<table class="firsttbl">
				<tr>
					<td><div class="firsttd">퇴직금 계산 하기</div></td>
				</tr>

				<!--입사일자, 퇴직일자 입력 div 시작-->
				<tr>
					<td class="bottomline"><div class="secondtd">
							<div style="width: 600px; height: 200px; border: 5px solid rgb(220, 220, 240); margin-left: 20px; margin-top: 30px;">

								<div style="width: 600px;">
									<table class="companyyear" style="margin-top: 20px; margin-left: 30px;">
										<tr>                 <!--tr11111111111111111111111-->
											<td class="companyyeartd">입사일자 :</td>
											<td class="companyyeartd2"><input type="date"
												id="startday" class="pay1" onchange="startday()"></td>
											<td rowspan="3" style="width: 250px; text-align: right;">
												<input type="button" onclick="calculator1()"
												value="평균임금 계산 기간 보기"
												style="width: 115px; height: 100px; border: 0px; background: rgb(46, 117, 182); color: white; font-size: 15px; white-space: normal; font-weight: bold;">
											</td>
										</tr>
										<tr>
											<td class="companyyeartd">퇴직일자 :</td>
											<td class="companyyeartd2"><input type="date"
												id="endday" class="pay1"></td>
										</tr>
										<tr>
											<td class="companyyeartd">재직일수 :</td>
											<td class="companyyeartd2"><input type="text"
												id="workday"
												style="width: 100px; height: 30px; text-align: center; font-weight: bold;"
												readonly>일</td>
										</tr>

									</table>
									<pre>

     ※ 퇴직일자는 마지막으로 근무한 날의 다음날자를 기재.
     ※ 재직일수 중 제외기간이 있는 경우는 [재직일수]를 수정할 것.
</pre>
								</div>

							</div>
							<!--입사일자, 퇴직일자 입력 div 끝-->

							<!--퇴직전 3개월 임금 총액 계산(세전금액) 테이블 시작-->
							<div class="title2">퇴직전 3개월 임금 총액 계산(세전금액)</div>
							<hr class="classHr">

							<table class="secondtbl">
								<tr>
									<th class="secondtblTh" colspan="2" style="width: 300px;">연간
										상여금 총액, 연차 수당</th>
									<th class="secondtblTh">기본급</th>
									<th class="secondtblTh">기타수당</th>
								</tr>

								<tr>
									<td style="width: 150px;" colspan="2" rowspan="3">연간 상여금
										총액 : <input type="text" id="monthpay7" class="secondtbltext">
										원<br>
									<br> 연차 수당 총액 : &emsp;<input type="text" id="monthpay8"
										class="secondtbltext"> 원
									</td>

									<td><input type="text" class="secondtbltext"
										id="monthpay1"> 원</td>
									<td><input type="text" class="secondtbltext"
										id="monthpay4"> 원</td>
								</tr>

								<tr>
									<td><input type="text" class="secondtbltext"
										id="monthpay2"> 원</td>
									<td><input type="text" class="secondtbltext"
										id="monthpay5"> 원</td>
								</tr>

								<tr>
									<td><input type="text" class="secondtbltext"
										id="monthpay3"> 원</td>
									<td><input type="text" class="secondtbltext"
										id="monthpay6"> 원</td>
								</tr>

								<tr>
									<td style="width: 150px;">합계</td>
									<td><span class="sumpay3"></span> 원</td>
									<td><span class="sumpay1"></span> 원</td>
									<td><span class="sumpay2"></span> 원</td>
								</tr>

							</table>

							<!--퇴직전 3개월 임금 총액 계산(세전금액) 테이블 끝-->
							<table class="paytbl" style="margin-left: 20px; margin-top: 30px;">
								<tr>
									<td class="paytd1">1일 평균 임금 :</td>
									<td><input type="text" id="retirementpay1" value="0"
										style="text-align: right;" readonly class="paytd2"> 원</td>
									<td><input type="button" onclick="calculator2()"
										value="평균임금 계산"
										style="height: 35px; width: 110px; background: rgb(46, 117, 182); color: white; border: 0px; font-weight: bold;"></td>
								</tr>

								<tr>
									<td class="paytd1">퇴직금 :</td>
									<td><input type="text" id="retirementpay2" value="0"
										style="text-align: right;" readonly class="paytd2"> 원</td>
									<td><input type="button" onclick="calculator3()"
										value="퇴직금 계산"
										style="height: 35px; width: 110px; background: rgb(46, 117, 182); color: white; border: 0px; font-weight: bold;"></td>
								</tr>
							</table>
							<hr style="margin: 20px;">
							<pre>
   * 1일 통상임금이 1일 평균임금보다 클 경우 1일 통상임금을 기준으로 퇴직금이 계산됩니다.
   
   * 회사내규등에따라 실제 지급액과가 차이가 있을 수 있습니다.
</pre>

							<div style="height: 89px;"></div>
                </div></td>
				</tr>
			</table>
		</div>
		<!--왼쪽 테이블 끝-->
		<!--오른쪽 테이블 시작-->
		<div>
			<table class="firsttbl">
				<tr>
					<td><div class="firsttd">퇴직금 계산 예제</div></td>
				</tr>

				<!--퇴직금 계산예제 첫번째 부분 시작-->
				<tr>

					<td class="bottomline"><div class="secondtd"
							style="background: rgb(249, 249, 249);">
							<pre>

   - 입사일자 : 2014년 10월 2일
   - 퇴사일자 : 2017년 9월 16일
   - 재직일수 : 1,080일
   - 월기본급 : 2,000,000원
   - 월기타수당 : 360,000원
   - 연간 상여금 : 4,000,000원
   - 연차수당 지급기준액 : 60,000원
   - 연차수당은 퇴직 전전년도(2015년)에 발생한 휴가중 퇴직 전년도(2016년)에
     미사용한 휴가 일수분의 합계
   
</pre>
							<!--퇴직금 계산예제 첫번째 부분 끝-->

							<!--가. 퇴직전 3개월간 임금총액(세전금액) 테이블 시작-->

							<div class="title2">가. 퇴직전 3개월간 임금총액(세전금액)</div>
							<hr class="classHr">
							<table class="secondtbl">
								<tr>
									<th class="secondtblTh">기간</th>
									<th class="secondtblTh">기간별일수</th>
									<th class="secondtblTh">기본급</th>
									<th class="secondtblTh">기타수당</th>
								</tr>

								<tr>
									<td>2017.06.16 ~ <br>2017.06.30
									</td>
									<td>15일</td>
									<td>1,000,000원</td>
									<td>180,000원</td>
								</tr>

								<tr>
									<td>2017.07.01 ~ <br>2017.07.31
									</td>
									<td>31일</td>
									<td>2,000,000원</td>
									<td>360,000원</td>
								</tr>

								<tr>
									<td>2017.08.01 ~ <br>2017.08.31
									</td>
									<td>31일</td>
									<td>2,000,000원</td>
									<td>360,000원</td>
								</tr>

								<tr>
									<td>2017.09.01 ~ <br>2017.09.15
									</td>
									<td>15일</td>
									<td>1,000,000원</td>
									<td>180,000원</td>
								</tr>

								<tr>
									<td>합계</td>
									<td>92일</td>
									<td>6,000,000원</td>
									<td>1,080,000원</td>
								</tr>
							</table>
							<!--가. 퇴직전 3개월간 임금총액(세전금액) 테이블 끝-->
							<!--나. 평균임금의 산정 연간상여금 시작-->

							<div class="title2">나. 평균임금의 산정 연간상여금</div>
							<pre>
   - 총액 : 4,000,000 원 
   - 연차수당 : 300,000원 (60,000 원 × 5일)
   - A. 3개월간 임금총액: 7,080,000원 = 6,000,000원+1,080,000원
   - B. 상여금 가산액: 1,000,000원 = 4,000,000원 × (3개월/12개월)
   - C. 연차수당 가산액: 75,000원 = (60,000원 × 5일) × (3개월/12개월)
   - 1일 평균임금 = 퇴직일 이전 3개월간에 지급받은 임금 총액 (A+B+C)/90(일)

</pre>
							<!--나. 평균임금의 산정 연간상여금 끝-->
							<!--다. : 오른쪽 맨 밑 부분-->
							<div class="title2">
								다. 퇴직금 = 1일 평균임금 × 30(일) × (재직일수/365)<br>
								<br> ※ 퇴직소득세는 국세청 홈페이지에서 귀속년도별 퇴직소득<br> 세액 계산 프로그램
								이용하여 계산 가능<br> (www.nts.go.kr → 왼쪽상단 국세정보 → 국세청 프로그램)
								<div style="margin-bottom: 55.5px;"></div>
							</div>
							<br>
							<br>
						</div></td>
				</tr>

			</table>
		</div>
		<!--오른쪽 테이블 끝-->


		<div style="clear: both; text-align: center;">
			<hr>			
		</div>

	</div>

</body>
</html>
<%
	} else {
		response.sendRedirect("erpLogin.jsp");
	}
%>