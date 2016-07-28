<%@page import="odu_timeline.timelineDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>timelinedel</title>
</head>
<body>
<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());
String id = request.getParameter("id");

timelineDAO dao = timelineDAO.getInstance();
boolean isS = dao.delTimeLine(seq, id);
if(isS){
%>
   <script type="text/javascript">
      alert("삭제가 성공");
      location.href="timeline.jsp";
   </script>
   <%
}else{
   %>
   <script>
      alert("삭제 실패");
      location.href='timeline.jsp?<%=seq%>';
   </script>
   <%
}
%>
</body>
</html>