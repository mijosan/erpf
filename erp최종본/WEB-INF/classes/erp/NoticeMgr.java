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

public class NoticeMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "/tomcat/webapps/ROOT/erp/fileupload";
	public static final String ENCTYPE = "EUC-KR";
	public static final int MAXSIZE = 5*1024*1024;
	
	public NoticeMgr() {
		pool = DBConnectionMgr.getInstance();
		
	}
	
	//공지사항 모든 리스트 가져오기
	public Vector<NoticeBean> getAllNotice() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<NoticeBean> vlist = new Vector<NoticeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblnotice order by ntc_idx desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeBean bean = new NoticeBean();
				bean.setNtc_idx(rs.getInt(1));
				bean.setNtc_title(rs.getString(2));
				bean.setNtc_name(rs.getString(3));
				bean.setNtc_date(rs.getString(4));	
				bean.setNtc_hits(rs.getInt(5));
				bean.setNtc_content(rs.getString(6));
				bean.setNtc_filename(rs.getString(7));
				bean.setNtc_filesize(rs.getInt(8));
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
	
	//공지사항 작성
	public boolean insertNotice(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		HttpSession session = req.getSession();
		EmployeeBean employeeBean = (EmployeeBean)session.getAttribute("employeeBean");
		
		try {
			con = pool.getConnection();
			sql = "select max(ntc_idx) from tblnotice";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int ref = 1;
			if(rs.next()) ref = rs.getInt(1) + 1;
			//////////////////////////// FileUpload 시작 ////////////////////////////
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

			String filename = null;
			int filesize = 0;
			if(multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			//////////////////////////// FileUpload 끝  ////////////////////////////
						
			sql = "insert into tblnotice values(?, ?, ?, now(), ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, ref);
			pstmt.setString(2, multi.getParameter("subject"));
			pstmt.setString(3, employeeBean.getEmp_name());
			pstmt.setInt(4, 0);
			pstmt.setString(5, multi.getParameter("content"));
			pstmt.setString(6, filename);
			pstmt.setInt(7, filesize);
			pstmt.setInt(8, employeeBean.getEmp_num());
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
	
	//조회수 증가
	public void notice_upHits(int ntc_idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblnotice set ntc_hits=ntc_hits+1 where ntc_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ntc_idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//글 수정
	
	public boolean setNotice(int ntc_idx, String ntc_title, String ntc_content) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblnotice set ntc_title=?, ntc_content=? where ntc_idx=?";
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
	public static void main(String[] args) {
		new NoticeMgr();
	}
	
}
