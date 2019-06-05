package erp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Vector;

public class MessageMgr {
	DBConnectionMgr pool;
	Date date;
	String today;
	
	public MessageMgr() {
		pool = DBConnectionMgr.getInstance();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		date = new Date();
		today = dateFormat.format(date);
	}
	
	// 하나의 쪽지 내용을 가져올거임
	public MessageBean getView(int idx) {
		MessageBean msgBean = new MessageBean();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from tblmessage where msg_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if ( rs.next() ) {
				msgBean.setMsg_idx(rs.getInt(1));
				msgBean.setMsg_send(rs.getInt(2));
				msgBean.setMsg_to(rs.getInt(3));
				msgBean.setMsg_content(rs.getString(4));
				msgBean.setMsg_senddate(rs.getString(5));
				msgBean.setMsg_condate(rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return msgBean;
	}
	
	// 검색어로 사람, 부서 검색
	public Vector<DeptEmpBean> getSempList(String who) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<DeptEmpBean> sempList = new Vector<DeptEmpBean>();
		try {
			con = pool.getConnection();
			sql = "select emp_dept, emp_num, emp_name from tblemployee where emp_dept like ? or emp_name like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + who + "%");
			pstmt.setString(2, "%" + who + "%");
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				DeptEmpBean empBean = new DeptEmpBean();
				empBean.setDept(rs.getString(1));
				empBean.setEmp_num(rs.getInt(2));
				empBean.setEmp_name(rs.getString(3));
				sempList.add(empBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return sempList;
	}

	// 부서별로 인원수 정리 ({"부서명","인원수"})
	public Vector<DeptBean> getDeptList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<DeptBean> deptList = new Vector<DeptBean>();
		try {
			con = pool.getConnection();
			sql = "select emp_dept, count(emp_num) from tblemployee group by emp_dept";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				DeptBean dBean = new DeptBean();
				dBean.setDept(rs.getString(1));
				dBean.setEmpCount(rs.getInt(2));
				deptList.add(dBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return deptList;
	}
	
	// 부서별로 정리된 사원명단을 넘겨받는다.
	public Vector<DeptEmpBean> getEmpList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<DeptBean> deptList = getDeptList();
		Vector<DeptEmpBean> empList = new Vector<DeptEmpBean>();
		try {
			con = pool.getConnection();
			for (int i = 0; i < deptList.size(); i++ ) {
				DeptBean dBean = deptList.get(i);
				sql = "select emp_dept, emp_num, emp_name from tblemployee where emp_dept=? order by emp_dept";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, dBean.getDept());
				rs = pstmt.executeQuery();
				while ( rs.next() ) {
					DeptEmpBean deBean = new DeptEmpBean();
					deBean.setDept(rs.getString(1));
					deBean.setEmp_num(rs.getInt(2));
					deBean.setEmp_name(rs.getString(3));
					empList.add(deBean);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return empList;
	}
	
	// 마지막 메세지 번호를 가져온다뉴
	public int maxIdx() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxIdx = 0;
		try {
			con = pool.getConnection();
			sql = "select max(msg_idx) from tblmessage";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				maxIdx = rs.getInt(1) + 1;
			}
		} catch (Exception e) {	
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxIdx;
	}
		
	public boolean addMsg(MessageBean msgBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into tblmessage (msg_idx,msg_send,msg_to,msg_content,msg_senddate,msg_condate) values (?,?,?,?,now(),null)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, maxIdx());
			pstmt.setInt(2, msgBean.getMsg_send());
			pstmt.setInt(3, msgBean.getMsg_to());
			pstmt.setString(4, msgBean.getMsg_content());
			int cnt = pstmt.executeUpdate();
			if (cnt == 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}

	public Vector<MessageBean> getAllMsglist(int id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MessageBean> msglist = new Vector<MessageBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblmessage where msg_to=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				MessageBean msgBean = new MessageBean();
				msgBean.setMsg_idx(rs.getInt(1));
				msgBean.setMsg_send(rs.getInt(2));
				msgBean.setMsg_to(rs.getInt(3));
				msgBean.setMsg_content(rs.getString(4).replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				String time = rs.getString(5);
				if ( time.substring(0, 10) == today ) {
					int sendTime = Integer.parseInt(time.substring(11,12)); 
					String timeType = "오전";
					if ( sendTime >= 12 ) {
						timeType = "오후";
						sendTime -= 12;
					}
					msgBean.setMsg_senddate(timeType + " " + sendTime + " : " + Integer.parseInt(time.substring(15,16)) + " : " + Integer.parseInt(time.substring(18,19)));
				} else {
					msgBean.setMsg_senddate(time.substring(0,10));
				}
				String ctime = rs.getString(6);
				if (ctime != null) {
					if ( ctime.substring(0, 10) == today ) {
						int conTime = Integer.parseInt(ctime.substring(11,12)); 
						String conType = "오전";
						if ( conTime >= 12 ) {
							conType = "오후";
							conTime -= 12;
						}
						msgBean.setMsg_condate(conType + " " + conTime + " : " + Integer.parseInt(ctime.substring(15,16)) + " : " + Integer.parseInt(ctime.substring(18,19)));
					} else {
						msgBean.setMsg_condate(ctime.substring(0,10));
					}
				} else {
					msgBean.setMsg_condate("미확인");
				}
				msglist.add(msgBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return msglist;
	}
	
	public Vector<MessageBean> getNoConMsglist(int id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MessageBean> msglist = new Vector<MessageBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblmessage where msg_to=? and msg_condate is null";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				MessageBean msgBean = new MessageBean();
				msgBean.setMsg_idx(rs.getInt(1));
				msgBean.setMsg_send(rs.getInt(2));
				msgBean.setMsg_to(rs.getInt(3));
				msgBean.setMsg_content(rs.getString(4).replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				String time = rs.getString(5);
				if ( time.substring(0, 10) == today ) {
					int sendTime = Integer.parseInt(time.substring(11,12)); 
					String timeType = "오전";
					if ( sendTime >= 12 ) {
						timeType = "오후";
						sendTime -= 12;
					}
					msgBean.setMsg_senddate(timeType + " " + sendTime + " : " + Integer.parseInt(time.substring(15,16)) + " : " + Integer.parseInt(time.substring(18,19)));
				} else {
					msgBean.setMsg_senddate(time.substring(0,10));
				}
				msgBean.setMsg_condate("미확인");
				msglist.add(msgBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return msglist;
	}
	
	public Vector<MessageBean> getYesConMsglist(int id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MessageBean> msglist = new Vector<MessageBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblmessage where msg_to=? and msg_condate is not null";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				MessageBean msgBean = new MessageBean();
				msgBean.setMsg_idx(rs.getInt(1));
				msgBean.setMsg_send(rs.getInt(2));
				msgBean.setMsg_to(rs.getInt(3));
				msgBean.setMsg_content(rs.getString(4).replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				String time = rs.getString(5);
				if ( time.substring(0, 10) == today ) {
					int sendTime = Integer.parseInt(time.substring(11,12)); 
					String timeType = "오전";
					if ( sendTime >= 12 ) {
						timeType = "오후";
						sendTime -= 12;
					}
					msgBean.setMsg_senddate(timeType + " " + sendTime + " : " + Integer.parseInt(time.substring(15,16)) + " : " + Integer.parseInt(time.substring(18,19)));
				} else {
					msgBean.setMsg_senddate(time.substring(0,10));
				}
				String ctime = rs.getString(6);
				if (ctime != null) {
					if ( ctime.substring(0, 10) == today ) {
						int conTime = Integer.parseInt(ctime.substring(11,12)); 
						String conType = "오전";
						if ( conTime >= 12 ) {
							conType = "오후";
							conTime -= 12;
						}
						msgBean.setMsg_condate(conType + " " + conTime + " : " + Integer.parseInt(ctime.substring(15,16)) + " : " + Integer.parseInt(ctime.substring(18,19)));
					} else {
						msgBean.setMsg_condate(ctime.substring(0,10));
					}
				}
				msglist.add(msgBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return msglist;
	}
	
	public Vector<MessageBean> getSendMsglist(int id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MessageBean> msglist = new Vector<MessageBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblmessage where msg_send=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				MessageBean msgBean = new MessageBean();
				msgBean.setMsg_idx(rs.getInt(1));
				msgBean.setMsg_send(rs.getInt(2));
				msgBean.setMsg_to(rs.getInt(3));
				msgBean.setMsg_content(rs.getString(4).replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				String time = rs.getString(5);
				if ( time.substring(0, 10) == today ) {
					int sendTime = Integer.parseInt(time.substring(11,12)); 
					String timeType = "오전";
					if ( sendTime >= 12 ) {
						timeType = "오후";
						sendTime -= 12;
					}
					msgBean.setMsg_senddate(timeType + " " + sendTime + " : " + Integer.parseInt(time.substring(15,16)) + " : " + Integer.parseInt(time.substring(18,19)));
				} else {
					msgBean.setMsg_senddate(time.substring(0,10));
				}
				String ctime = rs.getString(6);
				if (ctime != null) {
					if ( ctime.substring(0, 10) == today ) {
						int conTime = Integer.parseInt(ctime.substring(11,12)); 
						String conType = "오전";
						if ( conTime >= 12 ) {
							conType = "오후";
							conTime -= 12;
						}
						msgBean.setMsg_condate(conType + " " + conTime + " : " + Integer.parseInt(ctime.substring(15,16)) + " : " + Integer.parseInt(ctime.substring(18,19)));
					} else {
						msgBean.setMsg_condate(ctime.substring(0,10));
					}
				} else {
					msgBean.setMsg_condate("미확인");
				}
				msglist.add(msgBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return msglist;
	}
	
	public int getCount(int id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "select count(msg_idx) from tblmessage where msg_to=? and msg_condate is null";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblmessage where msg_to=2";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public String getSender(int msg_send) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sender = null;
		try {
			con = pool.getConnection();
			sql = "select emp_name, emp_dept from tblemployee where emp_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, msg_send);
			rs = pstmt.executeQuery();
			if ( rs.next() ) {
				sender = rs.getString(1) + " ( " + rs.getString(2) + " )";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return sender;
	}
	
	// 쪽지 확인 함
	public boolean conView(int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblmessage set msg_condate=now() where msg_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
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

	// 쪽지 삭제 함 하나만
	public boolean delView(int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblmessage where msg_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
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
	
}
