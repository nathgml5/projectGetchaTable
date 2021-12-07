<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="resources/css/admin/login.css" rel="stylesheet" />

<center>
<c:if test="${msg != null }">
	<script>alert('${msg}');</script>
</c:if>
<body>
<div class="container">
   <div class="row">
    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-login">
        <div class="panel-body">
          <div class="row">
            <div class="col-lg-12">
       
              <form action="adminLoginProc" method="post" role="form" style="display: block;">
                <h2>관리자 로그인</h2>
                  <div class="form-group">
                    
                 	
                  <div class="form-group">
                    <input type="text" name="adminId"  tabindex="2" class="form-control" placeholder='아이디'>
                   
                  </div>
                  <div class="form-group">
                    <input type="password" name="adminPw"  tabindex="2" class="form-control" placeholder="비밀번호">
                   
                  </div>
              
			<tr>
				<td colspan=2 align='center'>
					<input type=submit value='로그인' style="width:80px;"/>
					<input type="button" style="width:80px;" value="취소" onclick="javascript:window.history.back();"/>
			</tr>
		</table>
	</form>
</center>
