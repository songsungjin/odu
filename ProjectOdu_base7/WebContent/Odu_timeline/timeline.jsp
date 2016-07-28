<%@page import="odu_member.MemberDTO"%>
<%@page import="odu_timeline.timelineDTO"%>
<%@page import="java.util.List"%>
<%@page import="odu_timeline.timelineDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TimeLine</title>
</head>
<body>
<%
Object objlogin = session.getAttribute("login");
MemberDTO mem = (MemberDTO)objlogin;
%>

<div id = "wrap">

<form action="fileupload.jsp" method="post" enctype="multipart/form-data">
   <table border="1">
      <tr>
         <td>제목</td>
         <td><input type="text" name="title"  size="50"/></td>
      </tr>
      
      <tr>
         <td>작성자</td>
         <td><%=mem.getId() %></td>
         <input type="hidden" name='id' value="<%=mem.getId()%>">
      </tr>
      
      <tr>
         <td>내용</td>
         <td>
            <textarea rows="10" cols="38" name="content"></textarea>
         </td>
      </tr>
      
      <tr>
         <td>사진 추가</td>
         <td>
            <input type="file" name="fileload" style="width:400px;">
         </td>
      </tr>
      
      <tr align="center">
         <td colspan="2">
            <input type="submit" value="올리기"/>
            <input type="reset" value="취소"/>
         </td> 
      </tr>
   </table>
</form>   <%-- end of form --%>

<br>


<%
// 타임라인 뿌리기
String id = mem.getId();	// 세션 아이디 저장

timelineDAO dao = timelineDAO.getInstance();
List<timelineDTO> tlist = dao.getTimeLineList(id);

String fupload = application.getRealPath("/upload");
System.out.println("fupload-> " + fupload);

String filePath="";

%>

<%
for(int i = 0; i < tlist.size(); i++){
   timelineDTO tdto = tlist.get(i);

   %>
   <div class="timeline">
      <%
      if( tdto.getDel() == 1 ){
         %>
      <div>
      작성자에 의해 자료가 삭제되었습니다. 원래는 그냥 삭제 아닌가
      </div>
      <%
      }else{
   %>
      <table>
         <tr>            
            <td rowspan="3">프로필 사진</td>
         </tr>
         
         <tr>            
            <td><%=tdto.getId() %></td>
         </tr>   
         
         <%
         String time = tdto.getWdate();
         time = time.substring(0,16);
         %>
         <tr>
            <td><%=time %></td>
         </tr>
         
         <tr>
            <td colspan="2">
               <textarea rows="10" cols="38" readonly="readonly">
                  <%=tdto.getContent() %>
               </textarea>
            </td>
         </tr>
         
         <tr>
            <td colspan="2">
               <img src="D:\j\jspstudy\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ProjectOdu\upload\<%=tdto.getF_name() %>"> 
            </td>
         </tr>
         
<%!
public void likeit(){
   
}
%>   

<script>
$(document).ready(function(){
   
   $("#like").onclick(function(){
       alert('Handler for .mousedown() called.');
   });
});

function likeit(){
   alert('이베트 발생');
   // dao에 가서 like 버튼에 1추가
   // 0이면 1을 추가, 0이 아닐 때  %2가 1이면 좋아요 취소, 0이면 좋아요 한 상태.
   // 아이디가 없으면 추가 있으면 삭제
   
}
</script>
         <tr>
            <td colspan="2">
               <button id="like" onclick="likeit()">좋아요</button>
               <input type="button" value="댓글달기"> 
            </td>
         </tr>
      </table>   
   </div>
   <%
   }
}
%>
<div>


</div>

</div>   <%-- end of wrap --%>
</body>
</html>