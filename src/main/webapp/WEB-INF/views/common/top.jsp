<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url var="root" value="/"/>
<style>
#header{background-color: black; height: 70px; width:100%;}
.rows{width:100%; display:flex; height:100%; justify-content: space-between;}
#top>ul {margin-right: 20px;}
#top>ul>li {float:right; padding:20px 20px; list-style-type:none;}	
.coll-logo{flex-basis: 70%; margin: 10px 40px 5px 40px;}
.coll-l{margin-left:auto; margin: 15px 50px 15px 40px; }
</style>


<header id="header">
	<div class="rows">
		<div class="coll-logo">
			<a href="main"><img src="resources/img/logo/logo4.png" width="40px"></a>
		</div>
		<div id="top">
		<c:choose>
			<c:when test="${not empty sessionScope.email }">
			<div class="dropdown coll-l" style="width:200px;">
			 <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="background-color:black">
			    <img src="resources/img/icon/profileIcon.png" style="width:30px">
			  </button>
			  <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			    <li><a class="dropdown-item" href="${root}memberViewProc">회원정보</a></li>
			    <li><a class="dropdown-item" href="${root }reservationViewProc">예약 확인</a></li>
			    <li><a class="dropdown-item" href="${root }reviewProc">내 리뷰</a></li>
			    <li> <a class="dropdown-item" href="${root }myCollectProc">관심 식당</a></li>
			    <li><a class="dropdown-item" href="${root}logout">로그아웃</a></li>
			  </ul>
			</div>
			
			</c:when>
			<c:when test="${not empty sessionScope.adminId && sessionScope.adminId == 'admin' }">
				<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="background-color:black">
			  	웹 관리자
			  	</button>
			  	<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			    	<li><a class="dropdown-item" href="adminLogoutProc">로그아웃</a></li>
			   	</ul>
			</c:when>
			<c:when test="${not empty sessionScope.adminId && sessionScope.adminId != 'admin' }">
				<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="background-color:black">
			  	${sessionScope.adminId } 관리자
			  	</button>
			  	<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			    	<li><a class="dropdown-item" href="adminLogoutProc">로그아웃</a></li>
			   	</ul>
			</c:when>
			<c:otherwise>
			<ul>
				<li><a class="headerMenu" href="${root}index?formpath=member" style="text-decoration: none;">회원가입</a></li>
				<li><a class="headerMenu" href="${root}index?formpath=login" style="text-decoration: none;">로그인</a></li>
			</ul>
			</c:otherwise>
		</c:choose>
		</div>
	</div>

</header>
