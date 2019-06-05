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



public class AnonyBoardMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "/home/hosting_users/erpf/tomcat/webapps/ROOT/erp/fileupload/";

	public static final String ENCTYPE = "EUC-KR";
	public static final int MAXSIZE = 5*1024*1024;
	
	public AnonyBoardMgr() {
		pool = DBConnectionMgr.getInstance();
		File dir = new File(SAVEFOLDER);
		if(!dir.exists()) {
			dir.mkdirs();
		}
	}
	
			public Vector<AnonyBoardBean> getBoardList(String keyField, String keyWord, int start, int end) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				Vector<AnonyBoardBean> vlist = new Vector<AnonyBoardBean>();
				try {
					con = pool.getConnection();
					if(keyWord.equals("null")||keyWord.equals("")){ //검색을 하지 않았을때
						sql = "select * from tblanonyboard order by any_idx desc limit ?, ?"; //최신 글중에서 pos를 오름차순으로 정렬함
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, end);
					}else {//검색을 했을때
						sql = "select * from tblanonyboard where "+keyField+" like ? limit ?, ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, "%" + keyWord + "%");
						pstmt.setInt(2, start);
						pstmt.setInt(3, end);
					}
					rs = pstmt.executeQuery();
					while(rs.next()){
						AnonyBoardBean bean = new AnonyBoardBean();
						
						bean.setAny_idx(rs.getInt(1));
						bean.setAny_title(rs.getString(2));
						bean.setAny_name(rs.getString(3));
						bean.setAny_date(rs.getString(4));	
						bean.setAny_hits(rs.getInt(5));
						bean.setAny_content(rs.getString(6));
						bean.setAny_filename(rs.getString(7));
						bean.setAny_filesize(rs.getInt(8));
						vlist.addElement(bean);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return vlist;
			}
	//Board Total List Number
		public int getTotalCount(String keyField, String keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalRecord = 0;
			try {
				con = pool.getConnection();
				if(keyWord.equals("null")||keyWord.equals("")){
					sql = "select count(*) from tblanonyboard";
					pstmt = con.prepareStatement(sql);
				}else {
					sql = "select count(*) from tblanonyboard where " + keyField +" like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
				}
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

	//공지사항 모든 리스트 가져오기
	public Vector<AnonyBoardBean> getAllNotice() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		Vector<AnonyBoardBean> vlist = new Vector<AnonyBoardBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblanonyboard order by any_idx desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AnonyBoardBean bean = new AnonyBoardBean();
				bean.setAny_idx(rs.getInt(1));
				bean.setAny_title(rs.getString(2));
				bean.setAny_name(rs.getString(3));
				bean.setAny_date(rs.getString(4));	
				bean.setAny_hits(rs.getInt(5));
				bean.setAny_content(rs.getString(6));
				bean.setAny_filename(rs.getString(7));
				bean.setAny_filesize(rs.getInt(8));
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
		public AnonyBoardBean getAnonyBoard(int any_idx) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			AnonyBoardBean noticeBean = new AnonyBoardBean();
			try {
				con = pool.getConnection();
				sql = "select * from tblanonyboard where any_idx=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, any_idx);
				rs = pstmt.executeQuery();
				
				rs.next();
				noticeBean.setAny_idx(rs.getInt(1));
				noticeBean.setAny_title(rs.getString(2));
				noticeBean.setAny_name(rs.getString(3));
				noticeBean.setAny_date(rs.getString(4));	
				noticeBean.setAny_hits(rs.getInt(5));
				noticeBean.setAny_content(rs.getString(6));
				noticeBean.setAny_filename(rs.getString(7));
				noticeBean.setAny_filesize(rs.getInt(8));
				noticeBean.setEmp_num(rs.getInt(9));
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return noticeBean;
		}
		
		public boolean insertAnonyBoard(MultipartRequest req,int emp_num,String name,String subject, String content) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
		
			try {
				con = pool.getConnection();
				sql = "select max(any_idx) from tblanonyboard";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				int ref = 1;
				if(rs.next()) ref = rs.getInt(1) + 1;
				//////////////////////////// FileUpload 시작 ////////////////////////////
				File dir = new File(SAVEFOLDER);
				if(!dir.exists()) {
					dir.mkdirs();
				}
				
				String filename = null;
				int filesize = 0;
				if(req.getFilesystemName("filename") != null) {
					filename = req.getFilesystemName("filename");
					filesize = (int)req.getFile("filename").length();
				}
				//////////////////////////// FileUpload 끝  ////////////////////////////
							
				sql = "insert into tblanonyboard values(?, ?, ?, now(), ?, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, ref);
				pstmt.setString(2, subject);
				pstmt.setString(3, name);
				pstmt.setInt(4, 0);
				pstmt.setString(5, content);
				pstmt.setString(6, filename);
				pstmt.setInt(7, filesize);
				pstmt.setInt(8, emp_num);
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
	public void notice_upHits(int any_idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblanonyboard set any_hits=any_hits+1 where any_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, any_idx);
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
			sql = "delete from tblanonyboard where any_idx=?";
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
			public Vector<ACommentBean> getAComment(int any_idx) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				Vector<ACommentBean> vlist = new Vector<ACommentBean>();
				try {
					con = pool.getConnection();
					sql = "select * from tblacomment where any_idx=? order by ac_num asc";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, any_idx);
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						ACommentBean ncommentBean = new ACommentBean();
						ncommentBean.setAc_num(rs.getInt(1));
						ncommentBean.setAny_idx(rs.getInt(2));
						ncommentBean.setAc_name(rs.getString(3));
						ncommentBean.setAc_comment(rs.getString(4));	
						ncommentBean.setAc_date(rs.getString(5));
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
			public boolean deleteNComment(int ac_num) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				boolean flag = false;
				try {
					con = pool.getConnection();
					sql = "delete from tblacomment where ac_num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, ac_num);
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
			public void deleteAllNComment(int any_idx) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;

				try {
					con = pool.getConnection();
					sql = "delete from tblacomment where any_idx=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, any_idx);
					pstmt.executeUpdate();

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
			}
			
			//댓글 갯수
			public int getNCommentCount(int any_idx) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				int count = 0;
				try {
					con = pool.getConnection();
					sql = "select count(*) from tblacomment where any_idx=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, any_idx);
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
			public boolean setNComment(int any_idx, String ac_name, String ac_comment, int emp_num) {                                        
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				int count = 0;
				boolean flag = false;
				try {
					con = pool.getConnection();
					sql = "select max(ac_num) from tblacomment";
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					rs.next();
					int ac_num = rs.getInt(1)+1;
					
					sql = "insert into tblacomment values(?,?,?,?,now(),?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, ac_num);
					pstmt.setInt(2, any_idx);
					pstmt.setString(3, ac_name);
					pstmt.setString(4, ac_comment);
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
		new AnonyBoardMgr();
	}
	
}
