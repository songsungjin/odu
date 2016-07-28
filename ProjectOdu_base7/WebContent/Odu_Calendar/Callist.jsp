<%@page import="odu_member.*"%>
<%@page import="odu_calendar.*"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>callist</title>
<style type="text/css">
td{
	text-align: center;
}


</style>

</head>
<body>

<%! 
public String two(String msg){
	return msg.trim().length() < 2 ? "0"+msg : msg.trim();
}
%>

<%
MemberDTO user=(MemberDTO)session.getAttribute("login");

String year=request.getParameter("year");
String month=request.getParameter("month");
String day=request.getParameter("day");

String dates=year + two(month) + two(day);

// out.println(user.getId() + " " + dates);

calDao cdao=calDao.getInstance();
List<CalendarDTO> cdtos=cdao.getDayList(user.getId(), dates);





/* for(int i=0;i < cdtos.size(); i++){
	out.println(cdtos.toString());
} */

%>

<table border="1">
<col width="100"/><col width="200"/><col width="450"/><col width="50"/>

<tr bgcolor="#09bbaa">
	<td>번호</td><td>시간</td><td>제목</td><td>삭제</td>
</tr>
<%
for(int i = 0;i < cdtos.size(); i++ ){
	CalendarDTO cald=cdtos.get(i);
	String tyear = cald.getRdate().substring(0,4) + "년";
	String tmonth = cald.getRdate().substring(4,6) + "월";
	String tday = cald.getRdate().substring(6,8) + "일";
	String thour = cald.getRdate().substring(8,10) + "시";
	String tmin = cald.getRdate().substring(10,12) + "분";
	%>
	<tr>
		<td><%=i+1 %></td>
		<td><%=tyear+tmonth+tday+thour+tmin %></td>
		<td>
			<a href="Caldetail.jsp?seq=<%=cald.getSeq() %>">
				<%=cald.getTitle() %>
			</a>
		</td>
		<td>
			<form action="Caldel.jsp" method="post">
				<input type="hidden" name='seq' value='<%=cald.getSeq() %>'/>
				<input type="submit" value="일정삭제">
			</form>
		</td>
	</tr>
	<%
}
%>
</table>

<%
String url=String.format("%s?year=%s&month=%s", 
				"Calendar.jsp", year, month);
%>

<a href='<%=url %>'>일정보기</a>

</body>
</html>









