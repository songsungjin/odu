<%@page import="odu_bbs.bbsDAO"%>
<%@page import="odu_bbs.bbsDTO"%>
<%@page import="odu_member.MemberDTO"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bbslist</title>

<style type="text/css">
table{
	border-collapse: collapse;	
}
table, th, td{
	border: 1px solid black;
}
th{
	background-color: green;
	color: white;
}
.tda{
	background-color: #abcdef;
	color:black;
}
.tdb{
	background-color: #febdab;
	color:black;	
}
</style>

</head>
<body>

<%!
public String arrow(int depth){	
	String rs="<img src='image/arrow.png' width='20px' height='20px'/> ";
	String nbsp="&nbsp;&nbsp;&nbsp;&nbsp;";
	String ts="";
	
	for(int i = 0;i < depth; i++){
		ts += nbsp;
	}
	return depth==0?"":ts+rs;		
}
/*
	ref	- 부모글 번호
	step - 답글번호		횡측 번호 
	depth - 답글답글	종측 번호
*/
%>

<%
Object objlogin=session.getAttribute("login");
MemberDTO mem=null;
if(objlogin==null){
	%>
	<script type="text/javascript">
		alert('로그인 하십시오.');
		location.href='index.jsp';
	</script>
	<%
	return;
}
mem=(MemberDTO)objlogin;
%>


<h3>환영합니다. <%=mem.getId() %>님 반갑습니다.</h3>

<a href='calendar.jsp'>일정보기</a>

<a href='pdslist.jsp'>자료실</a>

<a href='logout.jsp'>로그아웃</a>

<hr/>

<%
bbsDAO tdao=bbsDAO.getInstance();
List<bbsDTO> bbslist=tdao.getbbslist();
%>


<div align="center">

<table border="1">
<col width="50"><col width="500"><col width="150">

<tr>
	<th>순서</th><th>제목</th><th>작성자</th>
</tr>

<%
if(bbslist == null || bbslist.size() == 0){
	%>
	<tr>
		<td colspan="3">작성된 글이 없습니다</td>
	</tr>
	<%
}


for(int i = 0;i < bbslist.size(); i++){
	bbsDTO bbs=bbslist.get(i);
	%>
	<tr <%=i%2==0?"class='tda'":"class='tdb'"%>>
		<td><%=i+1 %></td>
		<td>
			<%=arrow(bbs.getDepth())%>
			<%if(bbs.getDel()==1){ 
				out.println("이 글은 삭제 되었습니다.");
			}else{			
			%>						
				<a href='bbsdetail.jsp?seq=<%=bbs.getSeq()%>'>
				<% System.out.println("seq = " + bbs.getSeq()); %>
					<%=bbs.getTitle() %>
				</a>
			<%} %>			
		</td>
		<td><%=bbs.getId() %></td>	
	</tr>	
	<%
}
%>


</table>
</div>





<a href='bbswrite.jsp'>글 쓰기</a>


</body>
</html>






