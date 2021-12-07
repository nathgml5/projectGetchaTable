<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>

<nav class="navigate">
  <div class="d-flex flex-column flex-shrink-0 bg-light" style="height:100%; padding: 200px 10px 10px 10px;">
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href="managerListProc" id="managerListTab" class="nav-link link-dark" aria-current="page">
          식당 관리자 전체
        </a>
      </li>
      <li>
        <a href="indexPath?formpath=managerRegister" id="managerRegisterTab" class="nav-link link-dark">
          식당 관리자 추가
        </a>
      </li>
      <li>
        <a href="#" class="nav-link link-dark">
          
          매거진
        </a>
      </li>
      <li>
        <a href="guideBookListProc" id="guideTab" class="nav-link link-dark">
    
          2021 가이드북 선정
        </a>
      </li>
      <li>
	      <a href="adminLogoutProc" class="nav-link link-dark">
	        
	        로그아웃
	      </a>
      </li>
    </ul>
   </div>
</nav>