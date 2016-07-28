package odu_pds;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FileDownloader extends HttpServlet {
	
	private static final long serialVersionUTD = 4908298571553227744L; 
	
	private static final int BUFFER_SIZE = 8192; // 8kb
	
	private ServletConfig mConfig = null;
	
	public void init(ServletConfig config) throws ServletException{
		super.init(config);
		mConfig=config;
	}

	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String filename= new String(req.getParameter("filename").getBytes("8859_1"), "KSC5601");
		String spdsid= req.getParameter("pdsid");
		
		
		PdsDAO dao= PdsDAO.getInstance();
		int pdsid= Integer.parseInt(spdsid); 
		boolean isS= dao.downloadCount(pdsid);
		if(!isS){
			resp.sendRedirect("pdslist.jsp");
		}
		
		BufferedOutputStream out= new BufferedOutputStream(resp.getOutputStream());
		
		try{
			String filePath="";
			if(spdsid!=null){
				filePath=mConfig.getServletContext().getRealPath("/upload");
			}
			filePath = filePath + "\\" + filename;
			
			File f = new File(filePath);
			System.out.println("filePath = " + filePath);
			
			if(f.exists() && f.canRead()){
				resp.setHeader("Content-Disposition", 
							"attachment; filename=\"" + filename + "\";");
				resp.setHeader("Content-Transfer-Encoding", "binary;");
				resp.setHeader("Content-Length", "" + f.length());
				resp.setHeader("Pragma", "no-cache;");
				resp.setHeader("Expires", "-1;");	
				
				System.out.println("download");
				
				BufferedInputStream fileInput 
					= new BufferedInputStream(new FileInputStream(f));
				
				byte buffer[]= new byte[BUFFER_SIZE];
				
				int read = 0;
				
				while((read=fileInput.read(buffer)) != -1){
					out.write(buffer, 0, read);					
				}
				fileInput.close();
				out.flush();
				System.out.println("download end");			
			}else{
				System.out.println("파일을 발견하지 못했습니다");
				req.setAttribute("dir", f.getParent());
				req.setAttribute("error", 
						"File " + f.getAbsolutePath() + 
						" 파일이 존재하지 않거나 서버에 파일이 없습니다");				
			}			
			
		}catch(Throwable e){
			// e.printStackTrace();
		}finally{
			if(out != null){
				out.flush();
				out.close();
			}
		}		
	}
}






