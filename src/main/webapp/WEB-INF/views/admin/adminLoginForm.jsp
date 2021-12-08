<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="resources/css/admin/login.css" rel="stylesheet" />

<center>
<c:if test="${msg != null }">
	<script>alert('${msg}');</script>
</c:if>
<div class="container">
       
	<form action="adminLoginProc" method="post" role="form" style="display: block;">
		<h2 style="margin-bottom:50px">관리자 로그인</h2>
		<table>   
	 		<tr><td><div class="form-group">
	     			<input type="text" name="adminId"  tabindex="2" class="form-control" placeholder='아이디'>
   			</div></td></tr>	
	 		<tr><td><div class="form-group">
	     			<input type="password" name="adminPw"  tabindex="2" class="form-control" placeholder="비밀번호">
	   		</div></td></tr>	              
			<tr><td align='center'>
				<div class="form-group">
				<input type=submit value='로그인' style="width:100px; margin-right:40px;"/>
				<input type="button" style="width:100px;" value="취소" onclick="javascript:window.history.back();"/>
				</div>
			</td></tr>
		</table>
	</form>
</div>
</center>
