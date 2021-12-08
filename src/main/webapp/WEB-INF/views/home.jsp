<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<!DOCTYPE html>
<html>
<head>
<link href="resources/css/home/home.css" rel="stylesheet">
<meta charset="utf-8"/>
<title>GetchaTable</title>
<c:if test="${!empty msg }"><script>alert('${msg}');</script></c:if>

<script>
window.onload = function(){
    const elm = document.querySelectorAll('.section');
    const elmCount = elm.length;
    elm.forEach(function(item, index){
      item.addEventListener('mousewheel', function(event){
        event.preventDefault();
        let delta = 0;

        if (!event) event = window.event;
        if (event.wheelDelta) {
            delta = event.wheelDelta / 120;
            if (window.opera) delta = -delta;
        } 
        else if (event.detail)
            delta = -event.detail / 3;

        let moveTop = window.scrollY;
        let elmSelector = elm[index];

        // wheel down : move to next section
        if (delta < 0){
          if (elmSelector !== elmCount-1){
            try{
              moveTop = window.pageYOffset + elmSelector.nextElementSibling.getBoundingClientRect().top;
            }catch(e){}
          }
        }
        // wheel up : move to previous section
        else{
          if (elmSelector !== 0){
            try{
              moveTop = window.pageYOffset + elmSelector.previousElementSibling.getBoundingClientRect().top;
            }catch(e){}
          }
        }

        const body = document.querySelector('html');
        window.scrollTo({top:moveTop, left:0, behavior:'smooth'});
      });
    });
  }
</script>

</head>



<body >

    <div class="section">
		<video width="100%" height="auto" autoplay loop muted>
	        <source src="resources/video/poursoup.mp4" type="video/mp4">
	    </video>
		<div id="search" >
			<div style="margin:60px;">
				<img alt="로고" src="resources/img/logo/logo2.png" width="250px;">
				<p style="color:white; font-size:14px;">특별한 날, 최고의 맛남</p>
				
			</div>
			 <form action="searchProc" method="get">
				<input type="text" name="keyword" id="keywordInput" class="mainSearch" placeholder="키워드를 입력하세요." style="width:500px; height:50px;font-size:16px"/>
			</form> 
		</div>
	</div>
    <div class="section" >
		<video width="100%" height="auto" autoplay loop muted>
	        <source src="resources/video/chinese_food.mp4" type="video/mp4">
	    </video>
    	<div id="session1" >
			<div>
				<p style="color:white; font-size:16px; font-weight: bold;">최고의 맛, 최고의 만찬</p>
				<p style="color:white; font-size:14px;"><a href="popularListProc">겟챠테이블이 추천하는 인기 레스토랑 확인하기 ></a></p>
				
			</div>
		</div>
	</div>
    <div class="section" >
	    <video width="100%" height="auto" autoplay loop muted>
	        <source src="resources/video/family_happydinner.mp4" type="video/mp4">
	    </video>
	    <div id="session2" >
			<div>
				<p style="color:white; font-size:16px; font-weight: bold;">소중한 사람들과 만들어가는 추억</p>
				<p style="color:white; font-size:14px;"><a href="restTypeListProc?mode=type&type=한식">종류별 레스토랑 확인하기 ></a></p>
			</div>
		</div>
    </div>
    <div class="section" >
		<video width="100%" height="auto" autoplay loop muted>
	        <source src="resources/video/party.mp4" type="video/mp4">
	    </video>
	     <div id="session3" >
			<div>
				<p style="color:white; font-size:16px; font-weight: bold;">나를 위한 시간</p>
				<p style="color:white; font-size:14px;"><a href="restTypeListProc?mode=location&type=신사동">지역별 레스토랑 확인하기 ></a></p>
			</div>
			<button style="decoration:none; width:50px; height:100px; float:left; curser:hand; opacity:0.1" onclick="location.href='adminLoginForm'"></button>
		</div>
	</div>
</html>