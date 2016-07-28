<%@page import="odu_member.MemberDTO"%>
<%@page import="odu_calendar.*"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import='java.util.Calendar' %>
<%@page import='java.util.List' %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>달력</title>


</head>
<body>

<%!
public boolean nvl(String msg){
	return msg==null || msg.trim().equals("")?true:false; 	
}

public String callist(int year, int month, int day){
	String s="";	
	s+=String.format("<a href='%s?year=%d&month=%d&day=%d'>", 
					"Callist.jsp", year, month, day);
	s+=String.format("%2d", day);
	s+="</a>";
	return s;	
}

public String showpen(int year, int month, int day){
	String s="";
	String url="Calwrite.jsp";
	String image="<img src='../image/pen.gif'/>";
	s=String.format("<a href='%s?year=%d&month=%d&day=%d'>%s</a>"
					, url, year, month, day, image);
	return s;	
}

public String two(String msg){
	return msg.trim().length() < 2 ? "0"+msg : msg.trim();
}

// 제목이 15자 이상이면, ...로 표시하기 위한 함수
public String dot3(String msg){
	String s="";
	if(msg.length() >= 15){
		s = msg.substring(0, 15);
		s += "...";
	}else{
		s = msg.trim();
	}
	return s;
}

public String makeTable(int year, int month, int day, List<CalendarDTO> lcdtos){
	String s="";
	String dates=(year+"")+two(month+"")+two(day+"");
	s="<table>";
	s+="<col width='98'/>";
	for(CalendarDTO lcd:lcdtos){
		if(lcd.getRdate().substring(0, 8).equals(dates)){
			s += "<tr>";
			s += "<td>";
			s += "<a href='Caldetail.jsp?seq="+lcd.getSeq()+"'>";
			s += "<font style='font-size:8; color:blue'>";
			s += dot3(lcd.getTitle());
			s += "</font>";
			s += "</a>";
			s += "</td>";
			s += "</tr>";			
		}
	}
	s += "</table>";
	return s;
}


%>

<h1>my 달력</h1>

<%
Calendar cal = Calendar.getInstance();	// 오늘날짜
cal.set(Calendar.DATE, 1);

String syear = request.getParameter("year");
String smonth = request.getParameter("month");

int year = cal.get(Calendar.YEAR);
if(!nvl(syear)){
	year = Integer.parseInt(syear);
}

int month = cal.get(Calendar.MONTH)+1;
if(!nvl(smonth)){
	month = Integer.parseInt(smonth);
}

if(month < 1){	month=12;	year--; }
if(month > 12){ month=1;	year++; }

cal.set(year, month-1, 1);

// 요일(1 ~ 7) 1:일요일
int dayOfWeek=cal.get(Calendar.DAY_OF_WEEK);	// 6

////////////////////////////////
calDao dao = calDao.getInstance();
MemberDTO user=(MemberDTO)session.getAttribute("login");

List<CalendarDTO> cdtos=dao.getCalendarList(user.getId(), year+two(month+""));


/* String sf = String.format("%d년 %d월", year, month);
String sleft = String.format("calendar.jsp?year=%d&month=%d", year, month-1);
String sright = String.format("calendar.jsp?year=%d&month=%d", year, month+1);
 */

 String pp=String.format("<a href='./%s?year=%d&month=%d'><img src='../image/left.gif'/></a>", 
 						"calendar.jsp", year-1, month);
 
 String p=String.format("<a href='./%s?year=%d&month=%d'><img src='../image/prec.gif'/></a>", 
						"calendar.jsp", year, month-1);
 
 String nn=String.format("<a href='./%s?year=%d&month=%d'><img src='../image/last.gif'/></a>", 
						"calendar.jsp", year+1, month);
 
 String n=String.format("<a href='./%s?year=%d&month=%d'><img src='../image/next.gif'/></a>", 
						"calendar.jsp", year, month+1);
 
 
%>


<table border="1">
<col width="120"/><col width="120"/><col width="120"/>
<col width="120"/><col width="120"/><col width="120"/>
<col width="120"/>
<%-- <tr class='date'>
	<td colspan="7">
		<a href='<%=sleft %>'>
			<img src="image/left.png"/>
		</a>
		<%=sf %>
		<a href='<%=sright %>'>
			<img src="image/right.png"/>
		</a>
	</td>
</tr> --%>

<tr height="100">
	<td colspan="7" align="center">
		<%=pp %><%=p %>	
		<font color="red" size="10">
			<%=String.format("%d년&nbsp;&nbsp;%d월", year, month) %>
		</font>
		<%=n %><%=nn %>
	</td>
</tr>


<tr height="100" align="center">
	<td valign="middle">일</td>
	<td>월</td>
	<td>화</td>
	<td>수</td>
	<td>목</td>
	<td>금</td>
	<td>토</td>
</tr>

<tr height="100" align="left" valign="top">
<%
for(int i = 1;i < dayOfWeek; i++){
	%>
	<td>&nbsp;</td>
	<%	
}
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
for(int i = 1;i <= lastDay; i++){
	%>	
	
	<td><%=callist(year, month, i)%>&nbsp;<%=showpen(year, month, i)%>
	<%=makeTable(year, month, i, cdtos) %>	
	</td>
	<%-- <td height="100" align="left" valign="top">
		<%=i %>
		<a href='calwrite.jsp?year=<%=year %>&month=<%=month %>&day=<%=i %>'>
			<img src='image/pen.gif'/>
		</a>
	</td> --%>
	
	<%
	if((i+dayOfWeek-1)%7==0){	// 개행
	%>
		</tr><tr height="100" align="left" valign="top">
	<%
	}
}

for(int i = 0;i < (7-(dayOfWeek+lastDay-1)%7)%7; i++){
	%>
	<td>&nbsp;</td>	
	<%
}
%>
</tr>




</table>


</body>
</html>




