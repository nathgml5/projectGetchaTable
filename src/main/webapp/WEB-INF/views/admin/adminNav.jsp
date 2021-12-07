<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<link href="resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
<!DOCTYPE html>

<style>
.navigate{
position:fixed; font-size:14px; z-index:1; height:100%;
}
</style>

<nav class="navigate">
  <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px; height:100%; ">
    	<a href="main" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
	      <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
	      <img class="fs-4" src="resources/img/logo/logo.png" width="120">
	    </a>
	    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href="managerListProc" id="managerListTab" class="nav-link link-dark" aria-current="page">
          <svg class="bi me-2" width="16" height="16"><use xlink:href="#home"/></svg>
          식당 관리자 전체
        </a>
      </li>
      <li>
        <a href="admin?formpath=managerRegister" id="managerRegisterTab" class="nav-link link-dark">
          <svg class="bi me-2" width="16" height="16"><use xlink:href="#speedometer2"/></svg>
          식당 관리자 추가
        </a>
      </li>
      <li>
        <a href="#" class="nav-link link-dark">
          <svg class="bi me-2" width="16" height="16"><use xlink:href="#table"/></svg>
          매거진
        </a>
      </li>
      <li>
        <a href="guideBookListProc" id="guideTab" class="nav-link link-dark">
          <svg class="bi me-2" width="16" height="16"><use xlink:href="#grid"/></svg>
          2021 가이드북 선정
        </a>
      </li>
      <li>
	      <a href="adminLogoutProc" class="nav-link link-dark">
	        <svg class="bi me-2" width="16" height="16"><use xlink:href="#people-circle"/></svg>
	        로그아웃
	      </a>
      </li>
    </ul>
   </div>
</nav>