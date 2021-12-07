<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 현황</title>

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="resources/css/reservation/reservationManagement.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script>
	$( function() {
	  $( "#datepicker" ).datepicker({ minDate: 0, maxDate: "+1M" });
	} );
	
	function changeDate(){
		var date = $('#datepicker').val();
		if(date==""){
			alert('날짜를 선택하세요.');
			return;
		}
		location.href="selectRestReservationProc?searchDate="+date;
		
	}

	function seatedProc(){
		var res = document.getElementById('dropbtn').value;
		alert(res);
		$('#seatedTable').append("<td>"+res+"</td>");
	}


</script>

</head>
<body style="display:flex;">
	
	<script>
		//내비에 선택된 탭 색깔 변경
		document.getElementById('bookingTab').className = 'nav-link active';
	</script>
	<div align="center" style="padding:20px">
		<span class="bn_time" >clock</span>
		<span class="bn_date" >clock</span>
	</div>
	<div style="background-color:#F2F2F2; box-shadow: 1px 1px 3px 1px #dadce0; padding:20px;">
		<input type="text" id="datepicker" placeholder="${date }" >
		<input type="button" value="조회" onclick="changeDate()">
		
		
		<table id="seatedTable" style="border-color:white; margin:10px;">
			<tr>
				<td><h3>Seated</h3></td>
				<c:forEach var="j" begin="0" end="${fn:length(reserveList) }" step="1" >
					<c:if test="${reserveList[j].status == '착석' }"> 
			    	<td>				
						<div class="dropdown">
					    	<button  id="dropbtn" class="myDropdown${j }" onclick="myFunction(this)" style="background-color:#3F80A1">
					    		${reserveList[j].resNum }<br>${reserveList[j].nickname} ${reserveList[j].capacity}명
					    	</button>
					  		<div id="myDropdown${j }" class="dropdown-content">
					    		<a href="orderDoneProc?resNum=${reserveList[j].resNum }&searchDate=${date}">방문완료</a>
						  	</div>
						 </div>
				  	</td>
				 	</c:if> 
				</c:forEach>
			</tr>
		</table>

		
		<table id="reservationTable" border="1" style="margin:10px;">
			<c:forEach var="i" begin="11" end="22" step="1">
			<tr>
				<th>${i }:00</th>
				<c:forEach var="j" begin="0" end="${fn:length(reserveList) }" step="1" >
					<c:if test="${reserveList[j].hours == i}">
						<td>
							<div class="dropdown">
								<c:if test="${reserveList[j].status == '예약확인' }"> 
							    	<button id="dropbtn" class="myDropdown${j }" onclick="myFunction(this)">
							    		${reserveList[j].resNum }<br>${reserveList[j].nickname} ${reserveList[j].capacity}명
							    	</button>
							  		<div id="myDropdown${j }" class="dropdown-content">
							    		<button type="button" class="collapsible">회원 정보</button>  
							    			<div class="content">
											  <span>
											  생년월일 : ${reserveList[j].birth }<br>
											  성별 : ${reserveList[j].gender }<br>
											  전화번호: <br> ${reserveList[j].mobile }
											  </span>
											</div>
							    		<a href="reserveConfirmProc?resNum=${reserveList[j].resNum }&searchDate=${date}">예약 확인</a>
								  	</div>
							 	</c:if> 
							  	
								<c:if test="${reserveList[j].status == '확인완료'}">
							    	<button  id="dropbtn" class="myDropdown${j }" onclick="myFunction(this)" style="background-color:#404040">
							    		${reserveList[j].resNum }<br>${reserveList[j].nickname} ${reserveList[j].capacity}명
							    	</button>
							  		<div id="myDropdown${j }" class="dropdown-content">
							    		<button type="button" class="collapsible">회원 정보</button>  
							    			<div class="content">
											  <span>
											  생년월일 : ${reserveList[j].birth }<br>
											  성별 : ${reserveList[j].gender }<br>
											  전화번호: <br> ${reserveList[j].mobile }
											  </span>
											</div>
							    		<a href="customerSeatedProc?resNum=${reserveList[j].resNum }&searchDate=${date}">착석</a>
							    		<a href="reserveCancelProc?resNum=${reserveList[j].resNum }&searchDate=${date}">예약 취소</a>
							    		<a href="noShowProc?resNum=${reserveList[j].resNum }&searchDate=${date}">노쇼</a>
								  	</div>
							  	</c:if>
								<c:if test="${reserveList[j].status == '노쇼' }">
							    	<button  id="dropbtn" class="myDropdown${j }" onclick="myFunction(this)" style="background-color:#962D3E">
							    		${reserveList[j].resNum }<br>${reserveList[j].nickname} ${reserveList[j].capacity}명
							    	</button>
							  	</c:if>
							  	<c:if test="${reserveList[j].status == '착석' }"> 
							    	<button  id="dropbtn" class="myDropdown${j }" onclick="myFunction(this)" style="background-color:#3F80A1">
							    		${reserveList[j].resNum }<br>${reserveList[j].nickname} ${reserveList[j].capacity}명
							    	</button>
							  		<div id="myDropdown${j }" class="dropdown-content">
							    		<a href="orderDoneProc?resNum=${reserveList[j].resNum }&searchDate=${date}">방문완료</a>
								  	</div>
					 			</c:if> 
							</div>
						</td>
					</c:if>				
				</c:forEach> 				
			</tr>
			</c:forEach>
		</table>
		
	</div>
	
<script>
/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */
function myFunction(drop) {
	var down_class = drop.getAttribute('class');
  	document.getElementById(down_class).classList.toggle("show");
}
// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('#dropbtn') == !event.target.matches('.collapsible') ) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}


var coll = document.getElementsByClassName("collapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {    
	this.classList.toggle("active");
    var content = this.nextElementSibling;
    if (content.style.display === "block") {
      content.style.display = "none";
    } else {
      content.style.display = "block";
    }
  });
}
</script>

<script>
function clock(){
	var date = new Date();
	//년도
	var nowYear = date.getFullYear();
	// date Object
	var month = date.getMonth();
	// 월
	var clockDate = date.getDate();
	// 날짜
	var day = date.getDay();
    // 요일은 숫자형태로 리턴되기때문에 미리 배열로 
	var week = ['일', '월', '화', '수', '목', '금', '토'];
	// 시간
	var hours = date.getHours();
	// 분
	var minutes = date.getMinutes();
	// 초
	var seconds = date.getSeconds();
    // 시간 분 초는 한자리 수 이면 앞에0을 붙임
    var hours_str = hours < 10 ? "0"+hours : hours;
	var minutes_str = minutes < 10 ? "0"+minutes : minutes;
	var seconds_str = seconds < 10 ? "0"+seconds : seconds;
    // 월은 0부터 1월이기때문에 +1일을 해주고
    $(".bn_date").html(week[day]+"요일 "+(month+1)+"/"+clockDate+"/"+nowYear);
	$(".bn_time").html(hours_str+":"+minutes_str+":"+seconds_str);
        
}


function init() {
	// 최초에 함수를 한번 실행
    clock();
    //1초마다 반복
	setInterval(clock, 1000);
}


$(document).ready(function(){
	init();	
});

</script>
</body>
</html>