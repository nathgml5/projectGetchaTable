<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<c:if test="${empty sessionScope.email }">
	 <script>location.href='index?formpath=login';</script>
</c:if>
<head>
<title>GETCHA</title>
<link href="<c:url value="/resources/css/review/write.css" />" rel="stylesheet" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="resources/js/myPage/review_Write.js"></script>
</head>
<body>
	<div id="writing_Container">
	<form action="writeProc" method="post" enctype="multipart/form-data">
	    <div class="writing_Row">
	    <input type="hidden" name="restNum" value="${restNum }" />
	      <strong class="RestaurantName">${restName }</strong>
	    </div>
		<textarea name="content" id="content" class="form-control" rows="10" placeholder="음식은 어떠셨나요? 식당의 분위기와 서비스도 궁금해요!"></textarea>
		<p class="bytes" align="right">0 / 500</p>
		
		<div class="rate_wrap">
			<input type="hidden" name="point" id="point" />
            <div class="warning_msg">별점을 선택해 주세요.</div>
            <div class="rating">
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                <input type="checkbox" name="rating" id="rating1" value="1" class="rate_radio" title="1점" />
                <label for="rating1"></label>
                <input type="checkbox" name="rating" id="rating2" value="2" class="rate_radio" title="2점" />
                <label for="rating2"></label>
                <input type="checkbox" name="rating" id="rating3" value="3" class="rate_radio" title="3점" />
                <label for="rating3"></label>
                <input type="checkbox" name="rating" id="rating4" value="4" class="rate_radio" title="4점" />
                <label for="rating4"></label>
                <input type="checkbox" name="rating" id="rating5" value="5" class="rate_radio" title="5점" />
                <label for="rating5"></label>
            </div>
       	 </div>
       	<div class="upload_wrap">
		<div class="img_regi">
		    <div class="ph"><img id="ph" src="#" alt="" /></div>
		    <input type="file" accept="image/*" id="img_file" name="uploadFile1" />
		    <a href="#self">+ 사진 등록</a>
		</div>
		<div class="img_regi">
		    <div class="ph"><img id="ph2" src="#" alt="" /></div>
		    <input type="file" accept="image/*" id="img_file2" name="uploadFile2" />
		    <a href="#self">+ 사진 등록</a>
		</div>
		<div class="img_regi">
		    <div class="ph"><img id="ph3" src="#" alt="" /></div>
		    <input type="file" accept="image/*" id="img_file3" name="uploadFile3" />
		    <a href="#self">+ 사진 등록</a>
		</div>
		<div class="img_regi">
		    <div class="ph"><img id="ph4" src="#" alt="" /></div>
		    <input type="file" accept="image/*" id="img_file4" name="uploadFile4" />
		    <a href="#self">+ 사진 등록</a>
		</div>
		</div>
		<div class="button_wrap">
			<button type="submit" class="btn btn-dark">리뷰 작성</button>
			<button type="reset" class="btn btn-dark">새로입력</button>
		</div>
	</form>
	</div>

</body>
</html>