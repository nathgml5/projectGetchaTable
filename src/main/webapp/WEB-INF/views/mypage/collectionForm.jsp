<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="<c:url value="/resources/css/collection/collection.css" />" rel="stylesheet" />
<script src="resources/js/myPage/collection.js"></script>
<c:url var="root" value="/" />
<title>Getcha Table</title>
<body>
	<div id="PageTitle"><h2>관심 식당</h2></div>
	<div id="CollectionPage_Container">
	<c:forEach var="list" items="${collectionList }">
		<div class="container_Row">
			<table class="rest_summary">
				<tr>
					<td rowspan="3" colspan="2">
						<div class="representImg_wrap">
							<a href="restViewProc?restNum=${list.restNum }" class="link-dark">
							<img src="resources/img/restaurant/${list.representImage }" style="height:100%; width:100%;">
							</a>
						</div>
					</td>
					<td>
						<a href="restViewProc?restNum=${list.restNum }" class="link-dark">${list.restName }</a>
						<span><img src="resources/img/icon/star.png" width="20"> ${list.avgPoint }</span>
					</td>
				</tr>
				<tr>
					<td>
						<span>${list.type } / ${list.dong }</span>
					</td>
				</tr>
				<tr><td></td></tr>
			</table>
			<div class="button_wrap">
				<button data-id="${list.restNum }" class="calBtn">취소</button>
			</div><hr>
		</div>
	</c:forEach>
	</div>
</body>