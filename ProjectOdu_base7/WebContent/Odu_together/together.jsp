<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="odu_member.*" %>
<%@ page import="odu_together.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="../css/w3.css">
 <link rel="stylesheet" href="../css/w3-theme-blue-grey.css">
<title>오늘부터 같이해요~</title>
<style>
html,body,h1,h2,h3,h4,h5 {font-family: "Open Sans", sans-serif}
a{
   text-decoration: none;
}
</style>
<script type="text/javascript">
function change(url){
   location.href=url;
}
</script>
</head>
<body class="w3-theme-l5">
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
<% 

Object ologin = session.getAttribute("login");
MemberDTO mem = null;
if(ologin == null){
   %>
   <script>
   alert("로그인하십시오.");
   location.href="../index.jsp";
   </script>
   <%
   return;
}
mem =(MemberDTO)ologin;
%>
<!--페이징 처리부분 -->
<%
   togetherDAO dao= togetherDAO.getInstance();
   List<togetherDTO> Tolist = dao.getTogether();
   int pageno = toInt(request.getParameter("pageno"));
   if(pageno<1){//현재 페이지
      pageno = 1;
   }
   int total_record = Tolist.size();         //총 레코드 수
   int page_per_record_cnt = 20;  //페이지 당 레코드 수
   int group_per_page_cnt =10;     //페이지 당 보여줄 번호 수[1],[2],[3],[4],[5]
//                                              [6],[7],[8],[9],[10]                                 

   int record_end_no = pageno*page_per_record_cnt;            
   int record_start_no = record_end_no-(page_per_record_cnt);
   if(record_end_no>total_record){
      record_end_no = total_record;
   }
                                 
                                 
   int total_page = total_record / page_per_record_cnt + (total_record % page_per_record_cnt>0 ? 1 : 0);
   if(pageno>total_page){
      pageno = total_page;
   }


   

//    현재 페이지(정수) / 한페이지 당 보여줄 페지 번호 수(정수) + (그룹 번호는 현제 페이지(정수) % 한페이지 당 보여줄 페지 번호 수(정수)>0 ? 1 : 0)
   int group_no = pageno/group_per_page_cnt+( pageno%group_per_page_cnt>0 ? 1:0);
//      현재 그룹번호 = 현재페이지 / 페이지당 보여줄 번호수 (현재 페이지 % 페이지당 보여줄 번호 수 >0 ? 1:0)   
//   ex)    14      =   13(몫)      =    (66 / 5)      1   (1(나머지) =66 % 5)           
   
   int page_eno = group_no*group_per_page_cnt;      
//      현재 그룹 끝 번호 = 현재 그룹번호 * 페이지당 보여줄 번호 
//   ex)    70      =   14   *   5
   int page_sno = page_eno-(group_per_page_cnt-1);   
//       현재 그룹 시작 번호 = 현재 그룹 끝 번호 - (페이지당 보여줄 번호 수 -1)
//   ex)    66   =   70 -    4 (5 -1)
   
   if(page_eno>total_page){
//      현재 그룹 끝 번호가 전체페이지 수 보다 클 경우      
      page_eno=total_page;
//      현재 그룹 끝 번호와 = 전체페이지 수를 같게
   }
   
   int prev_pageno = page_sno-group_per_page_cnt;  // <<  *[이전]* [21],[22],[23]... [30] [다음]  >>
//      이전 페이지 번호   = 현재 그룹 시작 번호 - 페이지당 보여줄 번호수   
//   ex)      46      =   51 - 5            
   int next_pageno = page_sno+group_per_page_cnt;   // <<  [이전] [21],[22],[23]... [30] *[다음]*  >>
//      다음 페이지 번호 = 현재 그룹 시작 번호 + 페이지당 보여줄 번호수
//   ex)      56      =   51 - 5
   if(prev_pageno<1){
//      이전 페이지 번호가 1보다 작을 경우      
      prev_pageno=1;
//      이전 페이지를 1로
   }
   if(next_pageno>total_page){
//      다음 페이지보다 전체페이지 수보가 클경우      
      next_pageno=total_page/group_per_page_cnt*group_per_page_cnt+1;
//      next_pageno=total_page
//      다음 페이지 = 전체페이지수 / 페이지당 보여줄 번호수 * 페이지당 보여줄 번호수 + 1 
//   ex)            =    76 / 5 * 5 + 1   ????????       
   }
   
   // [1][2][3].[10]
   // [11][12]
%>
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
    <div class="w3-col m3">
      <!-- 프로필 부분 -->
      <div class="w3-card-2 w3-round w3-white">
        <div class="w3-container">
         <h4 class="w3-center">My Profile<br><%=mem.getName() %></h4>
         <p class="w3-center"><img src="../image/pro.png" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
         <hr>
         <p><i class="fa fa-pencil fa-fw w3-margin-right w3-text-theme"></i> <%=mem.getJob() %></p>
         <p><i class="fa fa-home fa-fw w3-margin-right w3-text-theme"></i> <%=mem.getAddress() %></p>
         <p><i class="fa fa-birthday-cake fa-fw w3-margin-right w3-text-theme"></i> <%=mem.getBirth() %></p>
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
    
<!--리스트부분  -->


<div class="w3-col m7">
<div class="w3-container w3-leftbar" style="background-color: #1ab188;">
  <p><i><img src="../image/together.png"></i></p>
</div><br>
<form>
<table class="w3-table w3-bordered w3-striped w3-border w3-hoverable" style="color: black;">
<col width="80"/><col width="400"/><col width="100"/><col width="100"/><col width="100"/><col width="150"/>
<tr>
   <th style="text-align: center;">번호</th><th  style="text-align: center;">제목</th><th style="text-align: center;">같이해요</th>
   <th style="text-align: center;">조회수</th><th style="text-align: center;">작성자</th><th style="text-align: center;">작성일</th>
</tr>
<%
if(Tolist == null || Tolist.size() == 0){
   %>
   <tr><td colspan="6">작성된 글이 없습니다.</td></tr>
   <% 
}
for(int i = record_start_no; i < record_start_no+page_per_record_cnt; i++){
   if(Tolist.size() == i) break;
   togetherDTO dto = Tolist.get(i);
   
   %>
   <tr>
      <td style="text-align: center"><%=dto.getSeq() %></td>
      <td style="text-align: left; padding-left: 20px;">
      <%if(dto.getDel() == 1){
      %>이 글은 삭제 되었습니다.<% }else{ %>
         <a style="text-decoration: none; color: black;" href="bbsdetail.jsp?seq=<%=dto.getSeq()%>&title=<%=dto.getTitle()%>"><%=dto.getCate()%> <%=dto.getTitle() %></a>
                    <!-- jsp?넘기고싶은 값. &를 이용해서 계속 넘길수 있다. -->
      <%} %></td>
      <td style="text-align: center"><%=dto.getWdate().substring(4, 6) + "-" + dto.getWdate().substring(6, 8)%>
      <td style="text-align: center"><%=dto.getReadcount() %></td>
      
      <td style="text-align: center">
         <div class="w3-dropdown-hover">
            <%=dto.getId() %>
            <div class="w3-dropdown-content w3-border">
            <a href="#">피플추가</a>
            <a href="#">프로필보기</a>
                <a href="#">쪽지보내기</a>
                <a href="#"><font color="red">신고</font></a>
                 </div>
        </div></td>
         
      <td style="text-align: center"><%=dto.getM_date().substring(0, 10) %></td>
   </tr>
<%
}
%>
</table>
</form><hr>
<a href="togetherwrite.jsp" style="text-align: right;"><button class="w3-btn-block w3-teal">글쓰기</button></a>
<div style="margin-left: 220px; margin-bottom: 3px;">
<a  style="color:black;" href="together.jsp?pageno=1">[맨앞으로]</a>
<a  style="color:black;" href="together.jsp?pageno=<%=prev_pageno%>">[이전]</a> 
<%for(int i =page_sno;i<=page_eno;i++){%>
   <a  style="color:black;" href="together.jsp?pageno=<%=i %>">
      <%if(pageno == i){ %>
         [<%=i %>]
      <%}else{ %>
         <%=i %>
      <%} %>
   </a> 
<%--   콤마    --%>   
   <%if(i<page_eno){ %>
      ,
   <%} %>
<%} %>
<a  style="color:black;" href="together.jsp?pageno=<%=next_pageno%>" >[다음]</a>
<a  style="color:black;" href="together.jsp?pageno=<%=total_page %>">[맨뒤로]</a>
</div>
<div style="text-align: center;">
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
</tr>
</table>
</div>
</div>


&nbsp;&nbsp;
<!-- 오른쪽 시작 -->
   <div class="w3-col m2" >
      <div class="w3-card-2 w3-round w3-white w3-center">
        <div class="w3-container">
          <p>오늘의 일정</p>
        
          <p><strong>원빈님이랑 밥먹기</strong></p>
          }
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

<button onclick="document.getElementById('id01').style.display='block'" class="w3-btn">Open Animated Modal</button>

<div id="id01" class="w3-modal">
  <div class="w3-modal-content w3-animate-top w3-card-8">
    <header class="w3-container w3-teal">
      <span onclick="document.getElementById('id01').style.display='none'"
      class="w3-closebtn">&times;</span>
      <h2>Modal Header</h2>
    </header>
    <div class="w3-container">
      <p>Some text..</p>
      <p>Some text..</p>
    </div>
    <footer class="w3-container w3-teal">
      <p>Modal Footer</p>
    </footer>
  </div>
</div>

   <div class="w3-dropdown-hover">
           <h4>혜교</h4><br>
           <div class="w3-dropdown-content w3-border">
            <a href="#">피플추가</a>
             <a href="#">쪽지보내기</a>
                <a href="#"><font color="red">신고</font></a>
           </div>
      </div>

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