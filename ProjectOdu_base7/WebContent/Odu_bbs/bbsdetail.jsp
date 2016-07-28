<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="odu_bbs.bbsDAO"%>
<%@page import="odu_bbs.bbsDTO"%>
<%@page import="odu_bbs.bbsRepleDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상세 글보기</title>

<style type="text/css">
.center{
	margin:auto;
	width:60%;
	border:3px solid #8AC007;
	padding:10px;
}
input{
	size:50;
}
</style>

</head>
<body>
<a href='logout.jsp'>로그아웃</a>

<h1>상세 글보기</h1>

<div class='center'>
<%
String sseq=request.getParameter("seq");
int seq=Integer.parseInt(sseq);	//trim()

System.out.println("seq = " + seq);


bbsDAO dao=bbsDAO.getInstance();
dao.readCount(seq);
bbsDTO bbsdto=dao.getBBS(seq);

/* System.out.println(bbs.toString()); */
%>

<table border="1">

<tr>
	<td>작성자</td>
	<td><%=bbsdto.getId() %></td>
</tr>

<tr>
	<td>제목</td>
	<td><%=bbsdto.getTitle() %></td>
</tr>

<tr>
	<td>작성일</td>
	<td><%=bbsdto.getWdate() %></td>
</tr>

<tr>
	<td>조회수</td>
	<td><%=bbsdto.getReadcount() %></td>
</tr>

<tr>
	<td>정보</td>
	<td><%=bbsdto.getRef()%>-<%=bbsdto.getStep()%>-<%=bbsdto.getDepth()%></td>
</tr>

<tr>
	<td>내용</td>
	<td><textarea rows="10" cols="50" 
	name='content'><%=bbsdto.getContent() %></textarea>
	</td>
</tr>	
</table>

<form action="answer.jsp" method="post">
	<input type="hidden" name='seq' value="<%=bbsdto.getSeq() %>"/>
	<input type="submit" value="답글">
</form>

<br>

<form action="reple.jsp" method="post">
	<input type="hidden" name='seq' value="<%=bbsdto.getSeq() %>"/>
	<input type="submit" value="삭제">
</form>
<hr>

<div style=" width: 600px; height: 150px; background-color: #79a099; ">
<form action="reple.jsp" method="post">
<table>
<col width="30"/><col width="350"/><col width="10">
<tr>
	<td><%=bbsdto.getId()%> 
	<input type="hidden" name="repid" value="<%=bbsdto.getId()%>" /> 
	<input type="hidden" name="seq_rep" value="<%=bbsdto.getSeq()%>" /> 
	</td>
	<td colspan="2"><textarea name="reple" rows="8" cols="50"></textarea> </td>
</tr>
<tr>
	<td></td>
	<td></td>
	<td><input type="submit"  value="입력"></td>
</tr>
</table>
</form>
<hr>

<%

bbsDAO dao1 = bbsDAO.getInstance();
List<bbsRepleDTO> replelist = dao1.getreplelist(2,seq);
if(replelist.size() >= -1){
%>
	<table border="2">
	<col width="350"/>
	<%
	for(int i = 0; i < replelist.size(); i++){
		bbsRepleDTO repledto = replelist.get(i);
		%>
		<tr>
		<td>
			<%=repledto.getId()%>
			<%
			String str = repledto.getWdate();
			
			String year = str.substring(2, 4);
			String month = str.substring(5, 7);
			String day = str.substring(8, 10);
			String hour = str.substring(11, 13);
			String min = str.substring(14, 16);
			
			String todate = year + "/" + month + "/" + day + " " +  hour + ":" + min;
			%>
			<font size="1px">
			<%=todate %>
			</font>
		</td>
	</tr>
	<tr>
		<td colspan="2">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=repledto.getContent() %>
		</td>
	</tr>
		<%
	}
	%>
	</table>
<%
}
%>

</div>

<a href="bbslist.jsp">글 목록</a>

</body>
</html>



