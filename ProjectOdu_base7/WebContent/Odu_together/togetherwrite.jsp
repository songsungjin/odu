<%@page import="odu_member.*"%>
<%@page import="java.util.*" %>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>together</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">
$(document).ready(function(){	// 보기 설정을 보여주는 부분
	for(i=5;i<=10; i++){
		$('#poll'+i).hide();	// 숨김
	}
});

function pollchange(me){	// 보기의 갯수를 수정하는 함수
	
	var num=me.options[me.selectedIndex].value;	// 2번을 선택하면 Index값으로 2가 넘어 온다
	alert('num=' + num);
	
	for(i = 1;i <= 10; i++){
		$('#poll'+i).val("");
		$('#poll'+i).hide(); // 숨김
	}
	for(i = 1;i <= num; i++){
		$('#poll'+i).show()	// 보임	
	}
}
</script>

</head>
<body>

<%
MemberDTO user=(MemberDTO)session.getAttribute("login");

Calendar cal = Calendar.getInstance();
int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) + 1;
int tday = cal.get(Calendar.DATE);

%>

<h3>같이해요~</h3>

<form action="togetherwriteAf.jsp" method="post" enctype="multipart/form-data">
<table border="1" bgcolor="pink">
<col width="200"/><col width="500"/>

<tr>
	<td>아이디</td>
	<td>
		<%=user.getId() %>
		<input type="hidden" name="id" value='<%=user.getId() %>'/>
	</td>
</tr>
<tr>
<td>제목</td>
	<td>
	<select name="title_select">
	<option selected="selected" value="0" id="select">선택</option>
	<option value="[밥먹자~]">[밥먹자~]</option>
	<option value="[영화보자~]">[영화보자~]</option>
	<option value="[카페가서 수다 ㄱㄱ다]">[카페가서 수다 ㄱㄱ다]</option>
	<option value="[기타]">[기타]</option>
	</select>
	<input type="text"name="title"/>
	</td>
</tr>
<tr>
	<td>모집마감일자</td>
	<td>
		<select name='eyear'>
			<%
			for(int i = tyear;i < tyear + 6; i++ ){
				%>
				<option <%=(tyear+"").equals(i+"")?"selected='selected'":"" %> value="<%=i%>"><%=i%></option>
				<%
			}%>			
		</select>년
		<select name='emonth'>
			<%
			for(int i = 1;i <= 12; i++ ){
				%>
				<option <%=(tmonth+"").equals(i+"")?"selected='selected'":"" %> value="<%=i%>"><%=i%></option>
				<%
			}%>			
		</select>월
		<select name='eday'>
			<%
			for(int i = 1;
					i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++ ){
				%>
				<option <%=(tday+"").equals(i+"")?"selected='selected'":"" %> value="<%=i%>"><%=i%></option>
				<%
			}%>			
		</select>일	
	</td>
</tr>

<tr>
	<td>모집 내용</td>
	<td>
		<textarea name='content' rows="10" cols="50"></textarea>
	</td>
</tr>

<tr>
	<td>모집 인원수</td>
	<td>
		<select name='itemcount' onchange="pollchange(this)">
			<%
			for(int i = 1;i <= 20; i++){
				%>
				<option <%=(4+"").equals(i+"")?"selected='selected'":"" %> value="<%=i %>"><%=i %></option>
				<%				
			}
			%>
		</select>명
	</td>
</tr>

<tr>
	<td>사진첨부</td>
	<td>
		<input type="file" name="fileload" style="width:400px;"/>
	</td>
</tr>
<tr align="center">
	<td colspan="2"><input type="submit" value="모집등록" id="btn"></td>
</tr>


</table>
</form>
<a href="together.jsp">같이해요 글목록</a>
</body>
</html>



