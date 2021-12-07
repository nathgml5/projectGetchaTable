<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<link href="resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript" src="resources/js/bootstrap/bootstrap.bundle.js" ></script>
<style>
.page{ text-decoration:none; text-decoration:underline; color: black; }
.page:hover{color:#A6A6A6;}
#list{border-spacing:10px; border-collapse: separate; text-align:center;}
</style>	

</head>


	<c:if test="${empty sessionScope.adminId }">
		<script>
			alert('최고 관리자 로그인이 필요합니다.');
			location.href='adminLogin';
		</script>
	</c:if> 
<center>
<c:url var="root" value="/" />
<c:if test="${!empty msg }">
	<script>alert("${msg}");</script>
</c:if>
<script>
	//내비에 선택된 탭 색깔 변경
	document.getElementById('managerListTab').className = 'nav-link active';
</script>

<table id="list">
	<tr height="50px;">
		<th>대표사진</th><th>식당 번호</th><th>식당 기본 정보</th><th>관리자 아이디</th><th>등록날짜</th>
	</tr>
	<c:forEach var="rest" items="${restList }" begin="${page.start}" end="${page.end}" step="1">
		<tr onclick="#" id='infoRow'>
			<td style="width: 160px; height:110px;" align="center">
				<c:if test="${rest.representImage != null }">
 					<img src="${root }upload/restaurant/${rest.representImage }" style="width:150; height:100;">
				</c:if>
			</td>
			<td style="width: 100px; height:40px;" align="center">
				${rest.restNum }
			</td>
			<td style="width: 200px; height:40px;" align="left">
				<strong>${rest.restName }</strong><br>${rest.type }·${rest.dong }<br>${rest.phone1 }
			</td>
			<td style="width: 120px; height:40px;" align="center">
				<div class="btn-group">
				  <button class="btn btn-secondary dropdown-toggle" type="button" id="defaultDropdown" data-bs-toggle="dropdown" data-bs-auto-close="true" aria-expanded="false">
				   ${rest.restId }
				  </button>
				  <ul class="dropdown-menu" aria-labelledby="defaultDropdown">
				    <li><a class="dropdown-item"  id="${rest.restNum }" onclick="deleteManager(this)">식당 관리자 삭제</a></li>
				    <%-- <li><a class="dropdown-item"  href="deleteManagerProc?restNum=${rest.restNum }" onclick="deleteManager(this)">식당 관리자 삭제</a></li> --%>
				  </ul>
				</div>
			</td>
			<td style="width: 120px; height:40px;" align="center">
				${rest.registerDate }
			</td>
			
		</tr>		
	</c:forEach>
</table>
<script>
function deleteManager(btn){
	var t= confirm("삭제하시겠습니까?");
	var num = $(btn).attr("id");
	if(t == true){
		location.href="deleteManagerProc?restNum="+num;		
	}
}
</script>

<c:choose>
	<c:when test="${page.pageNumber <= 1 }">
		<a href='managerListProc?pageNumber=1' class="page">이전</a>
	</c:when>
	<c:otherwise>
		<a href='managerListProc?pageNumber=${page.pageNumber-1 }' class="page">이전</a>
	</c:otherwise>
</c:choose>
<c:forEach var='num' begin='1' end='${page.totalPage }' step='1'>
	<c:choose>
		<c:when test='${page.pageNumber == num }'>
			${num }
		</c:when>
		<c:otherwise>
			<a href='managerListProc?pageNumber=${num }' class="page">${num }</a>
		</c:otherwise>
	</c:choose>
</c:forEach>
<c:choose>
	<c:when test="${page.pageNumber >= page.totalPage}">
		<a href='managerListProc?pageNumber=${page.totalPage }' class="page">다음</a>
	</c:when>
	<c:otherwise>
		<a href='managerProc?pageNumber=${page.pageNumber+1 }' class="page">다음</a>
	</c:otherwise>
</c:choose>

</center>