package erp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class MemoMgr {
	DBConnectionMgr pool;
	
	public MemoMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 메모 목록 들고오도록 하렴
	public Vector<MemoBean> getList(int id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemoBean> mlist = new Vector<MemoBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblmemo where emp_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemoBean mBean = new MemoBean();
				mBean.setEmp_num(rs.getInt(1));
				mBean.setMem_title(rs.getString(2));
				mBean.setMem_content(rs.getString(3));
				mBean.setMem_date(rs.getString(4));
				mlist.add(mBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mlist;
	}
	
	// 메모를 추가하겠도다 훗
	public boolean addMemo(MemoBean mBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into tblmemo(emp_num, mem_title, mem_content, mem_date) values (?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mBean.getEmp_num());
			pstmt.setString(2, mBean.getMem_title().replaceAll(" ", "&nbsp;"));
			pstmt.setString(3, mBean.getMem_content().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
			int cnt = pstmt.executeUpdate();
			if ( cnt == 0 )
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//그 메모 지워주지
	public boolean delMemo(int id, String title, String date) {
		System.out.println("==================");
		System.out.println(id + "  -----   " + title);
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblmemo where emp_num=? and mem_title=? and mem_date=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, title.replaceAll(" ", "&nbsp;"));
			pstmt.setString(3, date);
			int cnt = pstmt.executeUpdate();
			if ( cnt == 0 )
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	public MemoBean getMemo(int id, String title, String content) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemoBean mBean = new MemoBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblmemo where emp_num=? and mem_title=? and mem_date=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				mBean.setEmp_num(rs.getInt(1));
				mBean.setMem_title(rs.getString(2));
				mBean.setMem_content(rs.getString(3));
				mBean.setMem_date(rs.getString(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		System.out.println(id + "  :  " + title+  "  :  " + content);
		return mBean;
	}
	
	public boolean upMemo(int id, String title, String date, String content) {
		System.out.println(id + "  :  " + title + "  : " + date + "  :  " + content);
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblmemo set mem_content=? where emp_num=? and mem_title=? and mem_date=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, id);
			pstmt.setString(3, title);
			pstmt.setString(4, date);
			int cnt = pstmt.executeUpdate();
			if ( cnt == 0 )
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public void AllDelete() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblmemo";
			pstmt = con.prepareStatement(sql);
			int cnt = pstmt.executeUpdate();
			if ( cnt == 0 ) {
				System.out.println("안지워짐");
			} else {
				System.out.println("지워짐");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public static void main(String[] args) {
		new MemoMgr().AllDelete();
	}
}
