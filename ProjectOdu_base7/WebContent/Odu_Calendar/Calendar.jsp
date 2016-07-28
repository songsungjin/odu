<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="odu_member.MemberDTO"%>
<%@page import="odu_calendar.*"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import='java.util.Calendar' %>
<%@page import='java.util.List' %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="../css/w3.css">
 <link rel="stylesheet" href="../css/w3-theme-blue-grey.css">
<title>오늘부터 듀오</title>


<script type="text/javascript">
function change(url){
	   location.href=url;
}
</script>


<style>
html,body,h1,h2,h3,h4,h5 {font-family: "Open Sans", sans-serif}
</style>
<body class="w3-theme-l5">

<!-- Navbar -->
<div class="w3-top">
 <ul class="w3-navbar w3-theme-d2 w3-left-align w3-large">
  <li class="w3-hide-medium w3-hide-large w3-opennav w3-right">
    <a class="w3-padding-large w3-hover-white w3-large w3-theme-d2" href="javascript:void(0);" onclick="openNav()"><i class="fa fa-bars"></i></a>
  </li>
  <li><a href="#" class="w3-padding-large w3-theme-d4"><i class="fa fa-home w3-margin-right"></i><img src="../image/logo1.png"></a></li>
  <li class="w3-hide-small"><a href="#" class="w3-padding-large w3-hover-white" title="News"><i class="fa fa-globe"></i><img src="../m1.png"></a></li>
  <li class="w3-hide-small"><a href="#" class="w3-padding-large w3-hover-white" title="Account Settings"><i class="fa fa-user"></i><img src="../chaticon1.png"></a></li>


  <li class="w3-hide-small w3-right"><button type="button" class="w3-btn w3-theme"><i class="fa fa-pencil"></i>로그아웃</button></li>
 </ul>
</div>

<!-- 위에 아이콘 -->
<div id="navDemo" class="w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:51px">
  <ul class="w3-navbar w3-left-align w3-large w3-theme">
    <li><a class="w3-padding-large" href="#">321332133131313</a></li>
    <li><a class="w3-padding-large" href="#">Link 2</a></li>
    <li><a class="w3-padding-large" href="#">Link 3</a></li><!--  링크 부분-->
    <li><a class="w3-padding-large" href="#">My Profile</a></li>
  </ul>
</div>

<!-- 전체 페이지 시작 -->
<div class="w3-container w3-content" style="max-width:1400px;margin-top:80px;  "  >
  <!-- The Grid -->
  <div class="w3-row">
    <!-- 왼쪽 시작 -->
    <div class="w3-col m14" >
      <!-- 프로필 부분 -->
      <div class="w3-card-2 w3-round w3-white">
        <div class="w3-container">
         <h4 class="w3-center">My Profile</h4>
         <p class="w3-center"><img src="../image/pro.png" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
         <hr>
         <p><i class="fa fa-pencil fa-fw w3-margin-right w3-text-theme"></i> 개발자</p>
         <p><i class="fa fa-home fa-fw w3-margin-right w3-text-theme"></i> 서울</p>
         <p><i class="fa fa-birthday-cake fa-fw w3-margin-right w3-text-theme"></i> 1988년생 2월 2일</p>
        </div>
      </div>
      <br>
      
      <!--왼쪽 메뉴 바 -->
      <div class="w3-card-2 w3-round">
        <div class="w3-accordion w3-white" >
    	 <button onclick="change('../Odu_timeline/timeline.jsp')" class="w3-btn-block w3-theme-l1 w3-left-align"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i> 타임라인</button>
          <button onclick="change('../Odu_Calendar/Calendar.jsp')" class="w3-btn-block w3-theme-l1 w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i>일정관리 </button>
           <button onclick="change('../Odu_together/together.jsp')" class="w3-btn-block w3-theme-l1 w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i> 같이해요</button>
          <button onclick="" class="w3-btn-block w3-theme-l1 w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i> 자유게시판</button>
          <button onclick="" class="w3-btn-block w3-theme-l1 w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i> 재판게시판</button>
         
          <button onclick="myFunction('Demo3')" class="w3-btn-block w3-theme-l1 w3-left-align"><i class="fa fa-users fa-fw w3-margin-right"></i> 피플</button>
          <div id="Demo3" class="w3-accordion-content w3-container">
         <div class="w3-row-padding">
         <br>
            <div class="w3-quarter">
             <img src="../image/pro1.png" style="width:50px" class="w3-margin-bottom w3-circle w3-hover-opacity">
           </div>
          <div class="w3-quarter">
             <img src="../image/pro2.png" style="width:50px" class="w3-margin-bottom w3-circle w3-hover-opacity">
           </div>
           <div class="w3-quarter">
              <img src="../image/pro3.png" style="width:50px" class="w3-margin-bottom w3-circle w3-hover-opacity">
           </div>
         
         </div>
          </div>
        </div>
      </div>
      <br>
      
  
    </div>
    
    <!-- 왼쪽 끝 -->
   
    
    <!-- 중간 시작 -->
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
 						"Calendar.jsp", year-1, month);
 
 String p=String.format("<a href='./%s?year=%d&month=%d'><img src='../image/prec.gif'/></a>", 
						"Calendar.jsp", year, month-1);
 
 String nn=String.format("<a href='./%s?year=%d&month=%d'><img src='../image/last.gif'/></a>", 
						"Calendar.jsp", year+1, month);
 
 String n=String.format("<a href='./%s?year=%d&month=%d'><img src='../image/next.gif'/></a>", 
						"Calendar.jsp", year, month+1);

%>

<table class="w3-table-all caltable">
<col width="85"/><col width="85"
><col width="85"/>
<col width="85"/><col width="85"/><col width="85"/>
<col width="85"/>
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

<tr height="30">
	<td colspan="7" align="center">
		<%=pp %><%=p %>	
		<font color="red" size="5">
			<%=String.format("%d년&nbsp;&nbsp;%d월", year, month) %>
		</font>
		<%=n %><%=nn %>
	</td>
</tr>


<tr height="85" align="center">

	<td valign="middle"><font color="red" size="1">일</font></td>
	<td><font color="RGB(90,90,90)" size="1">월</font></td>
	<td><font color="RGB(90,90,90)" size="1">화</font></td>
	<td><font color="RGB(90,90,90)" size="1">수</font></td>
	<td><font color="RGB(90,90,90)" size="1">목</font></td>
	<td><font color="RGB(90,90,90)" size="1">금</font></td>
	<td><font color="blue" size="1">토</font></td>

</tr>

<tr height="85" align="left" valign="top">
<%
for(int i = 1;i < dayOfWeek; i++){
	%>
	<td>&nbsp;</td>
	<%	
}
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
for(int i = 1;i <= lastDay; i++){
	%>	
	
	<td><font size="1" color="RGB(90,90,90)"><%=callist(year, month, i)%>&nbsp;<%=showpen(year, month, i)%>
	<%=makeTable(year, month, i, cdtos) %><img src="../image/cake.png" onmouseover="alert('생일입니다.')">
	</font></td>
	<%-- <td height="100" align="left" valign="top">
		<%=i %>
		<a href='calwrite.jsp?year=<%=year %>&month=<%=month %>&day=<%=i %>'>
			<img src='image/pen.gif'/>
		</a>
	</td> --%>
	
	<%
	if((i+dayOfWeek-1)%7==0){	// 개행
	%>
		</tr><tr height="85" align="left" valign="top">
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
       


  <!--   중간 끝 -->

  
    </div>
    <!-- <div class="w3-col m7">
		<iframe src = "Odu_timeline/timeline.jsp" width="100%" height="100%" frameborder="0" border="0" scrolling="yes" bgcolor=#EEEEEE bordercolor="#FF000000" marginwidth="0" marginheight="0" name="main_frame" id="main_frame"></iframe> 

	</div> -->

    <!-- 오른쪽 시작 -->
    <div class="w3-col m13" >
      <div class="w3-card-2 w3-round w3-white w3-center">
        <div class="w3-container">
          <p>오늘의 일정</p>
        
          <p><strong>원빈님이랑 밥먹기</strong></p>
          <p>금요일 15:00</p>
          <p><button class="w3-btn w3-btn-block w3-theme-l4">일정보기</button></p>
        </div>
      </div>
      <br>
      
    
 
    <!-- 오른 쪽끝  -->
    </div>
    
  <!-- End Grid -->
  </div>  
  </table>
  
<!-- End Page Container -->
</div>
<br>



 
<script>
// Accordion
function myFunction(id) {
    var x = document.getElementById(id);
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
        x.previousElementSibling.className += " w3-theme-d1";
    } else {
        x.className = x.className.replace("w3-show", "");
        x.previousElementSibling.className =
        x.previousElementSibling.className.replace(" w3-theme-d1", "");
    }
}

// Used to toggle the menu on smaller screens when clicking on the menu button
function openNav() {
    var x = document.getElementById("navDemo");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}
</script>

</body>
</html>