<%@page import="odu_bbs.bbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>test_reple.jsp</title>
</head>
<body>

<%-- 넘어온 데이터 확인
seq : <%=seq %>
id : <%=id %>
reple : <%=reple %>
 --%>
<%

String sseq=request.getParameter("seq_rep");
System.out.println("sseq = " + sseq);

int seq=Integer.parseInt(sseq);	//trim()
String id = request.getParameter("repid");
String reple = request.getParameter("reple");

bbsDAO dao = bbsDAO.getInstance();

boolean isS = dao.repleInsert(2, seq, id, reple);

if(isS){
%>
	<script type="text/javascript">
		alert("입력 성공");
		location.href='bbsdetail.jsp?seq=<%=seq%>';
	</script>
<%
}else{
	%>
		<script type="text/javascript">
			alert("입력 실패");
			location.href='bbsdetail.jsp?seq=<%=seq%>';
		</script>
	<%
}
%>

</body>
</html>