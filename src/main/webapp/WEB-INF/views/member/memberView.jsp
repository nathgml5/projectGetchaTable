<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.container{margin:50px;}
.btn_set{text-align: center;}
.btn_btn{color:white; background-color:black; border-color:black; font-size:15px; border-radius:5px; padding:5px 10px;}
</style>
<c:if test="${empty sessionScope.email }">
	<script type="text/javascript">
		alert('로그인 후 이용해주세요.');
		location.href="index?formpath=login";
	</script>
</c:if>
<c:url var="root" value="/"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
              <form id="f"  method="get" role="form" >
                <h2>회원정보</h2>
                  <div class="form-group">
                    <input type="text" name="email" id="email" tabindex="1" class="form-control" disabled  value="이메일 :  ${memberView.email}">
                  </div>
                  
                  <div class="form-group">
                    <input type="text" name="authNum" id="inputAuthNum" tabindex="1" class="form-control" disabled  value="닉네임 :  ${memberView.nickname}">
                  </div>
                  
                  <div class="form-group">
                    <input type="text" name="nickname" id="nickname" tabindex="1" class="form-control"  disabled   value="휴대폰 번호 :  ${memberView.mobile}">
                  </div>
                  
                  <div class="form-group">
                    <input type="text" name="pw" id="pw" tabindex="2" class="form-control" disabled  value="생일 :  ${memberView.birth}">
                  </div>           
                  <div class="form-group">
                  	<c:choose>
                  		<c:when test="${memberView.gender == 'm' }">
                  			<input type="text" tabindex="2" class="form-control" disabled  value="성별 : 남자">
                  		</c:when>
                  		<c:when test="${memberView.gender == 'w' }">
                  			<input type="text" tabindex="2" class="form-control" disabled  value="성별 : 여자">
                  		</c:when>
                  		<c:otherwise>
                  			<input type="text" tabindex="2" class="form-control" disabled  value="성별 : 선택안함">
                  		</c:otherwise>
                  	</c:choose>
				</div>
				<div class="btn_set">
				<input type="button" style="width:60px;" value="수정" class="btn_btn" onclick="location.href='${root}memberModiView'"/>
				<input type="button" style="width:60px;" value="홈" class="btn_btn" onclick="location.href='${root}main'"/>
				<input type="button" style="width:60px;" value="탈퇴" class="btn_btn" onclick="location.href='${root}index?formpath=deleteForm'"/>
				</div>
				</form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>