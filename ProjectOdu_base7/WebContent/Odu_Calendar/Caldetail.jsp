<%@page import="odu_calendar.*"%>
<%@page import="odu_member.*"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>caldetail</title>
<script type="text/javascript">
function mysubmit(num){
	var f = document.fm;
	if(num == 1){
		f.action="Calendar.jsp";
	}
	if(num == 2){
		f.action="Calmod.jsp";
	}
	if(num == 3){
		f.action="Caldel.jsp";
	}
	f.submit();
}
</script>
</head>
<body>


<h3>일정확인</h3>

<%


//out.println("year:" + year + "month:" + month + "day:" + day);

MemberDTO user=(MemberDTO)session.getAttribute("login");
String sseq=request.getParameter("seq");
int seq=Integer.parseInt(sseq);

Calendar cal=Calendar.getInstance();
calDao dao=calDao.getInstance();
CalendarDTO cdto=dao.getCal(seq);
String tmp = cdto.getRdate();
String year = tmp.substring(0,4) + "년";
String month = tmp.substring(4,6) + "월";
String day = tmp.substring(6,8) + "일";
String si = tmp.substring(8,10) + "시";
String bun = tmp.substring(10,12) + "분";

%>

<form name="fm" method="post">

<table border="1">
<col width="200"/><col width="500"/>

<tr>
	<td>아이디</td>
	<td><%=user.getId()%><input type="hidden" name="id" value="<%=user.getId()%>"></td>
</tr>
<tr>
	<td>시간</td>
	<td><input type="text" size="60" name="title" value="<%=year+month+day+si+bun%>" readonly="readonly"/></td>
</tr>


<tr>
	<td>제목</td>
	<td><input type="text" size="60" name="title" value="<%=cdto.getTitle()%>" readonly="readonly"/></td>
</tr>



<tr>
	<td>내용</td>
	<td><textarea name="content" rows="20" cols="60" readonly="readonly"><%=cdto.getContent()%></textarea>
</tr>

<tr>
	<td colspan="2">
		<input type="hidden" name="seq" value="<%=cdto.getSeq()%>"/>
		<input type="button" onclick="mysubmit(1)" value="돌아가기"/>
		<input type="button" onclick="mysubmit(2)" value="수정"/>
		<input type="button" onclick="mysubmit(3)" value="삭제"/>
	</td>

</tr>

</table>

</form>

</body>
</html>