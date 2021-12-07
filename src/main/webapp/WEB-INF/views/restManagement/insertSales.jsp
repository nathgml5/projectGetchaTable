<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문정보 입력</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script>
	function addOrder(data){
		var menu = data.innerHTML;
		$('#orderedList').append("<li name='orderedMenu'>"+menu+"<button name='delBtn'>삭제</button></li>");
	}
	
	$(document).on("click","button[name=delBtn]",function(){
        $(this).parent().remove(); 
	        
	});
	$(document).on("click","button[name=orderedBtn]",function(){
        window.close();
	        
	});
</script>
</head>
<body>
	<h4>메뉴 목록</h4>
	<ul style="list-style:none;">
		<li onclick="addOrder(this)">까르보나라 1,000</li>
		<li onclick="addOrder(this)">루꼴라피자 1,000</li>
		<li onclick="addOrder(this)">로제떡볶이 1,000</li>
		<li onclick="addOrder(this)">월남쌈 1,000</li>
		<li onclick="addOrder(this)">이것저것 1,000</li>
		<li onclick="addOrder(this)">으아앙 1,000</li>
		<li onclick="addOrder(this)">러럴 1,000</li>
		<li onclick="addOrder(this)">ㄹㅇ널ㄴㅇ 1,000</li>
		<li onclick="addOrder(this)">콜라 1,000</li>
	</ul>
	
	<hr>
	<h4>주문 목록</h4>
	<div style="overflow:auto; width:400px; height:100px; border: 1px solid black">
		<ul id="orderedList" style="list-style:none;">
			<li name="orderedMenu"></li>
		</ul>
	</div>
	<br>
	결제 금액 :<h3></h3>
	<button name="orderedBtn">결제완료</button>
</body>
</html>