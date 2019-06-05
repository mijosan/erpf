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



public class LogMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/WebContent/erp/fileupload/";
	public static final String ENCTYPE = "EUC-KR";
	public static final int MAXSIZE = 5*1024*1024;
	
	public LogMgr() {
		pool = DBConnectionMgr.getInstance();
		
	}

			public Vector<LogBean> getBoardList(String keyField, String keyWord, int start, int end) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				Vector<LogBean> vlist = new Vector<LogBean>();
				try {
					con = pool.getConnection();
					if(keyWord.equals("null")||keyWord.equals("")){ //검색을 하지 않았을때
						sql = "select * from tbllog order by log_idx desc limit ?, ?"; //최신 글중에서 pos를 오름차순으로 정렬함
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, end);
					}else {//검색을 했을때
						sql = "select * from tbllog where "+keyField+" like ? limit ?, ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, "%" + keyWord + "%");
						pstmt.setInt(2, start);
						pstmt.setInt(3, end);
					}
					rs = pstmt.executeQuery();
					while(rs.next()){
						LogBean bean = new LogBean();
						
						bean.setLog_idx(rs.getInt(1));
						bean.setLog_content(rs.getString(2));
						bean.setLog_date(rs.getString(3));
						bean.setEmp_dept(rs.getString(4));	
						bean.setEmp_job(rs.getString(5));
						bean.setEmp_name(rs.getString(6));
						bean.setEmp_phone(rs.getString(7));
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
					sql = "select count(*) from tbllog";
					pstmt = con.prepareStatement(sql);
				}else {
					sql = "select count(*) from tbllog where " + keyField +" like ?";
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
		
		public boolean insertLogBoard(String log_content, EmployeeBean employeeBean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
		
			try {
				con = pool.getConnection();
				sql = "select max(log_idx) from tbllog";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				int ref = 1;
				if(rs.next()) ref = rs.getInt(1) + 1;
							
				sql = "insert into tbllog values(?, ?, now(), ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, ref);
				pstmt.setString(2, log_content);
				pstmt.setString(3, employeeBean.getEmp_dept());
				pstmt.setString(4, employeeBean.getEmp_job());
				pstmt.setString(5, employeeBean.getEmp_name());
				pstmt.setString(6, employeeBean.getEmp_phone());
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

	

}
