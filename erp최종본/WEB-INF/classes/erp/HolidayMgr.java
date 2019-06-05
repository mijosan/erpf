package erp;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import erp.UtilMgr2;


public class HolidayMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/WebContent/erp/fileupload/";
	public static final String ENCTYPE = "EUC-KR";
	public static final int MAXSIZE = 5*1024*1024;
	
	public HolidayMgr() {
		pool = DBConnectionMgr.getInstance();
		
	}
	//출근 등록
	public boolean insertCommuting(int emp_num,String emp_dept,String emp_name,String commuting) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select max(holi_idx) from tblholiday";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int cnt=0;
			int ref = 1;
			if(rs.next()) ref = rs.getInt(1) + 1;		
						
			sql = "insert into tblholiday values(?, now(), ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, ref);
			pstmt.setInt(2, emp_num);
			pstmt.setString(3, emp_dept);
			pstmt.setString(4, emp_name);
			pstmt.setString(5, commuting);
			pstmt.setString(6, "미승인");
	
			cnt = pstmt.executeUpdate();
			if(cnt>=1) flag = true;
			return flag;
		}
		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	//퇴근 등록
	
	
	//페이징
	//젤높은값 가져오기
	public int holidayMax() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int max = 0;
		try {
			con = pool.getConnection();

			sql = "select count(holi_idx) from tblholiday";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			max = rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return max;
	}
	public int holidayMax2(String emp_dept) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int max = 0;
		try {
			con = pool.getConnection();

			sql = "select count(holi_idx) from tblholiday where emp_dept=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, emp_dept);
			rs = pstmt.executeQuery();
			rs.next();
			max = rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return max;
	}

	
	//Board Total List Number
	public int getTotalCount(String holi_content, String holi_state) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalRecord = 0;
		try {
			con = pool.getConnection();
			if(holi_content.equals("") && holi_state.equals("")){ //검색을 하지 않았을때
				sql = "select count(*) from tblholiday"; 
				pstmt = con.prepareStatement(sql);
			}else if(!holi_content.equals("") && holi_state.isEmpty()){//내용만 검색을 했을때
	
				sql = "select count(*) from tblholiday where holi_content=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,holi_content);
			}else if(!holi_state.equals("") && holi_content.isEmpty()){//상태만 검색을 했을때
				sql = "select count(*) from tblholiday where holi_state=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,holi_state);

			}else {//둘다검색했을때
				
				sql = "select count(*) from tblholiday where holi_content and holi_state=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,holi_content);
				pstmt.setString(2,holi_state);
			}
			/*if(keyWord.equals("null")||keyWord.equals("")){
				sql = "select count(*) from tblAnonyBoard";
				pstmt = con.prepareStatement(sql);
			}else {
				sql = "select count(*) from tblAnonyBoard where " + keyField +" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}*/
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalRecord = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalRecord;
	}
	
	//Board Total List Number
		public int getTotalCount2(String holi_content, String holi_state, String emp_dept) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalRecord = 0;
			try {
				con = pool.getConnection();
				if(holi_content.equals("") && holi_state.equals("")){ //검색을 하지 않았을때
					System.out.println("요기");
					sql = "select count(*) from tblholiday where emp_dept=?"; 
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1,emp_dept);
				}else if(!holi_content.equals("") && holi_state.isEmpty()){//내용만 검색을 했을때
		
					sql = "select count(*) from tblholiday where emp_dept=? and holi_content=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1,emp_dept);
					pstmt.setString(2,holi_content);
				}else if(!holi_state.equals("") && holi_content.isEmpty()){//상태만 검색을 했을때
					sql = "select count(*) from tblholiday where emp_dept=? and holi_state=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1,emp_dept);
					pstmt.setString(2,holi_state);

				}else {//둘다검색했을때
					
					sql = "select count(*) from tblholiday where emp_dept=? and holi_content and holi_state=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1,emp_dept);
					pstmt.setString(2,holi_content);
					pstmt.setString(3,holi_state);
				}
				/*if(keyWord.equals("null")||keyWord.equals("")){
					sql = "select count(*) from tblAnonyBoard";
					pstmt = con.prepareStatement(sql);
				}else {
					sql = "select count(*) from tblAnonyBoard where " + keyField +" like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
				}*/
				rs = pstmt.executeQuery();
				if(rs.next()) {
					totalRecord = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalRecord;
		}
	
	
	

	
	
	//사장이 불러옴
	public Vector<HolidayBean> getAllHoliday1(int start, int end, String holi_content, String holi_state) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<HolidayBean> vlist = new Vector<HolidayBean>();
		try {
			con = pool.getConnection();
		
			if(holi_content.equals("") && holi_state.equals("")){ //검색을 하지 않았을때
				sql = "select * from tblholiday order by holi_idx desc limit ?, ?"; 
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}else if(!holi_content.equals("") && holi_state.isEmpty()){//내용만 검색을 했을때
			
				sql = "select * from tblholiday where holi_content=? order by holi_idx desc limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,holi_content);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}else if(!holi_state.equals("") && holi_content.isEmpty()){//상태만 검색을 했을때
				sql = "select * from tblholiday where holi_state=? order by holi_idx desc limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,holi_state);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}else {//둘다검색했을때
				
				sql = "select * from tblholiday where holi_content=? and holi_state=? order by holi_idx desc limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,holi_content);
				pstmt.setString(2,holi_state);
				pstmt.setInt(3, start);
				pstmt.setInt(4, end);
			}
			rs = pstmt.executeQuery();
			while(rs.next()){
				HolidayBean bean = new HolidayBean();
				
				bean.setHoli_idx(rs.getInt(1));
				bean.setHoli_date(rs.getString(2));
				bean.setEmp_num(rs.getInt(3));
				bean.setEmp_dept(rs.getString(4));	
				bean.setEmp_name(rs.getString(5));
				bean.setHoli_content(rs.getString(6));
				bean.setHoli_state(rs.getString(7));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
			
	//부서별 근퇴 
	public Vector<HolidayBean> getAllHoliday2(int start, int end, String holi_content, String holi_state,String emp_dept) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<HolidayBean> vlist = new Vector<HolidayBean>();
		try {
			con = pool.getConnection();
		
			if(holi_content.equals("") && holi_state.equals("")){ //검색을 하지 않았을때
				sql = "select * from tblholiday where emp_dept=? order by holi_idx desc limit ?, ?"; 
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, emp_dept);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}else if(!holi_content.equals("") && holi_state.isEmpty()){//내용만 검색을 했을때
			
				sql = "select * from tblholiday where emp_dept=? and holi_content=? order by holi_idx desc limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, emp_dept);
				pstmt.setString(2,holi_content);
				pstmt.setInt(3, start);
				pstmt.setInt(4, end);
			}else if(!holi_state.equals("") && holi_content.isEmpty()){//상태만 검색을 했을때
				sql = "select * from tblholiday where emp_dept=? and holi_state=? order by holi_idx desc limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, emp_dept);
				pstmt.setString(2,holi_state);
				pstmt.setInt(3, start);
				pstmt.setInt(4, end);
			}else {//둘다검색했을때
				
				sql = "select * from tblholiday where emp_dept=? and holi_content=? and holi_state=? order by holi_idx desc limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, emp_dept);
				pstmt.setString(2,holi_content);
				pstmt.setString(3,holi_state);
				pstmt.setInt(4, start);
				pstmt.setInt(5, end);
			}
			rs = pstmt.executeQuery();
			while(rs.next()){
				HolidayBean bean = new HolidayBean();
				
				bean.setHoli_idx(rs.getInt(1));
				bean.setHoli_date(rs.getString(2));
				bean.setEmp_num(rs.getInt(3));
				bean.setEmp_dept(rs.getString(4));	
				bean.setEmp_name(rs.getString(5));
				bean.setHoli_content(rs.getString(6));
				bean.setHoli_state(rs.getString(7));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
			
	
	//공지사항 특정 리스트 가져오기
		public NoticeBean getNotice(int ntc_idx) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			NoticeBean noticeBean = new NoticeBean();
			try {
				con = pool.getConnection();
				sql = "select * from tblnotice where ntc_idx=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ntc_idx);
				rs = pstmt.executeQuery();
				
				rs.next();
				noticeBean.setNtc_idx(rs.getInt(1));
				noticeBean.setNtc_title(rs.getString(2));
				noticeBean.setNtc_name(rs.getString(3));
				noticeBean.setNtc_date(rs.getString(4));	
				noticeBean.setNtc_hits(rs.getInt(5));
				noticeBean.setNtc_content(rs.getString(6));
				noticeBean.setNtc_filename(rs.getString(7));
				noticeBean.setNtc_filesize(rs.getInt(8));
				noticeBean.setEmp_num(rs.getInt(9));
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return noticeBean;
		}
	
	//근퇴 등록
	public boolean insertHoliday(String holiday_date,int emp_num,String emp_dept,String emp_name,String holiday_content) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "select max(holi_idx) from tblholiday";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int ref = 1;
			if(rs.next()) ref = rs.getInt(1) + 1;		
						
			sql = "insert into tblholiday values(?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, ref);
			pstmt.setString(2, holiday_date);
			pstmt.setInt(3, emp_num);
			pstmt.setString(4, emp_dept);
			pstmt.setString(5, emp_name);
			pstmt.setString(6, holiday_content);
			pstmt.setString(7, "미승인");
	
			pstmt.executeUpdate();
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	//결제 버튼
	public boolean stateUpdate(int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblholiday set holi_state='승인' where holi_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			int cnt = pstmt.executeUpdate();
			if(cnt>=1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//글 수정
	
	public boolean setNotice(int ntc_idx, String ntc_title, String ntc_content) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblanonyboard set any_title=?, any_content=? where any_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ntc_title);
			pstmt.setString(2, ntc_content);
			pstmt.setInt(3, ntc_idx);
			int cnt = pstmt.executeUpdate();
			if(cnt>=1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//공지사항 삭제
	public boolean deleteNotice(int ntc_idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblnotice where ntc_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ntc_idx);
			int cnt = pstmt.executeUpdate();
			if(cnt>=1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
		
	}
	
	//////////////////댓글 Mgr/////////////////////////
	
	//댓글 가져오기
			public Vector<NCommentBean> getNComment(int ntc_idx) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				Vector<NCommentBean> vlist = new Vector<NCommentBean>();
				try {
					con = pool.getConnection();
					sql = "select * from tblncomment where ntc_idx=? order by nc_num asc";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, ntc_idx);
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						NCommentBean ncommentBean = new NCommentBean();
						ncommentBean.setNc_num(rs.getInt(1));
						ncommentBean.setNtc_idx(rs.getInt(2));
						ncommentBean.setNc_name(rs.getString(3));
						ncommentBean.setNc_comment(rs.getString(4));	
						ncommentBean.setNc_date(rs.getString(5));
						ncommentBean.setEmp_num(rs.getInt(6));
						vlist.addElement(ncommentBean);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return vlist;
			}
			//댓글 삭제
			public boolean deleteNComment(int nc_num) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				boolean flag = false;
				try {
					con = pool.getConnection();
					sql = "delete from tblncomment where nc_num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, nc_num);
					int cnt = pstmt.executeUpdate();
					if(cnt>=1) flag = true;
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
				return flag;
				
			}
			
			//글삭제되면 해당글 모든 댓글 삭제
			public void deleteAllNComment(int ntc_idx) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;

				try {
					con = pool.getConnection();
					sql = "delete from tblncomment where ntc_idx=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, ntc_idx);
					pstmt.executeUpdate();

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
			}
			
			//댓글 갯수
			public int getNCommentCount(int ntc_idx) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				int count = 0;
				try {
					con = pool.getConnection();
					sql = "select count(*) from tblncomment where ntc_idx=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, ntc_idx);
					rs = pstmt.executeQuery();
					if(rs.next())
						count = rs.getInt(1);
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return count;
			}
			
			//댓글 작성
			public boolean setNComment(int ntc_idx, String nc_name, String nc_comment, int emp_num) {                                        
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				int count = 0;
				boolean flag = false;
				try {
					con = pool.getConnection();
					sql = "select max(nc_num) from tblncomment";
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					rs.next();
					int nc_num = rs.getInt(1)+1;
					
					sql = "insert into tblncomment values(?,?,?,?,now(),?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, nc_num);
					pstmt.setInt(2, ntc_idx);
					pstmt.setString(3, nc_name);
					pstmt.setString(4, nc_comment);
					pstmt.setInt(5, emp_num);
					int cnt = pstmt.executeUpdate();
					if(cnt>=1) flag = true;
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return flag;
			}
}
