<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${empty sessionScope.email }">
	<script>
		location.href="index?formpath=main";
	</script>
</c:if>
<style>
.container{margin:50px;}
.btn_set{text-align: center;}
.btn_btn{color:white; background-color:black; border-color:black; font-size:15px; border-radius:5px; padding:5px 10px;}
</style>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="resources/css/member/member.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function deleteSubmit(){
		alert("삭제하시겠습니까?");
		document.getElementById('delete-form').submit();
	}
</script>

<body>
<c:if test="${!empty msg }"><script>alert('${msg}');</script></c:if>
<div class="container">
   <div class="row">
    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-login">
        <div class="panel-body">
          <div class="row">
            <div class="col-lg-12">
              <form action="memberDeleteProc" id="delete-form" method="post" role="form" style="display: block;">
                <h2>회원탈퇴</h2>
                  <div class="form-group">
                    <input type="password" name="pw" id="pw" tabindex="2" class="form-control" placeholder='비밀번호'>
                  </div>
                  <div class="form-group">
                    <input type="password" name="pwCheck" id="pwCheck" tabindex="2" class="form-control" placeholder="비밀번호 확인">
                  </div>
                  <div class="btn_set">
					<input type="button" class="btn_btn" value='확인' style="width:80px;" id="delete-form-btn" onclick="deleteSubmit()"/>
					<input type="button" class="btn_btn" style="width:80px;" value="취소" onclick="location.href='${root}memberViewProc'"/>
				</div>
			</form>
		</div>
	</div>
</div>
</div>
</div>
</div>
</div>
</body>