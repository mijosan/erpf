insert into tblholiday values((select max(holi_idx) from tblholiday)+1,'2018-09-03 ~ 2018-09-07',2,'인사부','이정환','예비군','미승인')

select * from tblholiday where emp_dept='인사부' order by holi_idx asc