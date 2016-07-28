<%@page import="java.util.Calendar"%>
<%@page import="odu_member.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>calwrite</title>
</head>
<body>


<h3>일정쓰기</h3>

<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

//out.println("year:" + year + "month:" + month + "day:" + day);

MemberDTO user=(MemberDTO)session.getAttribute("login");

Calendar cal=Calendar.getInstance();
int tyear=cal.get(Calendar.YEAR);
int tmonth=cal.get(Calendar.MONTH)+1;
int tday=cal.get(Calendar.DATE);
int thour=cal.get(Calendar.HOUR_OF_DAY);		//24시간
int tmin=cal.get(Calendar.MINUTE);

%>

<form action="CalendarAf.jsp" method="post">

<table border="1">
<col width="200"/><col width="500"/>

<tr>
	<td>아이디</td>
	<td><%=user.getId()%><input type="hidden" name="id" value="<%=user.getId()%>"></td>
</tr>

<tr>
	<td>제목</td>
	<td><input type="text" size="60" name="title"/> </td>
</tr>

<tr>
	<td>일정</td>
	<td>
		<select name='year'>
			<%
			for(int i=tyear-5; i < tyear + 5; i++){
				%>
				<option <%=year.equals(i+"")?"selected='selected'":"" %> value="<%=i %>"><%=i %></option>
				<%
			}
			%>	
		
		</select>년		
		<select name='month'>
					<%
			for(int i=1; i <= 12; i++){
				%>
				<option <%=month.equals(i+"")?"selected='selected'":"" %> value="<%=i %>"><%=i %></option>
				<%
			}
			%>	
		
		</select>월		
		<select name='day'>
			<%
			for(int i=1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++){
				%>
				<option <%=day.equals(i+"")?"selected='selected'":"" %> value="<%=i %>"><%=i %></option>
				<%
			}
			%>	
		
		</select>일		
		<select name='hour'>
			<%
			for(int i=0; i < 24; i++){
				%>
				<option <%=(thour+"").equals(i+"")?"selected='selected'":"" %> value="<%=i %>"><%=i %></option>
				<%
			}
			%>	
		
		</select>시		
		<select name='min'> 
			<%
			for(int i=0; i < 60; i++){
				%>
				<option <%=(tmin+"").equals(i+"")?"selected='selected'":"" %> value="<%=i %>"><%=i %></option>
				<%
			}
			%>	
		
		</select>분		

	</td>
</tr>

<tr>
	<td>내용</td>
	<td><textarea name="content" rows="20" cols="60"></textarea>
</tr>

<tr>
	<td colspan="2">
		<input type="submit" value="일정쓰기"/>
	</td>

</tr>

</table>

</form>

<%
String url=String.format("%s?year=%s&month=%s", "Calendar.jsp", year, month);
%>

<a href='<%=url %>'>일정보기</a>
</body>
</html>