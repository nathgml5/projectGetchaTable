<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대표 메뉴 등록</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="resources/js/restManagement/menuRegister.js" ></script>
<style>
input{border:none;}
#submitBtn{ width:200px; height:40px;}
</style>
</head>
<body>
	<br>
	<h3>메뉴 등록</h3>
	<br>
	<form name="f" action="menuRegisterProc" method="post" enctype="multipart/form-data" >
	<input type="file" id="inWholeMenu" name="wholeMenu" style="display:none;" multiple> 
       <label for="inWholeMenu">메뉴판 사진 업로드 <img src="resources/img/icon/upload.png" width="20"></label>
	<div class="wholeMenuPreview">
			
	</div>
	<br>
	<br>
		<input type="hidden" id="inputOrNot" name="inputOrNot"> 
		<table border="1" id="registerTable">
			<tr id="trMenu">
				<th style="width:150px">분류</th><th style="width:150px">메뉴명</th>
				<th style="width:100px">가격</th><th style="width:150px;">메뉴 이미지</th><th style="width:60px;"></th>
			</tr>
			<tr style="height:50px;">
				<td><input type="text" id="Category0"  name="category" placeholder="분류" style="width:95px"></td>
	            <td><input type="text" id="menuName0" name="menuName" placeholder="메뉴명" style="width:145px"></td>
	            <td><input type="number" id="unitPrice0" name="unitPrice" placeholder="가격" style="width:100px"></td>
	            <td>
	            	<input type="file" id="menuImage0" name="menuImage" style="display:none;" onchange="previewImg(this)">
  					<label for="menuImage0"><img name="menuImage0" src="resources/img/icon/upload.png" width="20"></label>
	            </td>
	            <td style="width:60px;"></td>
			</tr>
		</table>
		<br>
		<div>
			<button type="button" onclick="addModifyRow()">추가</button>
		</div>
		<br>
		<input type="submit" value="메뉴 등록하기" id="submitBtn">		  
	</form>
	<br><br>
	<hr><br>
</body>
</html>