<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
   <!-- Bootstrap core CSS -->
<link href="resources/css/bootstrap/bootstrap.min.css" rel="stylesheet" >

<style>
#logoImg{ width:160px; margin:10%;}
.restNav{ margin-top:20px; }
</style>
<div class="d-flex flex-column flex-shrink-0 p-3 text-white bg-dark" style="width: 240px; height:100%; ">
    <div id="logoImg" ><img src="resources/img/logo/logo2.png" width="100%" onclick="location.href='main'"></div>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto restNav">
      <li class="nav-item">
        <a href="restMainProc" id="restMainTab" class="nav-link text-white" aria-current="page">       
          홈
        </a>
      </li>
      <li>
        <a href="selectRestReservationProc" id="bookingTab" class="nav-link text-white">
          예약 관리
        </a>
      </li>
      <li>
        <a href="restInfoProc" id="restInfoTab" class="nav-link text-white">
          
          식당 정보 상세보기
        </a>
      </li>
      <li>
        <a href="#" class="nav-link text-white">
          매출 정보
        </a>
      </li>
      <li>
        <a href="adminLogoutProc" class="nav-link text-white">
          로그아웃
        </a>
      </li>
    </ul>
    <hr>
  </div>
	
	