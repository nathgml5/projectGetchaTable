<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="<c:url value="/resources/css/review/review.css" />" rel="stylesheet" />
<script src="resources/js/myPage/reviewList.js"></script>
<c:url var="root" value="/" />
<c:if test="${empty sessionScope.email }">
	 <script>location.href='index?formpath=login';</script>
</c:if>
<title>Getcha Table</title>
<body>
	<div id="PageTitle"><h2>나의 후기</h2></div>

	<div id="ReviewPage_Container">
	<c:forEach var="list" items="${reviewList }">
		<form action="updateProc" method="post">
		<input type="hidden" name="reviewNum" value="${list.reviewNum }" />
		<input type="hidden" name="restNum" value="${list.restNum }" />
		<input type="hidden" name="restName" value="${list.restName }" />
		<input type="hidden" name="content" value="${list.content }" />
		<input type="hidden" name="fileNames" value="${list.fileNames }" />
			<div class="Review_Row">
				<div class="title"><a href="restViewProc?restNum=${list.restNum }" class="link-dark"><label>${list.restName }</label></a>
					<c:forEach begin="1" end="${list.point }" step="1">
						<img src="resources/img/icon/star.png">
					</c:forEach>
				</div>
				<div class="contentBox"><pre>${list.content }</pre></div>
					<div class="image_wrap">
					<c:if test="${list.fileNames != '파일없음' }">
						<c:forTokens var="fileName" items="${list.fileNames }" delims=",">
						<div class="review_image">
							<img src="${root }upload/${fileName }" style="height:100%; width:100%; "> 
						</div>
						</c:forTokens>
					</c:if>
					</div>
				<div>
					<p class="date">${list.writeDate }</p>
				</div>
				<div class="button_wrap">
					<button type="submit" class="modiBtn">수정</button>
					<button type="button" data-id="${list.reviewNum }" data-fileName="${list.fileNames}" class="delBtn">삭제</button>
				</div>
			</div>
		</form>
		<hr>	
	</c:forEach>
	</div>
</body>