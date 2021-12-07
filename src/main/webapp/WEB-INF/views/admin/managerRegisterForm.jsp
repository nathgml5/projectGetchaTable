<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
<title>식당관리자 등록</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="resources/css/member/member.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>

<script>
function checkId(){
	var i = document.getElementById('id').value;
	if(i == ""){
		alert('아이디를 입력하세요.')
		return;
	}
	var info = {id:i};
	$.ajax({
		url: "isExistId", type: "POST",
		data: JSON.stringify(info),
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		
		success: function(result){
			$('#idMsg').text(result.idMsg);
		},
		error: function(){
			$('#idMsg').text('error');
		}
	})	
}

function changeId(){
	$('#idMsg').text('');
}

function pwCheck(){
	pw = document.getElementById('pw').value;
	pwOk = document.getElementById('pwOk').value;
	if(pw!=pwOk){
		$('#pwMsg').text('비밀번호가 일치하지 않습니다.');
	}else
		$('#pwMsg').text('');
}


function managerRegister(){
	var id = document.getElementById('id').value;
	var pw = document.getElementById('pw').value;
	var pwOk = document.getElementById('pwOk').value;
	if(id == "" || pw == "" || pwOk == ""){
		alert('필수 입력 항목들입니다.');
		return;
	}
	
	var msgId = document.getElementById('idMsg').innerHTML;
	var msgPw = document.getElementById('pwMsg').innerHTML;
	if(msgId == "" || msgId == null){
		alert("아이디 중복확인을 하십시오.");
		return;
	}else if(pw != pwOk || msgId== "중복된 아이디입니다."){
		alert('입력한 아이디와 비밀번호를 다시 확인하십시오.');
		return;
		
	}else{
		document.getElementById('registerForm').submit();		
	}
}

</script>
<style>
	.container{width:800px; position:relative; margin:auto; text-align:center; width:"100%";}
	.panel-body{background-color:white; overflow:hidden; width:800px; height:auto; text-align:center; margin:auto; border-radius:3px; padding:50px;}
	table{margin:auto; }
	td{width:150px; text-align:left; padding:20px;}
	.btn_btn{color:white; background-color:black; border-color:black; font-size:15px; border-radius:5px; padding:5px 10px; width:150px;}
</style>

</head>
<c:if test="${empty sessionScope.adminId }">
	<script>
		alert('최고 관리자 로그인이 필요합니다.');
		location.href='adminLogin';
	</script>
</c:if> 

<c:if test="${!empty msg }">
	<script>alert("${msg}");</script>
</c:if>

<script>
	// 내비에 선택된 탭 색깔 변경 
	document.getElementById('managerRegisterTab').className = 'nav-link active';
</script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<center style="width:100%">
<div class="container">
     <div class="panel-body">
<form action="managerRegisterProc" id="registerForm" method="post">
<table>
	<tr>
		<td align='right' height=40>아이디</td>
		<td>
			<input type=text name='restId' id='id' placeholder='id 입력' onchange="changeId()"/><br> 
			<label for="id"><font color="red" id="idMsg"></font></label>
		</td>
		<td colspan="2"><input type="button" class="btn_btn" value="중복 확인" onclick="checkId()"/></td>
	</tr>
	<tr>
		<td align='right' height=40>패스워드</td>
		<td>
			<input type=password name='restPw' id='pw' placeholder='pw 입력'/> 
		</td>
	</tr>
	<tr>
		<td align='right'>패스워드 확인</td>
		<td>
			<input type=password name='pwOk' id='pwOk' onchange='pwCheck()' placeholder='pw 입력'/><br>
			<label for="pwOk"><font color="red" id="pwMsg"></font></label>
		</td>
	</tr>
	<tr>
		<td align='right'>전화번호1</td>
		<td colspan="2">
			<select id="phone1" name="phoneStr1">
				<option value="010">010</option>
				<option value="02">02</option>
				<option value="031">031</option>
			</select>
			 - <input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" 
					name="phoneStr1" id="capacity" style="width:60px"/>
			 - <input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" 
					name="phoneStr1" id="capacity" style="width:60px"/>
		</td> 
	</tr>
	<tr>
		<td align='right'>전화번호2</td>
		<td colspan="2">
			<select id="phone1" name="phoneStr2">
				<option value="010">010</option>
				<option value="02">02</option>
				<option value="031">031</option>
			</select>
			 - <input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" 
					name="phoneStr2" id="capacity" style="width:60px"/>
			 - <input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" 
					name="phoneStr2" id="capacity" style="width:60px"/>
		</td> 
	</tr>
	</table>
			<input type=button class="btn_btn" value='식당관리자 등록' onclick="managerRegister()"/>	 

</form>
</div>
</div>
</center>
