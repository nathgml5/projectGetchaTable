<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<style>
.login{
width:263px;
height: 59;


}
.register{

height:65px;
}
</style>
<script  src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link rel="stylesheet" href="resources/css/member/login.css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<script>
	$('#register-form-link').click(function(e) {
		$("#register-form").delay(100).fadeIn(100);
 		$("#login-form").fadeOut(100);
		$('#login-form-link').removeClass('active');
		$(this).addClass('active');
		e.preventDefault();	
	});

</script>
<script>
function loginSubmit(){
	document.getElementById('login-form').submit();
}
</script>

<body>
<c:if test="${!empty msg }"><script>alert('${msg}');</script></c:if>
<form id="login-form" action="loginProc" method="post" role="form" style="display: block;">
<div class="container" style="padding-top:50px;">
   <div class="row">
    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-login">
		        <div class="panel-body">
		          <div class="row">
		            <div class="col-lg-12">
		                <h2>LOGIN</h2>
		                  <div class="form-group">
		                    <input type="text" name="email" id="email" tabindex="1" class="form-control" placeholder="이메일" value="">
		                  </div>
		                  <div class="form-group">
		                    <input type="password" name="pw" id="pw" tabindex="2" class="form-control" placeholder="비밀번호">
		                  </div>
		                 	<c:if test = "${!empty result}">
								<div class = "login_warn"> Email 또는 비밀번호를 잘못 입력하셨습니다.</div>
							</c:if>
		                  <div class="col-xs-6 form-group pull-left checkbox">
		                    <input id="checkbox1" type="checkbox" name="remember">
		                    <label for="checkbox1">Remember Me</label>   
		                  </div>
		            </div>
		          </div>
		        </div>
		        <div class="panel-heading">
		          <div class="row">
		            <div class="col-xs-6 tabs">
		              <button type="button" class="active" id="login-form-link" onclick="loginSubmit()"><div class="login">로그인</div></button>
		            </div>
		            <div class="col-xs-6 tabs">
		              <a href="index?formpath=member" ><div class="register">회원가입</div></a>
		           
		            </div>
		          </div>
		        </div>
      </div>
    </div>
  </div>
</div>
</form>


</body>
<script>
	function check(){
		var reg=/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$/;
		var pw = document.getElementById("pw").value;
		if(false == reg.test(password)){
			alert('비밀번호는 8자이상이어야 하며, 숫자/대문자/소문자를 포함해야 합니다.');
		}
		document.getElementById('f').submit();
	}

</script>
</html>