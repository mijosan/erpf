package erp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

public class certifiMgr {
	DBConnectionMgr pool;
	
	public certifiMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//증명서 신청
	public void insertCertificate(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into tblcertificate "
					+ "values(?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("cer_num"));
			pstmt.setString(2, req.getParameter("cer_name"));
			pstmt.setString(3, req.getParameter("cer_dept"));
			pstmt.setString(4, req.getParameter("cer_job"));
			pstmt.setString(5, req.getParameter("cer_task"));
			pstmt.setString(6, req.getParameter("cer_use"));
			pstmt.setString(7, req.getParameter("cer_date"));
			pstmt.setString(8, "신청완료");
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public int getTotalCountC() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from tblcertificate";
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
	public Vector<certifiBean> getAllCertificate(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<certifiBean> vlist = new Vector<certifiBean>();
		
		try {
			con = pool.getConnection();
			sql = "select * from tblcertificate";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				certifiBean bean = new certifiBean();
				bean.setCer_num(rs.getInt(1));
				bean.setCer_name(rs.getString("cer_name"));
				bean.setCer_dept(rs.getString("cer_dept"));
				bean.setCer_job(rs.getString("cer_job"));
				bean.setCer_date(rs.getString("cer_date"));
				bean.setCer_task(rs.getString("cer_task"));
				bean.setCer_use(rs.getString("cer_use"));
				bean.setCer_state(rs.getString("cer_state"));
				
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
		public void stateUpdate(int cer_num, String cer_state) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "UPDATE tblcertificate SET cer_state = ? WHERE cer_num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, cer_state);
				pstmt.setInt(2, cer_num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		//해당 신청 내역 들고오기 -> 양식에 입력하기 위함
		public certifiBean getCert(int cer_num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			certifiBean bean = new certifiBean();
			try {
				con = pool.getConnection();
				sql = "select * from tblcertificate where cer_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cer_num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setCer_num(rs.getInt("cer_num"));
					bean.setCer_name(rs.getString("cer_name"));
					bean.setCer_dept(rs.getString("cer_dept"));
					bean.setCer_job(rs.getString("cer_job"));
					bean.setCer_date(rs.getString("cer_date"));
					bean.setCer_task(rs.getString("cer_task"));
					bean.setCer_use(rs.getString("cer_use"));
					bean.setCer_state(rs.getString("cer_state"));					
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
}