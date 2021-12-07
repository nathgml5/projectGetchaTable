<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${empty sessionScope.email}">
	<script>
		alert("로그인 후 이용해주세요.");
		location.href="index?formpath=login";
	</script>
</c:if>
<c:url var="root" value="/"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	.title{margin-top:30px;}
	.container{display:flex; flex-wrap: wrap; justify-content: space-evenly;}
	.view{width:300px; margin:20px; border: 3px inset; padding:20px;}
	.name {text-align:left; padding-right:20px;}
	.btn_btn{color:white; background-color:black; border-color:black; font-size:15px; border-radius:5px; padding:5px 10px;}
	.btn_btnd{color:white; background-color:#D5D5D5; border-color:#D5D5D5; font-size:15px; border-radius:5px; padding:5px 10px;}
</style>
<center>
<c:if test="${!empty msg }"><script>alert('${msg}');</script></c:if>
<div class="title">
	<h2>예약정보</h2>
</div>
<div class="container">	
	<c:forEach var = "reservationView" items="${reservationView }">
		<div class="view">
			<div class="part">
				<span class="name"><b>예약번호</b></span>
				<span class="content" style="width:250px; height:40px;"><b>${reservationView.resNum}</b></span>
			</div>
			<div class="part">
				<span class="content" style="width:250px; height:40px;"><b>${reservationView.email}</b></span>
			</div>
			<div class="part">
				<span class="content" style="width:250px; height:40px;"><b>${reservationView.restName}</b></span>
			</div>
			<div class="part">
				<span class="content" style="width:250px; height:40px;"><b>${reservationView.resDay} / ${reservationView.hours }</b></span>
			</div>
			<div class="part">
				<span class="content" style="width:250px; height:40px;"><b>${reservationView.status}</b></span>
			</div>
		
			<div class="button">
			
			<c:choose>
				<c:when test="${reservationView.status eq '예약확인'}">
					<input type="button" style="width:80px;" value="예약취소" class="btn_btn" id="btn_cancle" onclick="location.href='${root}resDelete?resNum=${reservationView.resNum}'"/>
				</c:when>
				<c:otherwise>
					<input type="button" style="width:80px;" value="예약취소" class="btn_btnd" disabled="disabled"/>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${reservationView.status eq '방문완료'}">
					<button type="button" class="btn_btn" onclick="location.href='index?formpath=write&restNum=${reservationView.restNum}&restName=${reservationView.restName}'">리뷰 쓰기</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn_btnd" disabled="disabled">리뷰 쓰기</button>
				</c:otherwise>
			</c:choose>
			
			
			</div>
		</div>
	</c:forEach>
</div>
</center>