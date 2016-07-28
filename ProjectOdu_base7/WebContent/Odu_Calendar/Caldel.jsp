<%@ page import="odu_calendar.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>caldelete</title>
</head>
<body>
<%


String sseq=request.getParameter("seq");
int seq=Integer.parseInt(sseq);

calDao dao=calDao.getInstance();

boolean isS=dao.deleteCal(seq);


if(isS){
	%>
	<script type="text/javascript">
	alert('삭제가 완료되었습니다.');
	location.href="Calendar.jsp";
	</script>
	<%
}else{	
	%>
	<script type="text/javascript">
	alert('정상적으로 삭제되지 않았습니다.');
	location.href="Calendar.jsp";
	</script>
	<%
}
%>
</body>
</html>