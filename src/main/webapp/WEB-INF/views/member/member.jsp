<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="resources/css/member/member.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>


<script>

    $('#login-form-link').click(function(e) {
    	$("#login-form").delay(100).fadeIn(100);
 		$("#register-form").fadeOut(100);
		$('#register-form-link').removeClass('active');
		$(this).addClass('active');
		e.preventDefault();
	});
	

});
</script>
<html>
<style>
#register-reset{
color:#FCF3E4;
    background-color: #B0978D;
    color: #FCF3E4;
}
#register-submit{
    background: #2d3b55;
color:#FCF3E4;
}
.active{width: -webkit-fill-available; height: 69px;}
.container{margin-top: 50px;}
.panel-login>.panel-heading .register {
  padding: 20px 30px;
  background: #2d3b55;
  border-bottom-right-radius: 5px;
}
/*.form-control btn btn-reset{
background-color:#B0978D;
width:274px;


}
.form-control btn btn-register{
width:280px;
height:65px;
}*/
</style>

<script>
	function sendAuthNum(){
		var e = document.getElementById("email").value;
		if(e == ""){
			$('#msg').text('이메일을 입력하세요.');
			return;
		}
		var s = {email:e};
		$.ajax({
			url: "sendAuth", type:"POST",
			data: JSON.stringify(s),
			contentType: "application/json; charset=utf-8",
			dataType:"json",
			success: function(result){
				$('#msg').text(result.msg);
			},
			error:function(){
				$('#msg').text('error');
			}
		})
	}
	function sendAuthConfirm(){
		var i = document.getElementById("inputAuthNum").value;
		if(i == ""){
			$('#msg').text('인증번호를 입력하세요.');
			return;
		}
		var s = {inputAuthNum:i};
		$.ajax({
			url: "authConfirm", type: "POST",
			data: JSON.stringify(s),
			contentType: "application/json;charset=UTF-8",
			dataType:"json",
			success : function(data){
				alert(data.msg);
			},
			error : function(){
				console.log("실패");
			}
		})
	}
</script>

<script>
function memberSubmit(){
		document.getElementById('login-form').submit();
}
</script>

<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<body>
<c:if test="${!empty msg }"><script>alert('${msg}');</script></c:if>
<div class="container">
   <div class="row">
    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-login">
        <div class="panel-body">
          <div class="row">
            <div class="col-lg-12">
              <form id="login-form"  action="memberProc" method="post" role="form" style="display: block;">
                <h2>REGISTER</h2>
                  <div class="form-group">
                    <input type="text" name="email" id="email" tabindex="1" class="form-control" placeholder="이메일" value="">
                    <input type="button" value="Email 인증하기" onclick="sendAuthNum();">
                  </div>
                  <div class="form-group">
                    <input type="text" name="inputAuthNum" id="inputAuthNum" tabindex="1" class="form-control" placeholder="이메일인증 번호" value="">
                    <input type="button" value="Email 인증확인" onclick="sendAuthConfirm();">
                  </div>
                  <div class="form-group">
                    <input type="text" name="nickname" id="nickname" tabindex="1" class="form-control" placeholder="닉네임 입력" value="">
                  
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
                    <input type="text" name="mobile" id="mobile" tabindex="2" class="form-control" placeholder="휴대폰 번호">                  
                   </div>
                    <div class="form-group">
                    <input type="password"  tabindex="2" class="form-control" placeholder="생일" readonly="readonly">                  
                <select name="birth1">
					<%for(int i=2002; i>=1900; i--){ %>
						<option value="<%=i %>"><%=i %></option><%} %>
					</select>년
					<select name="birth2">
					<%for(int i=1; i<=12; i++){ %>
						<option value="<%=i %>"><%=i %></option><%} %>
					</select>월
					<select name="birth3">
					<%for(int i=1; i<=31; i++){ %>
						<option value="<%=i %>"><%=i %></option><%} %>
					</select>일<br><br>
                  </div>
                    <div class="form-group">
                    <input type="text" tabindex="2" class="form-control" placeholder="성별" readonly="readonly">                  
                   	<input type=radio name='gender' value='n' checked="checked"/>선택안함
					<input type=radio name='gender' value='w' />여자
					<input type=radio name='gender' value='m' />남자
                   </div>
               </form>
            </div>
          </div>
        </div>
        <div class="panel-heading">
          <div class="row"with  >
            <div class="col-xs-6 tabs">
              <input type="reset" name="register-reset" id="register-reset" tabindex="4" class="form-control btn btn-reset" value="취소" onclick="location.href='${root}main'">
            </div>
            <div class="col-xs-6 tabs">
                <input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="회원가입" onclick="memberSubmit()">
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<footer>
    <div class="container">
        <div class="col-md-10 col-md-offset-1 text-center">
        </div>
    </div>
</footer>
<script>
	/* 로그인 버튼 클릭 메서드 */
	$(".login_button").click(function(){
	
		/* 로그인 메서드 서버 요청 */
		$("#login-form").attr("action","login");
		$("#login-form").submit();
		
	});
</script>
</body>

<script>
	
	//두 비밀번호 일치 여부 확인
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
	
	
	//비밀번호 제약
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
</html>