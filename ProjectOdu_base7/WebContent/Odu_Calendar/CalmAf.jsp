<%@ page import="odu_calendar.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>calmAf</title>
</head>
<body>
<%!
public String two(String msg){
	return msg.trim().length() < 2 ? "0"+msg : msg.trim();
}

%>

<%


String sseq=request.getParameter("seq");
int seq=Integer.parseInt(sseq);

String id=request.getParameter("id");
String title=request.getParameter("title");
String content=request.getParameter("content");

String year=request.getParameter("year");
String month=request.getParameter("month");
String day=request.getParameter("day");
String hour=request.getParameter("hour");
String min=request.getParameter("min");

String wdate = year + two(month) + two(day) + two(hour) + two(min);

calDao dao=calDao.getInstance();

boolean isS=dao.modcal(new CalendarDTO(id, title, content, wdate), seq);

String url=String.format("%s?year=%s&month=%s", "Calendar.jsp", year, month);

if(isS){
	%>
	<script type="text/javascript">
	alert('일정이 수정되었습니다.');
	location.href="<%=url%>";
	</script>
	<%
}else{	
	%>
	<script type="text/javascript">
	alert('일정이 수정되지 않았습니다.');
	location.href="<%=url%>";
	</script>
	<%
}
%>
</body>
</html>