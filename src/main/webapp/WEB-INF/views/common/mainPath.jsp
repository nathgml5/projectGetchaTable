<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<link href="resources/css/common/index.css" rel="stylesheet" id="index">
<link href="resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
<body>
<c:import url="top.jsp" />
<c:import url="nav.jsp" />
<body>
	<div class="wrap">
		<div id="mainpath"><c:import url="/${formpath }" /> </div>
		<c:import url="footer.jsp" />
	</div>
</body>
</html>