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



public class JobNoticeMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "/tomcat/webapps/ROOT/erp/fileupload";
	public static final String ENCTYPE = "EUC-KR";
	public static final int MAXSIZE = 5*1024*1024;
	
	public JobNoticeMgr() {
		pool = DBConnectionMgr.getInstance();
		
	}
	
	//공지사항 모든 리스트 가져오기
	public Vector<JobNoticeBean> getAllNotice(String emp_dept) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<JobNoticeBean> vlist = new Vector<JobNoticeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tbljobnotice where emp_dept=? order by field(emp_job,'부장','대리','사원'), jtc_idx desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, emp_dept);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				JobNoticeBean bean = new JobNoticeBean();
				bean.setJtc_idx(rs.getInt(1));
				bean.setJtc_title(rs.getString(2));
				bean.setJtc_name(rs.getString(3));
				bean.setJtc_date(rs.getString(4));	
				bean.setJtc_hits(rs.getInt(5));
				bean.setJtc_content(rs.getString(6));
				bean.setJtc_filename(rs.getString(7));
				bean.setJtc_filesize(rs.getInt(8));
				bean.setEmp_dept(rs.getString(9));
				bean.setEmp_job(rs.getString(10));
				vlist.addElement(bean);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
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
				sql = "select max(jtc_idx) from tbljobnotice";
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
							
				sql = "insert into tbljobnotice values(?, ?, ?, now(), ?, ?, ?, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, ref);
				pstmt.setString(2, multi.getParameter("subject"));
				pstmt.setString(3, employeeBean.getEmp_name());
				pstmt.setInt(4, 0);
				pstmt.setString(5, multi.getParameter("content"));
				pstmt.setString(6, filename);
				pstmt.setInt(7, filesize);
				pstmt.setString(8, employeeBean.getEmp_dept());
				pstmt.setString(9, employeeBean.getEmp_job());
				pstmt.setInt(10, employeeBean.getEmp_num());
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
	
	//공지사항 특정 리스트 가져오기
		public JobNoticeBean getNotice(int jtc_idx) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			JobNoticeBean jobnoticeBean = new JobNoticeBean();
			try {
				con = pool.getConnection();
				sql = "select * from tbljobnotice where jtc_idx=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, jtc_idx);
				rs = pstmt.executeQuery();
				
				rs.next();
				jobnoticeBean.setJtc_idx(rs.getInt(1));
				jobnoticeBean.setJtc_title(rs.getString(2));
				jobnoticeBean.setJtc_name(rs.getString(3));
				jobnoticeBean.setJtc_date(rs.getString(4));	
				jobnoticeBean.setJtc_hits(rs.getInt(5));
				jobnoticeBean.setJtc_content(rs.getString(6));
				jobnoticeBean.setJtc_filename(rs.getString(7));
				jobnoticeBean.setJtc_filesize(rs.getInt(8));
				jobnoticeBean.setEmp_num(rs.getInt(11));
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return jobnoticeBean;
		}
	
	
	
	//조회수 증가
	public void notice_upHits(int jtc_idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tbljobnotice set jtc_hits=jtc_hits+1 where jtc_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, jtc_idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//글 수정
	
	public boolean setNotice(int jtc_idx, String jtc_title, String jtc_content) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tbljobnotice set jtc_title=?, jtc_content=? where jtc_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, jtc_title);
			pstmt.setString(2, jtc_content);
			pstmt.setInt(3, jtc_idx);
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
	public boolean deleteNotice(int jtc_idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tbljobnotice where jtc_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, jtc_idx);
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
			public Vector<JNCommentBean> getNComment(int jtc_idx) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				Vector<JNCommentBean> vlist = new Vector<JNCommentBean>();
				try {
					con = pool.getConnection();
					sql = "select * from tbljncomment where jtc_idx=? order by jnc_num asc";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, jtc_idx);
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						JNCommentBean jncommentBean = new JNCommentBean();
						jncommentBean.setJnc_num(rs.getInt(1));
						jncommentBean.setJtc_idx(rs.getInt(2));
						jncommentBean.setJnc_name(rs.getString(3));
						jncommentBean.setJnc_comment(rs.getString(4));	
						jncommentBean.setJnc_date(rs.getString(5));
						jncommentBean.setEmp_num(rs.getInt(6));
						vlist.addElement(jncommentBean);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return vlist;
			}
			//댓글 삭제
			public boolean deleteNComment(int jnc_num) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				boolean flag = false;
				try {
					con = pool.getConnection();
					sql = "delete from tbljncomment where jnc_num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, jnc_num);
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
			public void deleteAllNComment(int jtc_idx) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;

				try {
					con = pool.getConnection();
					sql = "delete from tbljncomment where jtc_idx=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, jtc_idx);
					pstmt.executeUpdate();

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
			}
			
			//댓글 갯수
			public int getNCommentCount(int jtc_idx) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				int count = 0;
				try {
					con = pool.getConnection();
					sql = "select count(*) from tbljncomment where jtc_idx=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, jtc_idx);
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
			public boolean setNComment(int jtc_idx, String jnc_name, String jnc_comment, int emp_num) {                                        
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				int count = 0;
				boolean flag = false;
				try {
					con = pool.getConnection();
					sql = "select max(jnc_num) from tbljncomment";
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					rs.next();
					int jnc_num = rs.getInt(1)+1;
					
					sql = "insert into tbljncomment values(?,?,?,?,now(),?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, jnc_num);
					pstmt.setInt(2, jtc_idx);
					pstmt.setString(3, jnc_name);
					pstmt.setString(4, jnc_comment);
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
		new JobNoticeMgr();
	}
	
}
