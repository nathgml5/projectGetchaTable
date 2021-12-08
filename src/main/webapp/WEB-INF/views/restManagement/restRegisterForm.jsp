<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식당 정보 등록</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<!-- 다음 주소 창 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 카카오 주소 라이브러리 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ca9e6dca916cb522a752c40d791a9b9&libraries=services"></script>
<!-- timepicker 플러그인 링크 -->
<script type="text/javascript" src="resources/js/restManagement/jquery.timepicker.min.js" ></script><!-- 타이머js -->
<link type="text/css" rel="stylesheet" href="resources/css/restManagement/jquery.timepicker.css" media=""/><!-- 타이머css -->
<!-- 이 페이지 자바스크립트 링크 -->
<script type="text/javascript" src="resources/js/restManagement/restRegister.js" ></script>
<link type="text/css" rel="stylesheet" href="resources/css/restManagement/restRegister.css" />

</head>

<body>
<c:if test="${!empty msg }"><script>alert('${msg}');</script></c:if>
	<h3 style="text-align:center;">식당 정보 등록</h3>
	<form id="f" action="restRegisterProc" method="post" enctype="multipart/form-data">
		<table style="margin:auto; width:900px;">
			<tr>
				<td width="30%"> 식당 이름 </td>
				<td width="70%"> 
					<input type="text" name="restName" id="restName"><br>
					<label id="warnRestName" style="color:red;"></label>
				</td>
			</tr>
			<tr>
				<td> 한줄 소개 글 </td>
				<td> 
					<textarea cols="50" rows="4" name="restIntro" id="restIntro"></textarea><br>
					<label id="warnRestIntro" style="color:red;"></label>
				</td>
			</tr>
			<tr>
				<td> 식당 주소 </td>
				<td>
					<input type="text" name="zipcode" id="zipcode" readonly="readonly" style="width:60px;">
					<input type="button" value="우편번호 검색" onclick="daumPost();"><br>
					<input type="text" name="address" placeholder="주소" id="addr1" readonly="readonly" style="width:300px;" onchange="findCor()"><br>
					<input type="text" name="address" placeholder="상세주소" id="addr2" onchange="findCor()"><br>
					<label id="warnAddr" style="color:red;"></label>
					<input type="hidden" id="corX">
					<input type="hidden" id="corY">
					<input type="hidden" id="dong" name="dong">
				</td>
			</tr>		
			<tr>
				<td> 식당 종류 </td>
				<td>
					<select name="type" id="type"> 
						<option value="">선택</option>
						<option value="한식">한식</option>
						<option value="일식">일식</option>
						<option value="중식">중식</option>
						<option value="이탈리아음식">이탈리아음식</option>
						<option value="인도음식">인도음식</option>
						<option value="태국음식">태국음식</option>
						<option value="베트남음식">베트남음식</option>
						<option value="프랑스음식">프랑스음식</option>
						<option value="스페인음식">스페인음식</option>
						<option value="퓨전음식">퓨전음식</option>
						<option value="direct">직접입력</option>
					</select>
					<input type="text" id="typeDirect" name="type"><br>
					<label id="warnType" style="color:red;"></label>
				</td>
			</tr>
			<tr>
				<td> 영업 시간 </td>
				<td>
					<div id="openHour"></div>
					<select id="openingDay">
						<option value="매일">매일</option>
						<option value="주중">주중</option>
						<option value="주말">주말</option>
						<option value="월요일">월요일</option>
						<option value="화요일">화요일</option>
						<option value="수요일">수요일</option>
						<option value="목요일">목요일</option>
						<option value="금요일">금요일</option>
						<option value="토요일">토요일</option>
						<option value="일요일">일요일</option>					
					</select>
					<select id="openingSel">
						<option value="">선택 안함</option>				
						<option value="점심">점심</option>
						<option value="저녁">저녁</option>
						<option value="휴무">휴무</option>				
					</select>
					<div id="hours" style="display:inline;">
						<input type="text" id="start"  maxlength="10" style="width:40px" class="setDatePicker">
			            -
			            <input type="text" id="end"  maxlength="10" style="width:40px" class="setDatePicker">
					</div>
					<input type="button" onclick="addOpening()" value="추가"><br>
					<label id="warnOpenHour" style="color:red;"></label>
				</td>
			</tr>
			<tr>
				<td> 수용 가능 인원 </td>
				<td>
					<!-- 숫자만 입력 가능 정규 표현식 사용 -->
					<input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" 
						name="capacity" id="capacity" style="width:30px"/> 명<br>
					<label id="warnCapacity" style="color:red;"></label>
				</td>
			</tr>
			<tr>
				<td> 부대시설 </td>
				<td>
				<div class="facilityIcon">
					<input type="checkbox" id="parking" name="facilities" value="주차 가능" >
					<label for="parking" ><img src="resources/img/icon/ic_parking.svg" width="40"  style="margin:auto;"><br>주차 가능</label>
				</div>
				<div class="facilityIcon" >
					<input type="checkbox" id="valet" name="facilities" value="발렛 가능" >
					<label for="valet"><img src="resources/img/icon/ic_valet_parking.svg" width="40"><br>발렛 가능</label>
				</div>
				<div class="facilityIcon">	
					<input type="checkbox" id="group" name="facilities" value="단체석">
					<label for="group"><img src="resources/img/icon/ic_group_seat.svg" width="40"><br>단체석</label>
				</div>
				<div class="facilityIcon">
					<input type="checkbox" id="baby" name="facilities" value="아기의자">
					<label for="baby"><img src="resources/img/icon/ic_baby_seat.svg" width="40"><br>아기의자</label>
				</div>
				<div class="facilityIcon">
					<input type="checkbox" id="corkage" name="facilities" value="콜키지 가능">
					<label for="corkage"><img src="resources/img/icon/ic_corkage.svg" width="40"><br>콜키지 가능</label>
				</div>
				<div class="facilityIcon" >
					<input type="checkbox" id="room" name="facilities" value="개별 룸">
					<label for="room"><img src="resources/img/icon/ic_room.svg" width="40"><br>개별 룸</label>
				</div>
				<div class="facilityIcon" >
					<input type="checkbox" id="sommelier" name="facilities" value="전문 소믈리에">
					<label for="sommelier"><img src="resources/img/icon/ic_sommelier.svg" width="40"><br>전문 소믈리에</label>
				</div>
				<div class="facilityIcon" >
					<input type="checkbox" id="rent" name="facilities" value="대관 가능">
					<label for="rent"><img src="resources/img/icon/ic_rent.svg" width="40"><br>대관 가능</label>
				</div>
				<div class="facilityIcon">
					<input type="checkbox" id="nokids" name="facilities" value="노키즈존">
					<label for="nokids"><img src="resources/img/icon/ic_nokids.svg" width="40"><br>노키즈존</label>
				</div>
				<div class="facilityIcon" >
					<input type="checkbox" id="late" name="facilities" value="심야 영업">
					<label for="late"><img src="resources/img/icon/ic_late_sales.svg" width="40"><br>심야 영업</label>
				</div>
				</td>
			</tr>
			<tr>
				<td> 식당 사진 (최대 6장) </td>
				<td> 
					<div>
						<div class="previewImgs" >
							
						</div>
					</div>
					<input multiple="multiple" type="file" id="restImage" name="restImage" style="width: 300px">
				</td>
			</tr>
			<tr>
				<td> 프로모션 </td>
				<td> 
					<div>
						<div id="previewImg">
							<img id="previewPromotion" style="width:100%;height:100%;"/>
						</div>
					</div>
					<input type="file" id="promotion" name="promotion" style="width: 300px" accept="image/*">
				</td>
			</tr>
		</table>
		<div style="margin-left:50%">
			<input type="button" value="다음 : 메뉴등록" onclick="submitBtn()">
			<input type="button" value="취소" onclick="location.href='logoutProc'">
		</div>
	</form>
</body>

</html>