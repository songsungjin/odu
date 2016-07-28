<%@page import="odu_bbs.bbsDTO"%>
<%@page import="odu_bbs.bbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%
request.setCharacterEncoding("utf-8");
%>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bbswriteAf</title>
</head>
<body>

<%
String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

bbsDTO dto = new bbsDTO(id, title, content);
System.out.println(id + "," + title + "," + content);

bbsDAO dao = bbsDAO.getInstance();
boolean isS = dao.writeBBS(dto);
if(isS){
	%>
	<script type="text/javascript">
	alert("글 입력 성공");
	location.href='bbslist.jsp';
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("다시 입력하세요");
	location.href='bbswrite.jsp';
	</script>
	<%
}
%>



</body>
</html>





