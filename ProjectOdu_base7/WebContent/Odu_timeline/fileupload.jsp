<%@page import="odu_timeline.timelineDTO"%>
<%@page import="odu_timeline.timelineDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@page import="org.apache.commons.fileupload.FileItem" %>
<%@page import="org.apache.commons.fileupload.ProgressListener" %>

<%@page import="java.util.List" %>
<%@page import="java.io.File" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.io.IOException" %>

<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>file upload</title>
</head>
<body>

<%!
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
String fupload = application.getRealPath("/upload");
//String fupload = "c:\\upload";

System.out.println("fupload=" + fupload);

String yourTempDir = fupload;
int yourMaxRequestSize=100*1024*1024;
int yourMaxMemorySize=100*1024;

String id="";
//String content="";

String content=request.getParameter("content");

String title="";
String filename="";

 
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if(isMultipart){      // form or file
   DiskFileItemFactory factory = new DiskFileItemFactory();
   
   factory.setSizeThreshold(yourMaxMemorySize);
   factory.setRepository(new File(yourTempDir));
   
   ServletFileUpload upload = new ServletFileUpload(factory);
   upload.setSizeMax(yourMaxRequestSize);
   
   List<FileItem> items = upload.parseRequest(request);
   
   Iterator<FileItem> it = items.iterator();      // <= for(int i = 0; i < 10
   while(it.hasNext()){
      FileItem item = it.next();
      

      
      if(item.isFormField()){
         processFromField(item, out);
         if(item.getFieldName().equals("id")){
            id = item.getString("utf-8");
         /* }else if(item.getFieldName().equals("title")){
            title = item.getString("utf-8"); */
         }else if(item.getFieldName().equals("content")){
            content = item.getString("utf-8");
         }
      }else{ 
         
         if(item.getFieldName().equals("fileload")){
            int idx = item.getName().lastIndexOf("\\");
            if(idx == -1){
               idx=item.getName().lastIndexOf("/");
            }
            filename = item.getName().substring(idx+1);            
         }
         processUploadFile(item, fupload, out);
      } 
   }   
}else{
   System.out.println("Multi Part가 아님");
} 

timelineDAO dao = timelineDAO.getInstance();
boolean isS = dao.writeTimeLine(new timelineDTO(id, content, filename));
if(isS){
   %>
   <script type="text/javascript">
      //alert('파일 업로드 성공');
      location.href = 'timeline.jsp';
   </script>
   <%
}else{ 
   %>   
   <script type="text/javascript">
      alert('파일 업로드하지 못했습니다.');
      location.href = 'timeline.jsp';
   </script>

<%
}
%>
</body>
</html>