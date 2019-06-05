package erp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class LoginMgr {
	
	private DBConnectionMgr pool;
	
	public LoginMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean loginCheck(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from tblemployee where emp_num=? and emp_birth=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(id));
			pstmt.setString(2,pwd);
			rs = pstmt.executeQuery();
			if (rs.next()) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	public EmployeeBean getInfo(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		EmployeeBean employeeBean = new EmployeeBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblemployee where emp_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				employeeBean.setEmp_num(rs.getInt(1));
				employeeBean.setEmp_name(rs.getString(2));
				employeeBean.setEmp_birth(rs.getString(3));
				employeeBean.setEmp_dept(rs.getString(4));
				employeeBean.setEmp_hireDate(rs.getString(5));
				employeeBean.setEmp_account(rs.getString(6));
				employeeBean.setEmp_bank(rs.getString(7));
				employeeBean.setEmp_job(rs.getString(8));
				employeeBean.setEmp_email(rs.getString(9));
				employeeBean.setEmp_phone(rs.getString(10));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return employeeBean;
	}
	
	public static void main(String[] args) {
		new LoginMgr();
	}
	
}
