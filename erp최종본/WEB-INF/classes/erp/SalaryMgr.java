package erp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

public class SalaryMgr {
	private DBConnectionMgr pool;
	public SalaryMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//급여 삽입.
	public void insertSalary(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into tblsalary "
					+ "values(?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("salary_num"));
			pstmt.setString(2, req.getParameter("salary_name"));
			pstmt.setString(3, req.getParameter("salary_dept"));
			pstmt.setString(4, req.getParameter("salary_empname"));
			pstmt.setString(5, req.getParameter("salary_job"));
			pstmt.setString(6, req.getParameter("salary_date"));
			pstmt.setString(7, req.getParameter("salary_content"));
			pstmt.setString(8, req.getParameter("salary_state"));
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//연봉데이터 다가져오기
	public Vector<SalaryBean> getAllSalary(int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<SalaryBean> vlist = new Vector<SalaryBean>();		
		try {
			con = pool.getConnection();
			sql = "select * from tblsalary limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				SalaryBean bean = new SalaryBean();
				bean.setSalary_num(rs.getString("salary_num"));
				bean.setSalary_name(rs.getString("salary_name"));
				bean.setSalary_dept(rs.getString("salary_dept"));
				bean.setSalary_empname(rs.getString("salary_empname"));
				bean.setSalary_job(rs.getString("salary_job"));
				bean.setSalary_date(rs.getString("salary_date"));
				bean.setSalary_content(rs.getString("salary_content"));
				bean.setSalary_state(rs.getString("salary_state"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//관리자 급여 상태 업데이트
	public void stateUpdate(String salary_num, String salary_state) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE tblsalary SET salary_state = ? WHERE salary_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, salary_state);
			pstmt.setString(2, salary_num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	//전체 급여 수 가져오기 (페이징 처리를 위함)
	public int getAllCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from tblsalary";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) cnt=rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return cnt;
	}
}
