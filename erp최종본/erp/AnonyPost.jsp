<%@page import="erp.EmployeeBean"%>
<%@ page contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
////////////////////////////////////////////
if (session.getAttribute("idKey") != null) {
int id = (Integer) session.getAttribute("idKey");
/////////////////////////////////////////////
	EmployeeBean eBean = (EmployeeBean)session.getAttribute("employeeBean");
%>
<html>
    <head>
        <style>
            * {
                font-family: 'Dotum','Arial','','Arial','Apple SD Gothic Neo','Gulim';
                font-size: 12px;
            }
            .full {
                width: 600px;
                height: 420px;
                overflow: hidden;
            }
            .writer {
                margin: 10px;
                text-align: right;
            }
            .gray {
                width: 580px;
                margin: 0px 10px;
                background-color: rgb(245,245,245);
                border-collapse: collapse;
                border-spacing: 30px;
            }
            table.gray tr:hover {
                background-color: rgb(225,225,225);
            }
            table.gray td {
                padding-left: 10px;
                height: 30px;
            }
            .word {
                width: 580px;
                margin-top: 10px;
                margin-left: 10px;
                height: 250px;
                height: 250px;
            }
            .btn {
                background-color: rgb(46,117,182);
                border: 2px solid rgb(46,117,182);
                color: white;
            }
            .under {
                margin-top: 4px;
                margin-left: 10px;
                margin-right: 10px;
            }
            #save {
                height: 23px;
                margin-right: 10px;
            }
            .alarm {
                vertical-align: bottom;
                width: 20px;
                height: 20px;
            }
            .i_title {
                width: 470px;
                color: rgb(0,90,129);
            }
            .b_ac {
                border-radius: 4px;
                display: inline-block;
                background-color: darkorange;
                color: white;
                width: 70px;
                height: 18px;
                padding-top: 2px;
                text-align: center;
            }
            .b_pwd {
                border-radius: 4px;
                display: inline-block;
                width: 92px;
                height: 18px;
                padding-top: 2px;
                text-align: center;
                
            }
            .dkv {
                color: dimgrey;
            }
            .enl {
                color: rgb(0,90,129);
            }
        </style>
    </head>
    <body>
        <div class="full">
        <form action="AnonyPostProc.jsp" method="post" enctype="multipart/form-data">
            <div class="writer">작성자 : <%=eBean.getEmp_name() %></div>
           
            <table class="gray">
                <tr>
                    <td class="dkv" width="70">익명여부</td>
                    <td class="enl">
                        <input type="checkbox" name="anony" value="ck">
                    </td>
                </tr>
                <tr>
                    <td class="dkv">제목</td>
                    <td class="enl">
                        <input type="text" class="i_title" name="subject">
                    </td>
                </tr>
                <tr>
                    <td class="dkv">첨부</td>
                    <td class="enl">
                        <input type="file" name="filename" size="50" maxlength="50">
                    </td>
                </tr>
            </table>
            <textarea class="word" name="content"></textarea>
            
            
            <div class="under">
                <input type="submit" value="저장" class="btn" id="save"/>
            </div>
            </form>
        </div>
            
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            $(document).ready(function() {
                $(".b_ac").click(function(){
                    
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