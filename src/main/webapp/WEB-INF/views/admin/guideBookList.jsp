<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>가이드북 선정 리스트</title>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="resources/css/admin/guideBook.css" >
<script>
	function addGuide(){
		var i = document.getElementById('keyword').value;
		if(i == ""){
			alert('추가할 식당 정보를 입력하세요.');
			return;
		}
		var info = {key:i}
	
		$.ajax({
			url: "findRestaurant", type: "POST",
			data: JSON.stringify(info), // 문자열 데이터를 JSON 객체로 변환
		
			contentType: "application/json; charset=utf-8", // 보낼 데이터의 타입 설정
			dataType: "json", // 받을 데이터의 자료형을 설정
		
			success: function(result){
				if(result.restList == null){
					alert(result.resultMsg);
					document.getElementById('resultModal').style.display='block';					
				 }else{ 
					 values = result.restList ;
					 $.each(values, function( index, value ) {
	                       console.log( index + " : " + value.restName ); //Book.java 의 변수명을 써주면 된다.
							var tag = "<tr>"+
									"<td><input type='checkbox' name='add' value='"+value.restNum+"' style='width:30px'></td>"+
									"<td>" + value.restName+"</td>"+
									"<td>" + value.type+"·"+value.dong+"</td>"+
									"</tr>";
									
							$('#addGuideTable').append(tag); 
                    });	
				} 
				
				document.getElementById('resultModal').style.display='block';
			}, 
		 	error: function(){
				alert('error');
			}  
		})
	}

	
</script>


</head>
<body>
	<script>
		//내비에 선택된 탭 색깔 변경
		document.getElementById('guideTab').className = 'nav-link active';
	</script>
	
<c:if test="${!empty msg }">
	<script>alert("${msg}");</script>
</c:if>
<div style="padding-left:30px">
	<c:forEach var="i" begin="0" end="${max-min}" step="1" >
	<h5 style="margin-top:40px;">${max-i } 가이드북 선정 레스토랑</h5>
		<table class="bluetop">
			<tr>
				<th>식당 번호</th><th>식당 이름</th><th>지역</th><th>평점</th>
			</tr>
			<c:forEach var="guide" items="${ guideList}">
				<c:if test="${guide.guideBook == (max-i) }">
					<tr>
						<td style="text-align:center;">${guide.restNum }</td>
						<td style="width:300px;text-align:center;">${guide.restName }</td>
						<td style="width:100px;text-align:center;">${guide.dong }</td>
						<td style="width:80px;text-align:center;">${guide.avgPoint }</td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
		<p/>
		<p/>
	</c:forEach>
</div>

<div style="padding-left:30px;">	
	<form>
		<input type="text" id="keyword" placeholder="2021년 가이드북 선정 식당을 추가해주세요." style="height:40px; width:300px">
		<button type="button" onclick="addGuide()">찾기</button>
	</form>
	
	
	<div id="resultModal" class="modal">
	  <span onclick="$('#addGuideTable').empty();document.getElementById('resultModal').style.display='none'" class="close" title="Close Modal">&times;</span>
	  <form class="modal-content" action="addGuideBookProc">
	      <div class="container" style="overflow:auto; height:80%">
			  <table id="addGuideTable">
			  </table>
	      </div>
	      <div class="clearfix" style="height:22%;">
	          <button type="button" class="cancelbtn" style="height:100%;border-radius: 0px 0px 0px 2px;" 
	        	onclick="$('#addGuideTable').empty();document.getElementById('resultModal').style.display='none'" >취소</button>
	          <button type="submit" class="addbtn"  style="height:100%;border-radius: 0px 0px 2px 0px;">추가하기</button>
	      </div>
	  </form>
	</div>
</div>	

<script>
//Get the modal
var modal = document.getElementById('resultModal');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
	$('#addGuideTable').empty();
    modal.style.display = "none";
  }
}
</script>


</body>
</html>