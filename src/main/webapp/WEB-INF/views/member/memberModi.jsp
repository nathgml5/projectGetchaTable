<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="resources/css/member/member.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<c:if test="${empty sessionScope.email }">
	<script>
		alert("로그인 후 이용 가능합니다.");
		location.href='index?formpath=login'
	</script>
</c:if>
<c:if test="${not empty msg }">
	<script>
		var message="${msg}";
		alert(message);
	</script>
</c:if>
<html>
<style>
.container{margin:50px;}
#register-reset{
 background-color: #B0978D;
    color: #FCF3E4;
}
#register-submit{

 background-color: #2d3b55;
    color: #FCF3E4;
}
.form-control btn btn-reset{
background-color:#B0978D;
width:274px;
}
.form-control btn btn-register{
width:280px;
height:65px;
}
</style>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="resources/css/member/member.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<body>
<c:if test="${!empty msg }"><script>alert('${msg}');</script></c:if>
<div class="container">
   <div class="row">
    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-login">
        <div class="panel-body">
          <div class="row">
            <div class="col-lg-12">
				<form action=memberModiProc method="post" id="login-form" role="fomr" style="display: block;">
					<h2>회원수정</h2>
					
					<div class="form-group">
						<input type="text" name="email" id="email" tabindex="1" class="form-control" placeholder="이메일" value='이메일  :  ${memberView.email }' disabled="disabled"/>
					</div>
					<div class="form-group">
                    	<input type="text" name="nickname" id="nickname" tabindex="1" class="form-control" placeholder="닉네임 입력" value='${memberView.nickname }'>
                  	</div>
					<div class="form-group">
                    	<input type="password" name="pw" id="pw" tabindex="2" class="form-control" placeholder="비밀번호">
                    	<div class="alert-length" id="alert-length">비밀번호는 8자리 이상으로 입력해주세요.</div>
                    	<div class="alert-space" id="alert-space">비밀번호는 공백 없이 입력해주세요.</div>
                    	<div class="alert-eng" id="alert-eng">비밀번호는 영문, 숫자, 특수문자 중 2가지 이상을 혼합하여 입력해주세요.</div>
                	</div>
                  	<div class="form-group">
                    	<input type="password" name="pwCheck" id="pwCheck" tabindex="2" class="form-control" placeholder="비밀번호 확인">
                    	<div class="alert-success" id="alert-success">비밀번호가 일치합니다.</div>
                    	<div class="alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
                  	</div>
                  	<div class="form-group">
                    	<input type="text" name="mobile" id="mobile" tabindex="2" class="form-control" value='전화번호  :  ${memberView.mobile}'disabled="disabled"/>                  
                   	</div>
                   	<div class="form-group">
                   		<input type=text name='birth' id='birth' tabindex="2" class="form-control" value='생일  :  ${memberView.birth }'disabled="disabled"/>
					</div>
					<div class="form-group">
                    	
                    	<c:if test="${memberView.gender == 'n' }">
                    		<input type="text" tabindex="2" class="form-control" value='성별  :  선택안함' disabled="disabled">
						</c:if>
						<c:if test="${memberView.gender == 'm' }">
							<input type="text" tabindex="2" class="form-control" value='성별  :  남성' disabled="disabled">
						</c:if>
						<c:if test="${memberView.gender == 'w' }">
							<input type="text" tabindex="2" class="form-control" value='성별  :  여성' disabled="disabled">
						</c:if>
                    </div>
                    <div class="panel-heading">
         				 <div class="row"with  >
           				 <div class="col-xs-6 tabs">
             				 <input type="reset" name="register-reset" id="register-reset" tabindex="4" class="form-control btn btn-reset" value="취소" onclick="location.href='${root}memberViewProc'">
            			</div>
           				 <div class="col-xs-6 tabs">
                			<input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="회원수정" onclick="location.href='${root}memberModiProc'">
           				 </div>
          				</div>
        			</div>
				</form>
			</div>
		</div>
	</div>
        
      </div>
    </div>
  </div>
</div>
<script>
$(function(){
	$("#alert-success").hide();
	$("#alert-danger").hide();
	$("#pwCheck").keyup(function(){
		var pw = $("#pw").val();
		var pwCheck = $("#pwCheck").val();
		if(pw != "" || pwCheck != ""){
			if(pw == pwCheck){
				$("#alert-success").show();
				$("#alert-danger").hide();
				$("#submit").removeAttr("disabled");
			}else{
				$("#alert-success").hide();
				$("#alert-danger").show();
				$("#submit").attr("disabled", "disabled");
			}
		}
	});
});

$(function(){
	$("#alert-length").hide();
	$("#alert-space").hide();
	$("#alert-eng").hide();
	$("#pw").blur(function(){
		var pw = $("#pw").val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/ig);
		var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		if(pw.length<8){
			$("#alert-length").show();
			$("#alert-space").hide();
			$("#alert-eng").hide();
		}else if(pw.search(/\s/)!=-1){
			$("#alert-length").hide();
			$("#alert-space").show();
			$("#alert-eng").hide();
		}else if((num<0&&eng<0)||(eng<0&&spe<0)||(spe<0&&num<0)){
			$("#alert-length").hide();
			$("#alert-space").hide();
			$("#alert-eng").show();
		}else{
			$("#alert-length").hide();
			$("#alert-space").hide();
			$("#alert-eng").hide();
			console.log("통과");
		}
	});
});
</script>