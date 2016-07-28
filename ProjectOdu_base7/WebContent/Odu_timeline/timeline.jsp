<%@page import="odu_member.MemberDTO"%>
<%@page import="odu_timeline.timelineDTO"%>
<%@page import="java.util.List"%>
<%@page import="odu_timeline.timelineDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <div class="w3-col m3" >
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
           <div class="w3-quarter ">
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
<%
Object objlogin = session.getAttribute("login");
MemberDTO mem = (MemberDTO)objlogin;
%>

<div class="w3-col m7">

   <div class="w3-row-padding">
        <div class="w3-col m12">
           <div class="w3-card-2 w3-round w3-white">
              <div class="w3-container w3-padding">
                 <h6 class="w3-opacity">타임 라인</h6>
                    
            
            <form name="frm1" action="fileupload.jsp" method="post" enctype="multipart/form-data">
               
               
               <p contenteditable="true" class="w3-border w3-padding" id="content"></p>
               
               
               
            <!--    <button onclick="document.getElementById('id01').style.display='block'" class="w3-btn">사진 올리기</button>         
                     <div id="id01" class="w3-modal">
                       <div class="w3-modal-content w3-animate-top w3-card-8">
                         <header class="w3-container w3-teal">
                           <span onclick="document.getElementById('id01').style.display='none'"
                           class="w3-closebtn">&times;</span>
                           <h3>사진올리기</h3>
                         </header>
                         <div class="w3-container">
                         <input type="file" class="w3-btn w3-theme" name="fileload" ><i class="fa fa-pencil"></i>
                         </div>
                       
                       </div>
                     </div>    -->                     
                <input type="file" class="w3-btn w3-theme" name="fileload" >사진<i class="fa fa-pencil"></i> 
               
               <button type="submit" class="w3-btn w3-theme" onclick="context()"><i class="fa fa-pencil"></i> 글쓰기</button>
                  <table>
                  
                  <tr>
                     <input type="hidden" name='id' value="<%=mem.getId()%>">
                  </tr>   
               <!-- <tr>
                  <td>사진 추가</td>
                  <td>
                     <input type="file" name="fileload" style="width:400px;">
                  </td>
               </tr> -->
                  </table>
            </form>   <%-- end of form --%>
         </div>   <%-- end of w3-container w3-padding --%>
      </div>   <%-- end of w3-card-2 w3-round w3-white --%>
   </div>    <%-- end of w3-col m12 --%>
</div>    <%-- end of w3-row-padding --%>
<br>


<%
// 타임라인 뿌리기
String id = mem.getId();   // 세션 아이디 저장

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
   <div class="w3-container w3-card-2 w3-white w3-round w3-margin"><br>
      <%
      if( tdto.getDel() == 0 ){
       %>
      <!-- <table> -->
        <!--  <tr>            
            <td rowspan="3">프로필 사진</td>
         </tr> -->
         <img src="image/pro1.png" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
        
         <%-- <tr>            
            <td><%=tdto.getId() %></td>
         </tr>   --%> 
         
         <%
         String time = tdto.getWdate();
         time = time.substring(0,16);
         %>
         <%-- <tr>
            <td><%=time %></td>
         </tr> --%>
         <span class="w3-right w3-opacity"><%=time %></span>
         <h4><%=tdto.getId() %></h4><br>
         
         <hr class="w3-clear">
         <p> <%=tdto.getContent() %></p>
         
         <%-- <tr>
            <td colspan="2">
               <textarea rows="10" cols="38" readonly="readonly">
                  <%=tdto.getContent() %>
               </textarea>
            </td>
         </tr> --%>
         <div class="w3-row-padding" style="margin:0 -16px">
            <div class="w3-half">
              
            </div>
            <div class="w3-half">
             
          </div>
        </div>
        
        <%
            if(mem.getId().equals(tdto.getId())){
         %>
         <form action="timelinedel.jsp" method="post">
            <input type="hidden" name="id" value="<%=mem.getId()%>" />
            <input type="hidden" name="seq" value="<%=tdto.getSeq()%>" />
            <button type="submit" class="w3-btn w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i>삭제</button>
         </form>
         <form action="timelineupdate.jsp" method="post">
            <input type="hidden" name="id" value="<%=mem.getId()%>" />
            <input type="hidden" name="seq" value="<%=tdto.getSeq()%>" />
            <button type="submit" class="w3-btn w3-theme-d2 w3-margin-bottom"><i class="fa fa-comment"></i>수정</button>
         </form>
         <%
         }else{
            %>
            <button type="button" class="w3-btn w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i>Like</button>
                 <button type="button" class="w3-btn w3-theme-d2 w3-margin-bottom"><i class="fa fa-comment"></i>댓글</button>
               <%
               }
            %>
        
         <!-- <tr>
            <td colspan="2"> -->
               <img src="D:\j\jspstudy\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ProjectOdu\upload\<%=tdto.getF_name() %>"> 
<!--             </td>
         </tr> -->
         

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
         
   </div>
   <%
   } // end of tdto.getDel() == 0
} //end of for
%>
      <div>
   </div>
</div>   <%-- end of w3-col m7 --%>

<!-- 오른쪽 시작 -->
    <div class="w3-col m2" >
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
  
<!-- End Page Container -->
</div>
<br>

<script type="text/javascript">
               function context()
               {
                  var content = document.getElementById("content").innerHTML;

                  document.frm1.action="fileupload.jsp?content="+content;
                  document.frm1.submit();
               }
               </script>

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