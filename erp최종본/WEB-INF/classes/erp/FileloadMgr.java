package erp;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileloadMgr {
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/WebContent/erp/fileupload/";
	public static  final String ENCTYPE = "EUC-KR";
	public static  final int MAXSIZE = 5*1024*1024;//5mb
	
	public FileloadMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	

}
