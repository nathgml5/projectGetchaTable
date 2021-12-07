<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
</head>
<c:if test="${empty sessionScope.email }">
	<script>
		alert("로그인 후 이용 가능합니다.");
		location.href='index?formpath=login'
	</script>
</c:if>
<script>
function search(){
	var i = document.getElementById("resDay").value;
	var e = {resDay:i}
	var time_data;
	$.ajax({
		url :"SearchDay", type:"POST",
		//async:false;
		data:JSON.stringify(e),
		contentType:"application/json; charset=utf-8",
		dataType:'json',
		success:function(data){
			console.log(data);
			var str="<tr>";
			var list = data.datas;
			$(list).each(function(ind,obj){
				console.log(obj["time"]);
				console.log(obj["capa"]);
				
				//str+="<td><select name='time'><option value="'+obj["time"]+'">+"obj["time"]+"</option></td>";
				
				str+="<td onclick='setTime(obj['time']);' style='cursor:pointer;'>"+obj["time"]+"</td>";
			});
			str+="</tr>"
				$("#showTime").html(str);
			$("#showTime td").click(function(){
				
				var str=""
				var ctr=""
				var td=$(this);
				console.log("선택된 데이터:"+td.text());
				$("#hours").val(td.text());
				str = td.text();
				$("#hours").html(str)
				
				$(list).each(function(ind,obj){
					if(obj["time"]==str){
						console.log(obj["time"]);
						var ctr=obj["capa"];
						var capanum = parseInt(ctr);
						console.log("capanum:"+capanum);
						$("select[name='capacity'] option").remove();
						for(var i=1; i<=capanum; i++){
							
							$("select[name='capacity']").append('<option value="'+i+'">'+i+'</option>');
						}
						
					}
				});
			});
		},
		error:function(){
			alert("문제발생")
		}
	});
}



</script>
<body>
<!-- <div class="container" style="width:1130px; position:relative; padding-top:60px; margin:auto;"> -->
<div class="container" style="margin:auto;">
<form action="reservationProc" method="post">
	<h4>날짜</h4>
	<input type="text" id="resDay" name="resDay"/>
	<input type="button" value="조회" onclick="search();">
	<div id="div_calendar" style="width:300px; display:none;">
		<div>
			<button type="button" onclick="changeMonth(-1);"><i class="fa fa-chevron-left"></i></button>
			<input type="number" id="year" value="2020" style="width:80px; display:initial;" class="form-control"/>
			<select id="month" class="form-control" style="width:80px; display:initial;" onchange="changeMonth();">
				<option value="1">1월</option>
				<option value="2">2월</option>
				<option value="3">3월</option>
				<option value="4">4월</option>
				<option value="5">5월</option>
				<option value="6">6월</option>
				<option value="7">7월</option>
				<option value="8">8월</option>
				<option value="9">9월</option>
				<option value="10">10월</option>
				<option value="11">11월</option>
				<option value="12">12월</option>
			</select>
			<button type="button" onclick="changeMonth(1);"><i class="fa fa-chevron-right"></i></button>
		</div>
		<table class="table table-bordered" style="width:90%; height:80%; text-align:center;" align="center">
			<thead>
				<tr>
					<th>일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
				</tr>
			</thead>
			<tbody id="tb_body">
			</tbody>
		</table>
	</div>
	<h4>시간</h4>
	<table>
		<tr id=showTime>
		</tr>
		<tr>
			<td>
			<input type="hidden" id="hours" name="hours"/>
			</td>
		</tr> 
	</table>
	<h4>인원</h4>
	<div id = showData>
		<select name="capacity"></select>
	</div>
	<input type="submit" value="예약하기">
	<input type="reset" value="취소">
	
</form>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script>
	//윤년체크
	function checkLeapYear(year){
		if(year%400 == 0){
			return true;
		}else if(year%100==0){
			return false;
		}else if(year%4 == 0){
			return true;
		}else{
			return false;
		}
	}
	//각 월의 1일이 무슨 요일인지
	function getFirstDayOfWeek(year,month){
		if(month < 10) month = "0" + month;
		
		return (new Date(year+"-"+month+"-01")).getDay();
	}
	//년, 월을 사용자가 선택하는 대로 변화
	function changeYearMonth(year,month){
		let month_day = [31,28,31,30,31,30,31,31,30,31,30,31]
		if(month == 2){
			//윤년인지 아닌지 확인, 윤년이면 28일을 29일로 변화
			if(checkLeapYear(year)) month_day[1] = 29;
		}
		let first_day_of_week = getFirstDayOfWeek(year,month);
		let arr_calendar=[];
		//1일이 시작되기 전 부분에 빈칸넣기
		for(let i=0; i<first_day_of_week; i++){
			arr_calendar.push("");
		}
		//1일부터 마지막날까지 입력
		for(let i=1; i<=month_day[month-1]; i++){
			arr_calendar.push(String(i));
		}
		//달을 7일로 나눠서 나머지를 빈칸으로 채움
		let remain_day=7 -(arr_calendar.length%7);
		if(remain_day < 7){
			for(let i=0; i<remain_day; i++){
				arr_calendar.push("");
			}
		}
		let today = new Date();
		let today_month= today.getMonth()+1;
		if(month<today_month){
			console.log("1.입력달: " + month);
			console.log("1.이번달"+today_month)
			renderCalendarPre(arr_calendar);
		}else if(month == today_month){
			console.log("2.입력달: " + month);
			console.log("2.이번달"+today_month)
			renderCalendarThis(arr_calendar);
		}else{
			console.log("3.입력달: " + month);
			console.log("3.이번달"+today_month)
			renderCalendar(arr_calendar);	//renderCalendar함수에 arr_calendar 배열을 넣어줌
		}
		
	}
	//위의 배열을 받아서 달력으로 출력
	function renderCalendar(data){
		let today = new Date();
		let today_date = today.getDate();
		console.log("1.today" + today);
		console.log("1.today_date" + today_date);
		let h = [];
		for(let i = 0; i<data.length; i++){
			if(i==0){
				h.push('<tr>');
			}else if(i%7 == 0){
				h.push('</tr>');
				h.push('<tr>');
			}
				h.push('<td onclick="setDate('+data[i]+');" style="cursor:pointer;">'+data[i]+'</td>');
			}
		h.push('</tr>');
		$("#tb_body").html(h.join(""));
	}
	function renderCalendarThis(data){
		let today = new Date();
		let today_date = today.getDate();
		console.log("2.today" + today);
		console.log("2.today_date" + today_date);
		let h = [];
		for(let i = 0; i<data.length; i++){
			if(i==0){
				h.push('<tr>');
			}else if(i%7 == 0){
				h.push('</tr>');
				h.push('<tr>');
			}
			if(data[i]<today_date){
				h.push('<td style="background-color:#EAEAEA;">'+data[i]+'</td>');
			}else if(today_date==data[i]){
				h.push('<td onclick="setDate('+data[i]+');" style="cursor:pointer; background-color:red;">'+data[i]+'</td>');
				console.log("일치" + data[i]);
			}else{
				h.push('<td onclick="setDate('+data[i]+');" style="cursor:pointer;">'+data[i]+'</td>');
				console.log("일치안함" + data[i]);
			}
		}
		h.push('</tr>');
		$("#tb_body").html(h.join(""));
	}
	
	function renderCalendarPre(data){
		let today = new Date();
		let today_date = today.getDate();
		console.log("1.today" + today);
		console.log("1.today_date" + today_date);
		let h = [];
		for(let i = 0; i<data.length; i++){
			if(i==0){
				h.push('<tr>');
			}else if(i%7 == 0){
				h.push('</tr>');
				h.push('<tr>');
			}
				h.push('<td style="background-color:#EAEAEA;">'+data[i]+'</td>');
			}
		h.push('</tr>');
		$("#tb_body").html(h.join(""));
	}
	
	function setDate(day){
		if(day<10) day="0" +day;
		$("#resDay").val(current_year + "-" + current_month + "-" + day);
		$("#div_calendar").hide();
	}
	//달력 변화
	function changeMonth(diff){
		if(diff == undefined){
			current_month = parseInt($("#month").val());
		}else{
			current_month = current_month +diff;
			if(current_month == 0){
				current_year = current_year -1;
				current_month = 12;
			}else if(current_month == 13){
				current_year = current_year +1;
				current_month = 1;
			}
		}
		loadCalendar();
	}
	//변화되는 년, 달에 따라 달력 변화
	function loadCalendar(){
		$("#year").val(current_year);
		$("#month").val(current_month);
		changeYearMonth(current_year,current_month);
	}
	let current_year=(new Date()).getFullYear();
	let current_month = (new Date()).getMonth()+1;
	
	$("#year").val(current_year);
	$("#month").val(current_month);
	
	changeYearMonth(current_year,current_month);
	let today = new Date();
	let today_date = today.getDate();
	
	$("#resDay").click(function(){
		$("#div_calendar").toggle();
	})
	

</script>
</body>
</html>