<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="odu_together.*" %>

<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.ProgressListener" %>

<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.IOException" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%!
public String two(String msg){
	return msg.trim().length() < 2 ? "0" + msg:msg.trim();
}

public void processFromField(FileItem item, JspWriter out) throws IOException{
	String name = item.getFieldName();
	String value = "";
	try{
		value = item.getString("utf-8");	
	}catch(Exception e){
		value = item.getString();		
	}
}
public void processUploadFile(FileItem fileItem, String dir, JspWriter out) 
				throws IOException{
	String fieldName = fileItem.getFieldName();
	String filename = fileItem.getName();
	String contentType = fileItem.getContentType();
	long sizeInBytes = fileItem.getSize();
	
	System.out.println("size:" + sizeInBytes);
	
	// 업로드한 파일 있는 경우,
	if(sizeInBytes > 0){
		int idx = filename.lastIndexOf("\\");
		if(idx == -1){
			idx = filename.lastIndexOf("/");
		}
		filename=filename.substring(idx + 1);
		
		try{
			File uploadedFile = new File(dir, filename);
			fileItem.write(uploadedFile);
		}catch(Exception e){}
	}	
}
%>

<%
// 1. 개인 폴더 저장 
// 2. 톰켓에 배포
String fupload = application.getRealPath("/upload");
//String fupload = "c:\\upload";

System.out.println("fupload:"+fupload);

String yourTempDirectory = fupload;
int yourMaxRequestSize = 100 * 1024 * 1024;
int yourMaxMemorySize = 100 * 1024*1024;

String id="";
String content="";
String title="";
String f_name="";

////////

String cate ="";
String year ="";
String month ="";
String day ="";


String Mdate=year+two(month) + two(day);
String t_numm = "";
int t_num = 0;


boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if(isMultipart){
	DiskFileItemFactory factory=new DiskFileItemFactory();
	
	factory.setSizeThreshold(yourMaxMemorySize);
	factory.setRepository(new File(yourTempDirectory));	// Repository(==저장소)
	
	ServletFileUpload upload = new ServletFileUpload(factory);
	upload.setFileSizeMax(yourMaxRequestSize);
	
	List<FileItem> items = upload.parseRequest(request);
	
	System.out.println("items:" + items);
	
	Iterator<FileItem> it=items.iterator();
	while(it.hasNext()){
		FileItem item = it.next();	
		
		if(item.isFormField()){
			processFromField(item, out);
		
			if(item.getFieldName().equals("id")){
				id = item.getString("utf-8");
			}else if(item.getFieldName().equals("title")){
				title = item.getString("utf-8");
			}else if(item.getFieldName().equals("content")){
				content = item.getString("utf-8");
			}else if(item.getFieldName().equals("title_select")){
				cate = item.getString("utf-8");
				if(cate.equals('0')){
					cate = "";
					cate = "기타";
				}
			}else if(item.getFieldName().equals("eyear")){
				year = item.getString("utf-8");
			}else if(item.getFieldName().equals("emonth")){
				month = item.getString("utf-8");
			}else if(item.getFieldName().equals("eday")){
				day = item.getString("utf-8");
			}else if(item.getFieldName().equals("itemcount")){
				t_numm = item.getString("utf-8");
				t_num = Integer.parseInt(t_numm);
			}
			Mdate = year+two(month) + two(day);
		}else{
			if(item.getFieldName().equals("fileload")){
				int idx = item.getName().lastIndexOf("\\");	
				if(idx == -1){
					idx = item.getName().lastIndexOf("/");
				}
				f_name = item.getName().substring(idx + 1);
			}
			processUploadFile(item, fupload, out);
		}
	}
}else{
	System.out.println("Multipart가 아님");
} 
//업로드후에 DB에 저장하기


System.out.println(id + "/" + content + "/" + title + "/" + f_name + "/" + cate + "/" + Mdate + "/"+ t_numm + "");
togetherDAO dao = togetherDAO.getInstance();
boolean isS = dao.writeTogether(new togetherDTO(id, cate, title, content, f_name, Mdate, t_num));
if(isS){
	%>
	<script type="text/javascript">
	location.href='together.jsp';	
	</script>
	<%
}else{ 
	%>
	<script type="text/javascript">
	alert('파일 업로드 실패');
	location.href='together.jsp';	
	</script>
<%
}
%>
</body>
</html>