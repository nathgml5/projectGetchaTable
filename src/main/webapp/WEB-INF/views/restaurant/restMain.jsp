<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식당 메인</title>
<style>

	#restMain{height:auto; background-color:#F2F2F2; margin:0px 100px 0px 100px; padding: 20px; box-shadow: 1px 1px 3px 1px #dadce0;}
	#restTable{height:100%; width:100%;}
	.restImg{box-shadow: 1px 1px 3px 1px #dadce0; border:none; border-radius:5px;}
</style>
</head>
<body>
<c:url var="root" value="/" />
	<script>
		//내비에 선택된 탭 색깔 변경
		document.getElementById('restMainTab').className = 'nav-link active';
	</script>
	
	<div id="restMain">
		<table style="margin:auto; text-align:center;">
			<tr><td><img class="restImg" src="${root }/upload/restaurant/${restDto.representImage }" width="400"></td></tr>
			<tr style="height:100px;"><td><h3>${restDto.restName }</h3></td></tr>
			<tr><td><span>${restDto.type }·${restDto.dong }</span></td></tr>
			<tr><td><span>${restDto.address }</span></td></tr>
		</table>
	</div>
	
</body>
</html>