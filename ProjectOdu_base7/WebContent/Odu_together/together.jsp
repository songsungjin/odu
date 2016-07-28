<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="odu_member.*" %>
<%@ page import="odu_together.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<style type="text/css">
a{
	color: white;
	text-decoration: none;
}
</style>
<!-- <link rel="stylesheet" href="css/style.css"> -->
</head>
<body>
<%! 
public String arrow(int depth){ // 답변글용
	String rs = "<img src='image/arrow.png' width='15px' height='15px'/>";
	String nbsp = "&nbsp;&nbsp;&nbsp;";
	String ts = "";
	
	for(int i = 0; i < depth; i++){
		ts += nbsp;
	}
	
	return depth == 0 ? "":ts + rs;
}
public Integer toInt(String x){
	int a = 0;
	try{
		a = Integer.parseInt(x);
	}catch(Exception e){}
	return a;
}
%>
<!--페이징 처리부분 -->
<%
	togetherDAO dao= togetherDAO.getInstance();
	List<togetherDTO> bbslist = dao.getTogether();
	int pageno = toInt(request.getParameter("pageno"));
	if(pageno<1){//현재 페이지
		pageno = 1;
	}
	int total_record = bbslist.size();		   //총 레코드 수
	int page_per_record_cnt = 10;  //페이지 당 레코드 수
	int group_per_page_cnt =5;     //페이지 당 보여줄 번호 수[1],[2],[3],[4],[5]
//					  									  [6],[7],[8],[9],[10]											

	int record_end_no = pageno*page_per_record_cnt;				
	int record_start_no = record_end_no-(page_per_record_cnt);
	if(record_end_no>total_record){
		record_end_no = total_record;
	}
										   
										   
	int total_page = total_record / page_per_record_cnt + (total_record % page_per_record_cnt>0 ? 1 : 0);
	if(pageno>total_page){
		pageno = total_page;
	}


	

// 	현재 페이지(정수) / 한페이지 당 보여줄 페지 번호 수(정수) + (그룹 번호는 현제 페이지(정수) % 한페이지 당 보여줄 페지 번호 수(정수)>0 ? 1 : 0)
	int group_no = pageno/group_per_page_cnt+( pageno%group_per_page_cnt>0 ? 1:0);
//		현재 그룹번호 = 현재페이지 / 페이지당 보여줄 번호수 (현재 페이지 % 페이지당 보여줄 번호 수 >0 ? 1:0)	
//	ex) 	14		=	13(몫)		=	 (66 / 5)		1	(1(나머지) =66 % 5)			  
	
	int page_eno = group_no*group_per_page_cnt;		
//		현재 그룹 끝 번호 = 현재 그룹번호 * 페이지당 보여줄 번호 
//	ex) 	70		=	14	*	5
	int page_sno = page_eno-(group_per_page_cnt-1);	
// 		현재 그룹 시작 번호 = 현재 그룹 끝 번호 - (페이지당 보여줄 번호 수 -1)
//	ex) 	66	=	70 - 	4 (5 -1)
	
	if(page_eno>total_page){
//	   현재 그룹 끝 번호가 전체페이지 수 보다 클 경우		
		page_eno=total_page;
//	   현재 그룹 끝 번호와 = 전체페이지 수를 같게
	}
	
	int prev_pageno = page_sno-group_per_page_cnt;  // <<  *[이전]* [21],[22],[23]... [30] [다음]  >>
//		이전 페이지 번호	= 현재 그룹 시작 번호 - 페이지당 보여줄 번호수	
//	ex)		46		=	51 - 5				
	int next_pageno = page_sno+group_per_page_cnt;	// <<  [이전] [21],[22],[23]... [30] *[다음]*  >>
//		다음 페이지 번호 = 현재 그룹 시작 번호 + 페이지당 보여줄 번호수
//	ex)		56		=	51 - 5
	if(prev_pageno<1){
//		이전 페이지 번호가 1보다 작을 경우		
		prev_pageno=1;
//		이전 페이지를 1로
	}
	if(next_pageno>total_page){
//		다음 페이지보다 전체페이지 수보가 클경우		
		next_pageno=total_page/group_per_page_cnt*group_per_page_cnt+1;
//		next_pageno=total_page
//		다음 페이지 = 전체페이지수 / 페이지당 보여줄 번호수 * 페이지당 보여줄 번호수 + 1 
//	ex)			   = 	76 / 5 * 5 + 1	???????? 		
	}
	
	// [1][2][3].[10]
	// [11][12]
%>

<!--리스트부분  -->
<% 

Object ologin = session.getAttribute("login");
MemberDTO mem = null;
if(ologin == null){
	%>
	<script>
	alert("로그인하십시오.");
	location.href="index.jsp";
	</script>
	<%
	return;
}
mem =(MemberDTO)ologin;
%>
<hr>


<div class="containerbbs">
<h1 class="bbsHead">같이해요~</h1>
<form>
<table class="table">
<col width="50"/><col width="500"/><col width="150"/>
<tr class="main_tr">
	<th>번호</th><th >제목</th><th>작성자</th>
</tr>
<%
if(bbslist == null || bbslist.size() == 0){
	%>
	<tr><td colspan="3">작성된 글이 없습니다.</td></tr>
	<% 
}
for(int i = record_start_no; i < record_start_no+page_per_record_cnt; i++){
	if(bbslist.size() == i) break;
	togetherDTO dto = bbslist.get(i);
	
	%>
	<%-- <tr class="content_st">
		<td><%=i+1 %></td>
		<td style="text-align: left; padding-left: 20px;"><%=arrow(dto.getDepth()) %> 답글인지 아닌지
		<%if(dto.getDel() == 1){
		%>이 글은 삭제 되었습니다.<% }else{ %>
			<a style="color: #030066; text-decoration: none;" href="bbsdetail.jsp?seq=<%=dto.getSeq()%>&title=<%=dto.getTitle()%>"><%=dto.getTitle() %></a>
						  <!-- jsp?넘기고싶은 값. &를 이용해서 계속 넘길수 있다. -->
		<%} %></td>
		<td><%=dto.getId() %></td>
	</tr> --%>
<%
}
%>
</table>
</form><hr>
<div align="center" style="color:white;">
<a href="together.jsp?pageno=1">[맨앞으로]</a>
<a href="together.jsp?pageno=<%=prev_pageno%>">[이전]</a> 
<%for(int i =page_sno;i<=page_eno;i++){%>
	<a href="together.jsp?pageno=<%=i %>">
		<%if(pageno == i){ %>
			[<%=i %>]
		<%}else{ %>
			<%=i %>
		<%} %>
	</a> 
<%--	콤마	 --%>	
	<%if(i<page_eno){ %>
		,
	<%} %>
<%} %>
<a href="together.jsp?pageno=<%=next_pageno%>" >[다음]</a>
<a href="together.jsp?pageno=<%=total_page %>">[맨뒤로]</a>
</div>
<table class="table1">
<tr>

<form action="search.jsp">
<td><select id="selectbox" name="selectbox">
	<option value = "1" selected>제목</option>
	<option value = "2">내용</option>
	<option value = "3">작성자</option>
	</select>
<input type="text" name="search_data"/><input type="submit" class="btn_bbs1" value="search"/></td>
</form>
<td><a href="togetherwrite.jsp"><button class="btn_bbs">Write</button></a></td>
</tr>
</table>
</div>
</body>
</html>