package erp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class CalendarMgr {
	DBConnectionMgr pool;
	public CalendarMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public int getCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from tblcalendar";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			cnt = rs.getInt(1)+1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return cnt;
	}
	public boolean insertCalendar(String calendar_title,String calendar_start_date, String calendar_end_date) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into tblcalendar(calendar_id,calendar_title,calendar_start_date,calendar_end_date) values(?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, getCount());
			pstmt.setString(2, calendar_title);
			pstmt.setString(3, calendar_start_date);
			pstmt.setString(4, calendar_end_date);
			int cnt = pstmt.executeUpdate();
			if(cnt!=0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public Vector<CalendarBean> getCalendar(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CalendarBean> vlist = new Vector<CalendarBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblcalendar";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CalendarBean bean = new CalendarBean();
				bean.setId(rs.getInt(1));
				bean.setTitle(rs.getString(2));
				bean.setStart(rs.getString(3));
				bean.setEnd(rs.getString(4));
				vlist.addElement(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
}
