<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
var lastScrollTop = 0, delta = 15;

$(window).scroll(function(){
    var scrollTop = $(this).scrollTop() /* 스크롤바 수직 위치를 가져옵니다, 괄호 안에 값(value)이 있을 경우 스크롤바의 수직 위치를 정합니다. */
    // Math.abs: 주어진 숫자의 절대값을 반환(return)합니다.
    if(Math.abs(lastScrollTop - scrollTop) <= delta) // 스크롤 값을 받아서 ~
    return; // ~ 리턴

    if ((scrollTop > lastScrollTop) && (lastScrollTop>0)) {
    	/* 화면에 나오지 않을 때, top값은 요소가 보이지 않을 정도로 사용해야함 */
        $(".scroll").css("top","-70px");
    	
    } else {
        $(".scroll").css("top","0px");
    }
    lastScrollTop = scrollTop;
});
</script>
<c:url var="root" value="/" />
<header id="header" class="scroll">
	<div class="rows">
		<div class="coll-logo">
			<a href="${root }"><img src="resources/img/logo/logo4.png" width="40px"></a>
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
				<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" 
					data-bs-toggle="dropdown" aria-expanded="false" style="background-color:black; margin:10px;">
			  	웹 관리자
			  	</button>
			  	<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			    	<li><a class="dropdown-item" href="adminLogoutProc">로그아웃</a></li>
			   	</ul>
			</c:when>
			<c:when test="${not empty sessionScope.adminId && sessionScope.adminId != 'admin' }">
				<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" 
					data-bs-toggle="dropdown" aria-expanded="false" style="background-color:black; margin:10px;">
			  	${sessionScope.adminId } 관리자
			  	</button>
			  	<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			    	<li><a class="dropdown-item" href="adminLogoutProc">로그아웃</a></li>
			   	</ul>
			</c:when>
			<c:otherwise>
			<ul>
				<li><a class="headerMenu" href="indexPath?formpath=member" style="text-decoration: none;">회원가입</a></li>
				<li><a class="headerMenu" href="indexPath?formpath=login" style="text-decoration: none;">로그인</a></li>
			</ul>
			</c:otherwise>
		</c:choose>
		</div>
	</div>

</header>
