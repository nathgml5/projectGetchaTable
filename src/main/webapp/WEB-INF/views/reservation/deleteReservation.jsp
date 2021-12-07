<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url var="root" value="/"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.container{margin:50px;}
.btn_set{text-align: center;}
.btn_btn{color:white; background-color:black; border-color:black; font-size:15px; border-radius:5px; padding:5px 10px;}
</style>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="resources/css/member/member.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<body>
<c:if test="${!empty msg }"><script>alert('${msg}');</script></c:if>
<div class="container">
   <div class="row">
    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-login">
        <div class="panel-body">
          <div class="row">
            <div class="col-lg-12">
            	<h2>예약취소</h2>
            	<div class="form-group">
            		<input type=text name='restName' id='restName' tabindex="1" class="form-control" value="식당 :  ${res.restName }" disabled="disabled"/>
            	</div>
            	<div class="form-group">
            		<input type=text name='resDay' id='resDay' tabindex="1" class="form-control" value="예약일 :  ${res.resDay }" disabled="disabled"/>
            	</div>
            	<div class="form-group">
            		<input type=text name='hours' id='hours' tabindex="1" class="form-control" value="예약시간 :  ${res.hours }" disabled="disabled"/>
            	</div>
            	<div class="form-group">
            		<input type=text name='capacity' id='capacity' tabindex="1" class="form-control" value="예약인원 :  ${res.capacity }" disabled="disabled"/>
            	</div>
            	<div class="btn_set">
            		<input type="button" class="btn_btn" value="예약취소" onclick="location.href='${root}DeleteProc?resNum=${res.resNum}'"/>
					<input type="button" class="btn_btn" value="예약 내역" onclick="location.href='${root}reservationViewProc'"/>
            	</div>
            </div>
           </div>
          </div>
         </div>
        </div>
    </div>
 </div>
</body>