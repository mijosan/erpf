package erp;

import java.sql.*;
import java.util.*;

public class RegisterMgr {

	private DBConnectionMgr pool = null;

	public RegisterMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("Error : 커넥션 가져오기 실패!!");
		}
	}

	public boolean checkId(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblRegister2 where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	public Vector<ZipcodeBean> zipcodeRead(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean> vecList = new Vector<ZipcodeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblZipcode where area3 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + area3 + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ZipcodeBean zipBean = new ZipcodeBean();
				zipBean.setZipcode(rs.getString(1));
				zipBean.setArea1(rs.getString(2));
				zipBean.setArea2(rs.getString(3));
				zipBean.setArea3(rs.getString(4));
				vecList.addElement(zipBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vecList;
	}

	public boolean insertResiter(RegisterBean regBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblRegister2 values(?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, regBean.getId());
			pstmt.setString(2, regBean.getPwd());
			pstmt.setString(3, regBean.getName());
			pstmt.setString(4, regBean.getEmail());
			pstmt.setString(5, regBean.getPhone());
			pstmt.setString(6, regBean.getZipcode());
			pstmt.setString(7, regBean.getAddress());
			pstmt.setString(8, regBean.getJob());
			char hobby[] = { '0', '0', '0', '0', '0' };
			if (regBean.getHobby() != null) {
				String hobbys[] = regBean.getHobby();
				String list[] = { "웹서핑", "채팅", "온라인", "영화감상", "등산" };
				for (int i = 0; i < hobbys.length; i++) {
					for (int j = 0; j < list.length; j++)
						if (hobbys[i].equals(list[j]))
							hobby[j] = '1';
				}
			}
			pstmt.setString(9, new String(hobby));
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	public int loginCheck(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int mode = 0;
		// 0-id false, 1-id true pwd-false, 2-id&pwd true
		try {
			if (!checkId(id))
				return mode;
			con = pool.getConnection();
			sql = "select id, pwd from tblRegister2 where id=? and pwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if (rs.next())
				mode = 2;
			else
				mode = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mode;
	}

	public boolean updateRegister(RegisterBean regBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblRegister2 set pwd=?,name=?," + "email=?,phone=?,zipcode=?,address=?,job=?,hobby=? "
					+ "where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, regBean.getPwd());
			pstmt.setString(2, regBean.getName());
			pstmt.setString(3, regBean.getEmail());
			pstmt.setString(4, regBean.getPhone());
			pstmt.setString(5, regBean.getZipcode());
			pstmt.setString(6, regBean.getAddress());
			pstmt.setString(7, regBean.getJob());
			char hobby[] = { '0', '0', '0', '0', '0' };
			if (regBean.getHobby() != null) {
				String hobbys[] = regBean.getHobby();
				String list[] = { "웹서핑", "채팅", "온라인", "영화감상", "등산" };
				for (int i = 0; i < hobbys.length; i++) {
					for (int j = 0; j < list.length; j++)
						if (hobbys[i].equals(list[j]))
							hobby[j] = '1';
				}
			}
			pstmt.setString(8, new String(hobby));
			pstmt.setString(9, regBean.getId());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	public RegisterBean getRegister(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		RegisterBean regBean = new RegisterBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblRegister2 where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				regBean.setId(rs.getString("id"));
				regBean.setPwd(rs.getString("pwd"));
				regBean.setName(rs.getString("name"));
				regBean.setPhone(rs.getString("phone"));
				regBean.setZipcode(rs.getString("zipcode"));
				regBean.setAddress(rs.getString("address"));
				regBean.setEmail(rs.getString("email"));
				regBean.setJob(rs.getString("job"));
				String hobbys[] = new String[5];
				String hobby = rs.getString("hobby");// 01001
				for (int i = 0; i < hobbys.length; i++) {
					hobbys[i] = hobby.substring(i, i + 1);
				}
				regBean.setHobby(hobbys);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return regBean;
	}

	public boolean adminCheck(String admin_id, String admin_pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select admin_id, admin_pass from tblAdmin where admin_id=? and admin_pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, admin_id);
			pstmt.setString(2, admin_pass);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return flag;
	}

	public Vector<RegisterBean> getRegisterList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<RegisterBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from tblRegister2";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				RegisterBean regBean = new RegisterBean();
				regBean.setId(rs.getString("id"));
				regBean.setPwd(rs.getString("pwd"));
				regBean.setName(rs.getString("name"));
				regBean.setPhone(rs.getString("phone"));
				regBean.setEmail(rs.getString("email"));
				vlist.addElement(regBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Gmail Send id, pwd
	public void sendAccount(String id) {
		RegisterBean bean = getRegister(id);
		String pwd = bean.getPwd();
		String title = "OOO.com에서 아이디와 비밀번호 전송";
		String content = "id : " + id + ", pwd : " + pwd;
		String toEmail = bean.getEmail();
		String fromEmail = "sayadaieyas01@gmail.com";
		GmailSend.send(title, content, toEmail, fromEmail);
	}
}