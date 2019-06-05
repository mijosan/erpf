package erp;

public class MessageBean {
	private int msg_idx;
	private int msg_send;
	private int msg_to;
	private String msg_content;
	private String msg_senddate;
	public int getMsg_idx() {
		return msg_idx;
	}
	public void setMsg_idx(int msg_idx) {
		this.msg_idx = msg_idx;
	}
	public int getMsg_send() {
		return msg_send;
	}
	public void setMsg_send(int msg_send) {
		this.msg_send = msg_send;
	}
	public int getMsg_to() {
		return msg_to;
	}
	public void setMsg_to(int msg_to) {
		this.msg_to = msg_to;
	}
	public String getMsg_content() {
		return msg_content;
	}
	public void setMsg_content(String msg_content) {
		this.msg_content = msg_content;
	}
	public String getMsg_senddate() {
		return msg_senddate;
	}
	public void setMsg_senddate(String msg_senddate) {
		this.msg_senddate = msg_senddate;
	}
	public String getMsg_condate() {
		return msg_condate;
	}
	public void setMsg_condate(String msg_condate) {
		this.msg_condate = msg_condate;
	}
	private String msg_condate;
}
