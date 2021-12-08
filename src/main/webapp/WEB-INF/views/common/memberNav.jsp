<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>

<nav class="navigate">
  <div class="d-flex flex-column flex-shrink-0 bg-light" style="height:100%; padding: 200px 10px 10px 10px;">
    <ul class="nav nav-pills flex-column mb-auto" style="text-align:center;">
      <li class="nav-item">
        <a href="${root}memberViewProc" id="managerListTab" class="nav-link link-dark" aria-current="page">
          회원정보
        </a>
      </li>
      <li>
        <a href="${root }reservationViewProc" id="managerRegisterTab" class="nav-link link-dark">
          예약확인
        </a>
      </li>
      <li>
        <a href="${root }reviewProc" class="nav-link link-dark">
          내 리뷰
        </a>
      </li>
      <li>
        <a href="${root }myCollectProc" id="guideTab" class="nav-link link-dark">
	    	관심식당
        </a>
      </li>
      <li>
	      <a href="${root}logout" class="nav-link link-dark">
	        로그아웃
	      </a>
      </li>
    </ul>
   </div>
</nav>