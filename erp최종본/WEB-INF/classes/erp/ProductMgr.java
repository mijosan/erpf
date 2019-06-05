package erp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ProductMgr {
	
	private DBConnectionMgr pool;
	
	public ProductMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	//생산등록(product.jsp) -> 생산제품 등록
	public boolean insertProduct(P_insertBean Ibean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblproduct(add_num, p_num, p_name, p_quantity, p_price, p_container, p_date) values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			int[] add_num = Ibean.getAdd_num();
			String[] num = Ibean.getP_num();
			String[] name = Ibean.getP_name();
			int[] quantity = Ibean.getP_quantity();
			int[] price = Ibean.getP_price();
			String[] container = Ibean.getP_container();
			String[] date = Ibean.getP_date();
			
			for(int i = 0; i < num.length; i++) {
				if(num[i].contentEquals("0")) {
					flag = true;
					break;
				}else {
					pstmt.setInt(1, add_num[i]);
					pstmt.setString(2, num[i]);
					pstmt.setString(3, name[i]);
					pstmt.setInt(4, quantity[i]);
					pstmt.setInt(5, price[i]);
					pstmt.setString(6, container[i]);
					pstmt.setString(7, date[i]);
					pstmt.executeUpdate();
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//생산등록(product.jsp) -> 모든 제품 리스트 불러오기
	public Vector<ProductBean> getProductList(int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblproduct limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setAdd_num(rs.getInt("add_num"));
				bean.setP_num(rs.getString("p_num"));
				bean.setP_name(rs.getString("p_name"));
				bean.setP_quantity(rs.getInt("p_quantity"));
				bean.setP_price(rs.getInt("p_price"));
				bean.setP_container(rs.getString("p_container"));
				bean.setP_date(rs.getString("p_date"));
				vlist.addElement(bean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	//생산제품 리스트 삭제(deleteProduct.jsp)
	public void deleteProduct(String add_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;

		try {
			con = pool.getConnection();
			sql = "delete from tblproduct where add_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, add_num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	//생산 제품 추가할 때(insertProduct.jsp) : 생산 번호 기본값 세팅
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxnum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(add_num) from tblproduct";
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
	
	
	//생산 제품read(productRead.jsp) : 생산 제품 한개만 가져오기
	public ProductBean getList(int Add_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ProductBean bean = new ProductBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblproduct where add_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Add_num);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setAdd_num(rs.getInt(1));
				bean.setP_num(rs.getString(2));
				bean.setP_name(rs.getString(3));
				bean.setP_quantity(rs.getInt(4));
				bean.setP_price(rs.getInt(5));
				bean.setP_container(rs.getString(6));
				bean.setP_date(rs.getString(7));			
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
	public boolean updateProduct(ProductBean Pbean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblproduct set p_num=?, p_name=?, p_quantity=?, p_price=?, p_container=?, p_date=? where add_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Pbean.getP_num());
			pstmt.setString(2, Pbean.getP_name());
			pstmt.setInt(3, Pbean.getP_quantity());
			pstmt.setInt(4, Pbean.getP_price());
			pstmt.setString(5, Pbean.getP_container());
			pstmt.setString(6, Pbean.getP_date());
			pstmt.setInt(7, Pbean.getAdd_num());
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				flag = true;
			}else {
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
		//생산조회(Product.jsp) 페이징 할 때 : totalRecord 갯수 가져오기.
			public int getTotalCount() {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				int MaxNum = 0;

				try {
					con = pool.getConnection();
					sql = "select count(*) from tblproduct";
					pstmt = con.prepareStatement(sql);

					rs = pstmt.executeQuery();
					if (rs.next()) {
						MaxNum = rs.getInt(1);
					}

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return MaxNum;
			}
	
}
