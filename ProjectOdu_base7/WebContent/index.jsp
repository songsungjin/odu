<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
  <head>
    <meta charset="UTF-8">
    <title>Simple login form</title>
    
    
    <link rel="stylesheet" href="css/reset.css">

        <link rel="stylesheet" href="css/style.css">

<style type="text/css">

#a{
 width: 5px;
  height: 200px;

    
    color:#79ABFF;
 
    text-align: center;

}

</style>
  </head>

  <body>
  

    <div class="container">
    
    		<p id="a"><img src="image/lo1.png" ><br>
		
  	</p>
  		
  <div class="login">
  
  
  	<form action="Odu_login/Login.jsp" method="post">
  	<h1 class="login-heading">
      <strong></strong></h1>
        <input type="text" name="id" placeholder="Username" required="required" class="input-txt" />
          <input type="password" name="pw" placeholder="Password" required="required" class="input-txt" />
          <div class="login-footer">
            
           
			<input type="submit" class="btn btn--right" value="Log-in " >

			
             <a href="Odu_login/reg.jsp" class="lnk" >
              <span class="icon icon--min"></span> 
                        아이디가 없으세요? <font style="color: #72ce9f">회원 가입 하기</font>      
            </a>
            
           
    
          </div>
      </form>
  </div>
</div>
</body>
</html>
