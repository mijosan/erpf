package erp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

public class EmployeeMgr {
	DBConnectionMgr pool;
	
	public EmployeeMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//직원정보 삽입
	public void insertEmployee(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into tblemployee(emp_num,emp_name,emp_birth,emp_hireDate,emp_dept,emp_job,emp_bank,emp_account,emp_phone,emp_email) "
					+ "values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);			
			pstmt.setInt(1,Integer.parseInt(req.getParameter("emp_num")));
			pstmt.setString(2, req.getParameter("emp_name"));
			pstmt.setString(3, req.getParameter("emp_birth"));
			pstmt.setString(4, req.getParameter("emp_hireDate"));
			pstmt.setString(5, req.getParameter("emp_dept"));
			pstmt.setString(6, req.getParameter("emp_job"));
			pstmt.setString(7, req.getParameter("emp_bank"));
			pstmt.setString(8, req.getParameter("emp_account"));
			pstmt.setString(9, req.getParameter("emp_phone"));
			pstmt.setString(10, req.getParameter("emp_email"));
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}	
	}
	
	//직원정보 가져오기
	public Vector<EmployeeBean> getAllEmployee(int start, int end){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<EmployeeBean> vlist = new Vector<EmployeeBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM tblemployee limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				EmployeeBean bean = new EmployeeBean();
				bean.setEmp_num(rs.getInt("emp_num"));
				bean.setEmp_name(rs.getString("emp_name"));
				bean.setEmp_birth(rs.getString("emp_birth"));
				bean.setEmp_dept(rs.getString("emp_dept"));
				bean.setEmp_job(rs.getString("emp_job"));
				bean.setEmp_hireDate(rs.getString("emp_hireDate"));
				bean.setEmp_bank(rs.getString("emp_bank"));
				bean.setEmp_account(rs.getString("emp_account"));
				bean.setEmp_email(rs.getString("emp_email"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public int getNextEnum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int max = 0;
		try {
			con = pool.getConnection();
			sql = "select max(emp_num)+1 from tblemployee";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) max =  rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return max;
	}
	
	public EmployeeBean getEmployee(int emp_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		EmployeeBean bean = new EmployeeBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblemployee where emp_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, emp_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setEmp_num(rs.getInt("emp_num"));
				bean.setEmp_name(rs.getString("emp_name"));
				bean.setEmp_birth(rs.getString("emp_birth"));
				bean.setEmp_dept(rs.getString("emp_dept"));
				bean.setEmp_job(rs.getString("emp_job"));
				bean.setEmp_hireDate(rs.getString("emp_hireDate"));
				bean.setEmp_bank(rs.getString("emp_bank"));
				bean.setEmp_account(rs.getString("emp_account"));
				bean.setEmp_email(rs.getString("emp_email"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	public void updateEmployee(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblemployee set emp_name=?, emp_birth=?, emp_hireDate=?, emp_dept=?, emp_job=?, emp_phone=?, emp_email=?, emp_bank=?, emp_account=? where emp_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("emp_name"));
			pstmt.setString(2, req.getParameter("emp_birth"));
			pstmt.setString(3, req.getParameter("emp_hireDate"));
			pstmt.setString(4, req.getParameter("emp_dept"));
			pstmt.setString(5, req.getParameter("emp_job"));
			pstmt.setString(6, req.getParameter("emp_phone"));
			pstmt.setString(7, req.getParameter("emp_email"));
			pstmt.setString(8, req.getParameter("emp_bank"));
			pstmt.setString(9, req.getParameter("emp_account"));
			pstmt.setInt(10,Integer.parseInt(req.getParameter("emp_num")));
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public int getTotalCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt = 0;
		try {
			con = pool.getConnection();
			sql = "select count(emp_num) from tblemployee";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) cnt = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return cnt;
	}
	//삭제
	public void deleteEmployee(int arr[]) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			int size = arr.length;
			con = pool.getConnection();
			for(int i=0; i<size; i++) {
			sql = "delete from tblemployee where emp_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, arr[i]);
			pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//회원이름
	public Vector<String> getEmployeeName() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> vlist = new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "select emp_name from tblemployee group by emp_name";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				String name = rs.getString(1);
				vlist.addElement(name);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public EmployeeBean getEmployee(String name, String dept, String job) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		EmployeeBean bean = new EmployeeBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblemployee where emp_name=? and emp_dept=? and emp_job=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, dept);
			pstmt.setString(3, job);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setEmp_num(rs.getInt("emp_num"));
				bean.setEmp_name(rs.getString("emp_name"));
				bean.setEmp_birth(rs.getString("emp_birth"));
				bean.setEmp_dept(rs.getString("emp_dept"));
				bean.setEmp_job(rs.getString("emp_job"));
				bean.setEmp_hireDate(rs.getString("emp_hireDate"));
				bean.setEmp_bank(rs.getString("emp_bank"));
				bean.setEmp_account(rs.getString("emp_account"));
				bean.setEmp_email(rs.getString("emp_email"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
}
