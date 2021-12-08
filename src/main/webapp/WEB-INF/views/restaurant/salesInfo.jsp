<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출확인</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
  <script>
  $( function() {
    var dateFormat = "mm/dd/yy",
      from = $( "#from" )
        .datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          maxDate:0,
          numberOfMonths: 2
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#to" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        maxDate:0,
        numberOfMonths: 2
      })
      .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
      });
 
    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
 
      return date;
    }
  } );
  
  $(document).on("click","button[name=confirm]",function(){
      var start = $('#from').val();
      var end = $('#to').val();
	  $('#period').html(start+"-"+end+"매출 조회 결과입니다."); 
	        
	});
  
  </script>
</head>
<body>

<!-- 오늘 , 근 한달, 근 1년 등 버튼 만들기 -->


	<c:import url="restTop.jsp"/>
	<hr>
	<br>
	<label>조회 기간</label>
	<input type="text" id="from" name="from">
	<label>-</label>
	<input type="text" id="to" name="to">
	<button name="confirm">확인</button><br><br>
	<h4 id="period"></h4>
	<hr>
	<h3>그래프</h3>
	<hr>
	<h3>테이블</h3>

</body>
</html>