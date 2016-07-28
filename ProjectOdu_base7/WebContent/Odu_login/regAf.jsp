<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="odu_member.MemberDAO" %>
<%@ page import="odu_member.MemberDTO" %>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String sexx = request.getParameter("sex");
int sex = Integer.parseInt(sexx);

String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String birth = year + "/" + month + "/" + day;

String address = request.getParameter("location");
String job = request.getParameter("job");
String email = request.getParameter("email");
/* out.print(id + "/" + pw + "/"+ name + "/"+ sex + "/"+ birth + "/"
+ address + "/" + job + "/" + email + "") */;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
MemberDAO dao = MemberDAO.getInstance();

boolean isS = dao.insertMember(new MemberDTO(id, pw, name, sex, birth, address, job, email, 0));

if(isS){
%>
	<script type="text/javascript">
	alert("가입 축하!!");
	location.href="index.jsp";
	</script>
<%
}else {
	%>
	<script type="text/javascript">
	alert("가입 다시 ㄱㄱ");
	location.href="reg.jsp";
	</script>
	<%
}
%>
</body>
</html>