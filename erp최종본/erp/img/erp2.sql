insert into tblholiday values((select max(holi_idx) from tblholiday)+1,'2018-09-03 ~ 2018-09-07',2,'�λ��','����ȯ','����','�̽���')

select * from tblholiday where emp_dept='�λ��' order by holi_idx asc