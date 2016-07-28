<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="odu_member.MemberDAO" %>
<%@ page import="odu_member.MemberDTO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	MemberDAO dao = MemberDAO.getInstance();
	MemberDTO mem = dao.login(new MemberDTO(id, pw));
	
if(mem != null && !mem.getId().equals("")){
	session.setAttribute("login", mem);
	session.setMaxInactiveInterval(30*60);
%>
	<script type="text/javascript">
	location.href="../mainHome.jsp";
	</script>
	<%
}else{	
%>
	<script type="text/javascript">
		alert("ID나 PW를 확인하십시오");
		location.href='../index.jsp';
	</script>
<%
}
%>
</body>
</html>