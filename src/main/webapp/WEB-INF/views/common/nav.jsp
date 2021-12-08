<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url var="root" value="/" />

<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/common/nav.css" rel="stylesheet">
<script type="text/javascript" src="resources/js/bootstrap/bootstrap.bundle.js" ></script>
<script>
$('document').ready(function(){
		var duration = 250;
		var $side=$('#sidebar');
		var $sidebt = $('#openBtn').on('click',function(){
			$side.toggleClass('open');
			if($side.hasClass('open')){
				$side.stop(true).animate({left:'0px'},duration);			
				$side.find('span').text('CLOSE');
			}else{
				$side.stop(true).animate({left:'-250px'},duration);		
				$side.find('span').text('OPEN');
			};
		});
	}); 
	
	
</script>
<c:url var="root" value="/"/>
<aside id="sidebar">
		<div class="d-flex flex-column flex-shrink-0 p-3 text-white bg-dark" style="width:250px;height:100%;background-color:black;">
	    <a href="${root }" id="main-img" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
	      <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
	      <img class="fs-4" src="resources/img/logo/logo.png" width="120">
	    </a>
	    <hr>
    
		<form action="searchProc" method="get" >	
  			<input type="text" name="keyword" id="keywordInput" placeholder="검색 키워드 입력" style="width:210px"/>
		</form>
		
	    <ul class="nav nav-pills flex-column mb-auto">
	      <li class="nav-item">
	      	<button class="dropdown-btn">종류별 추천 리스트 
		    	<i class="fa fa-caret-down"></i>
		  	</button>
		  	<div class="dropdown-container">
		    	<a href="restTypeListProc?mode=type&type=한식">한식</a>
		    	<a href="restTypeListProc?mode=type&type=일식">일식</a>
		    	<a href="restTypeListProc?mode=type&type=이탈리아음식">이탈리아음식</a>
		    	<a href="restTypeListProc?mode=type&type=프랑스음식">프랑스음식</a>
		    	<a href="restTypeListProc?mode=type&type=etc">기타</a>
		  	</div>
		  </li>
	      <li>
	        <button class="dropdown-btn">지역별 추천 리스트 
		    	<i class="fa fa-caret-down"></i>
		  	</button>
		  	<div class="dropdown-container">
		    	<a href="restTypeListProc?mode=location&type=신사동">신사</a>
		    	<a href="restTypeListProc?mode=location&type=청담동">청담</a>
		    	<a href="restTypeListProc?mode=location&type=한남동">한남</a>
		    	<a href="restTypeListProc?mode=location&type=여의도동">여의도</a>
		    	<a href="restTypeListProc?mode=location&type=etc">기타</a>
		  	</div>
	      </li>
	      <li>
	        <button class="dropdown-btn">가격대별 추천 리스트 
		    	<i class="fa fa-caret-down"></i>
		  	</button>
		  	<div class="dropdown-container">
		    	<a href="restPriceListProc?arrange=under3">3만 원 이하</a>
		    	<a href="restPriceListProc?arrange=under5">3만 원 - 5만 원</a>
		    	<a href="restPriceListProc?arrange=under10">5만 원- 10만 원</a>
		    	<a href="restPriceListProc?arrange=upper10">10만 원 이상</a>
		  	</div>
	      </li>
	      <li>
	         <button class="dropdown-btn" onclick="location.href='guideBookShowListProc'">2021 가이드북 선정</button>
	      </li>
	      <li>
	        <button class="dropdown-btn" onclick="location.href='popularListProc'">인기순 리스트</button>
      	</li>
	      <li>
	       <button class="dropdown-btn">연말 추천 리스트</button>
      	</li>
	      <li>
	        <button class="dropdown-btn">드라마속 레스토랑</button>
      	</li>
	      <li>
	       <button class="dropdown-btn">미슐랭 스타</button>
      	</li>
    </ul>
    <hr>
  </div>
	<button id="openBtn"><span class="btn_t">OPEN</span></button>
</aside>

<script>
var dropdown = document.getElementsByClassName("dropdown-btn");
var i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener("click", function() {
  this.classList.toggle("active");
  var dropdownContent = this.nextElementSibling;
  if (dropdownContent.style.display === "block") {
  dropdownContent.style.display = "none";
  } else {
  dropdownContent.style.display = "block";
  }
  });
}
</script>