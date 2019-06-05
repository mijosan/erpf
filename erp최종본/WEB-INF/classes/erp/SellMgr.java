package erp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;



public class SellMgr {
	
	private DBConnectionMgr pool;
	
	public SellMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	//�Ǹ���ȸ(searchSell.jsp) ����Ʈ �ҷ�����
	public Vector<SellBean> getList(String KeyField, String KeyWord ,int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<SellBean> vlist = new Vector<SellBean>();
		try {
			if(KeyWord.equals("null") || KeyWord.equals("")) {
				con = pool.getConnection();
				sql = "select * from tblsell order by s_num limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
			}else {
				con = pool.getConnection();
				sql = "select * from tblsell where "+KeyField+" like ? limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+KeyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
			}
				while(rs.next()) {
					SellBean bean = new SellBean();
					bean.setS_num(rs.getInt("s_num"));
					bean.setS_customer(rs.getString("s_customer"));
					bean.setP_num(rs.getString("p_num"));
					bean.setP_name(rs.getString("p_name"));
					bean.setP_quantity(rs.getInt("p_quantity"));
					bean.setP_price(rs.getInt("p_price"));
					bean.setS_date(rs.getString("s_date"));
					bean.setS_staff(rs.getString("s_staff"));
					vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vlist;
	}
	
		
	//�Ǹ���ȸ(searchsell.jsp) üũ�� �͵� ����.(delete.jsp)
	public void deleteSell(int s_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();
			sql = "delete from tblsell where s_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, s_num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//�Ǹ���ȸ-read(read.jsp) ������ ����Ʈ 1���� �ҷ�����.
	public Vector<SellBean> getList2(int s_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<SellBean> vlist = new Vector<SellBean>();
		try {
			
			con = pool.getConnection();
			sql = "select * from tblsell where s_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, s_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SellBean bean = new SellBean();
				bean.setS_num(rs.getInt(1));
				bean.setS_customer(rs.getString(2));
				bean.setP_num(rs.getString(3));
				bean.setP_name(rs.getString(4));
				bean.setP_quantity(rs.getInt(5));
				bean.setP_price(rs.getInt(6));
				bean.setS_date(rs.getString(7));
				bean.setS_staff(rs.getString(8));
				vlist.addElement(bean);				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vlist;
	}
	
	//���� ��� �� ��(insertSell.jsp) : �Ǹ� ��ȣ �⺻�� ����
		public int getMaxNum() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int maxnum = 0;
			try {
				con = pool.getConnection();
				sql = "select max(s_num) from tblsell";
				pstmt = con.prepareStatement(sql);

				rs = pstmt.executeQuery();
				if (rs.next()) {
					maxnum = rs.getInt(1);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return maxnum+1;
		}
		
		//�Ǹŵ�� ������(insertSell.jsp) : ���� ���̺� �ִ� ǰ��,ǰ�� ��������.
		public Vector<SellBean> getList3() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<SellBean> vlist = new Vector<SellBean>();
			try {
				con = pool.getConnection();
				sql = "select p_num, p_name from tblproduct group by p_num, p_name";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					SellBean bean = new SellBean();
					bean.setP_num(rs.getString(1));
					bean.setP_name(rs.getString(2));
					
					vlist.addElement(bean);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		
		//�Ǹŵ��Proc (insertSellProc.jsp) : �Ǹ� ���
		public boolean insertSellList(S_insertBean Sbean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			boolean flag = false;

			try {
				con = pool.getConnection();
				sql = "insert tblsell(s_num, s_customer, p_num, p_name, p_quantity, p_price, s_date, s_staff) values(?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				
				int[] s_num = Sbean.getS_num();
				String[] s_customer = Sbean.getS_customer();
				String[] p_num = Sbean.getP_num();
				String[] p_name = Sbean.getP_name();
				int[] p_quantity = Sbean.getP_quantity();
				int[] p_price = Sbean.getP_price();
				String[] s_date = Sbean.getS_date();
				String[] s_staff = Sbean.getS_staff();
				
				for(int i = 0; i < s_customer.length; i++) {
					if(s_customer[i].equals("") || s_customer[i].equals(null)) {
						flag = true;
						break;
					}else {
						
						pstmt.setInt(1, s_num[i]);
						pstmt.setString(2, s_customer[i]);
						pstmt.setString(3, p_num[i]);
						pstmt.setString(4, p_name[i]);
						pstmt.setInt(5, p_quantity[i]);
						pstmt.setInt(6, p_price[i]);
						pstmt.setString(7, s_date[i]);
						pstmt.setString(8, s_staff[i]);
						pstmt.executeUpdate();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return flag;
		}
		
		//�Ǹż���Proc(sellReadProc.jsp)
		public boolean updateSell(int s_num, String p_name, int p_quantity, String s_date, String s_staff, int p_price) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update tblsell set p_name=?, p_quantity=?, s_date=?, s_staff=?, p_price=? where s_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, p_name);
				pstmt.setInt(2, p_quantity);
				pstmt.setString(3, s_date);
				pstmt.setString(4, s_staff);
				pstmt.setInt(5, p_price);
				pstmt.setInt(6, s_num);				
				
				int result = pstmt.executeUpdate();
				if(result==1) {
					flag = true;
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		//�Ǹ���ȸ(searchSell.jsp) ����¡ �� �� : totalRecord ���� ��������.
		public int getTotalCount(String keyField, String keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalRecord = 0;
			try {
				con = pool.getConnection();
				if(keyWord.equals("null")||keyWord.equals("")){
					sql = "select count(*) from tblsell";
					pstmt = con.prepareStatement(sql);
				}else {
					sql = "select count(*) from tblsell where " + keyField + "=" + "'" +keyWord + "'";
					pstmt = con.prepareStatement(sql);
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
		
		
		//����� ��Ʈ(employeeChart.jsp) : ��� ��������
		public Vector<String> getStaffName(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<String> vlist = new Vector<String>();
			try {
				con = pool.getConnection();
				sql = "select distinct s_staff from tblsell";
				pstmt = con.prepareStatement(sql);

				rs = pstmt.executeQuery();
				while(rs.next()) {
					String name = rs.getString("s_staff");
					vlist.addElement(name);
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		
		//����� ��Ʈ(employeeChart.jsp) : ��ǰ ��������
		public Vector<String>getProductName(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<String> vlist = new Vector<String>();
			
			try {
				con = pool.getConnection();
				sql = "select distinct p_name from tblsell";
				pstmt = con.prepareStatement(sql);

				rs = pstmt.executeQuery();
				while(rs.next()) {
					String name = rs.getString(1);
					vlist.addElement(name);
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		
		//����� ��Ʈ(employeeChart.jsp) : ����� �Ǹ� ��ǰ �հ� ��������
		public Vector<SellBean> getSumQuantity(String s_staff) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<SellBean> vlist = new Vector<SellBean>();
			try {
				con = pool.getConnection();
				sql = "select s_staff, p_name, sum(p_quantity) from tblsell where s_staff = ? group by p_name";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, s_staff);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					SellBean bean = new SellBean();
					bean.setS_staff(rs.getString(1));
					bean.setP_name(rs.getString(2));
					bean.setP_quantity(rs.getInt(3));
					vlist.addElement(bean);
				}				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		
		//��ǰ �Ǹ� ��Ʈ(productChart.jsp) : ��ǰ�̸�, ��ǰ �հ� ��������.
		public Vector<SellBean> getProductList() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<SellBean> vlist = new Vector<SellBean>();
			
			try {
				con = pool.getConnection();
				sql = "select p_name, sum(p_quantity) as �հ� from tblsell group by p_name";
				pstmt = con.prepareStatement(sql);

				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					SellBean Sbean = new SellBean();
					Sbean.setP_name(rs.getString(1));
					Sbean.setP_quantity(rs.getInt(2));
					vlist.addElement(Sbean);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		//�Ǹ� ��� â(insertSell.jsp)���� �Ǹ� ����� ��������
		public Vector<EmployeeBean> getStaff() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<EmployeeBean> vlist = new Vector<EmployeeBean>();

			try {
				con = pool.getConnection();
				sql = "select emp_name from tblemployee where emp_dept = '������'";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					EmployeeBean Ebean = new EmployeeBean();
					Ebean.setEmp_name(rs.getString(1));
					vlist.addElement(Ebean);
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		
		
		
		
	
			
		/*
				public void post1000(){
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					try {
						con = pool.getConnection();
						sql = "insert tblsell(s_num, s_customer, p_num, p_name, p_quantity, p_price, s_date, s_staff) ";
						sql+="values(?,'���Ǵ�','abc-138','�����',100,5000,'2019.01.19','�����')";
						pstmt = con.prepareStatement(sql);
						for (int i = 103; i < 400; i++) {
							pstmt.setInt(1, i);
							pstmt.executeUpdate();
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt);
					}
				}
				
				public static void main(String[] args) {
					SellMgr mgr = new SellMgr();
					mgr.post1000();
					System.out.println("����");
				}
		*/
}
