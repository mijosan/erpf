package erp;

public class NCommentBean {
	private int nc_num;
	private int ntc_idx;
	private String nc_name;
	private String nc_comment;
	private String nc_date;
	private int emp_num;
	
	public int getEmp_num() {
		return emp_num;
	}
	public void setEmp_num(int emp_num) {
		this.emp_num = emp_num;
	}
	public int getNc_num() {
		return nc_num;
	}
	public void setNc_num(int nc_num) {
		this.nc_num = nc_num;
	}
	public int getNtc_idx() {
		return ntc_idx;
	}
	public void setNtc_idx(int ntc_idx) {
		this.ntc_idx = ntc_idx;
	}
	public String getNc_name() {
		return nc_name;
	}
	public void setNc_name(String nc_name) {
		this.nc_name = nc_name;
	}
	public String getNc_comment() {
		return nc_comment;
	}
	public void setNc_comment(String nc_comment) {
		this.nc_comment = nc_comment;
	}
	public String getNc_date() {
		return nc_date;
	}
	public void setNc_date(String nc_date) {
		this.nc_date = nc_date;
	}
	
}
