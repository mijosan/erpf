package erp;

import erp.DBConnectionMgr;
import erp.GmailSend;
import erp.RegisterBean;

public class GmailMgr {
	private DBConnectionMgr pool = null;

	public GmailMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("Error : 커넥션 가져오기 실패!!");
		}
	}
	
	public void sendAccount(String title, String content,String toEmail) {
		String fromEmail = "sayadaieyas01@gmail.com";
		GmailSend.send(title, content, toEmail, fromEmail);
	}
	
}
