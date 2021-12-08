<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<link href="resources/css/common/index.css" rel="stylesheet" id="index">
<link href="resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
	<c:import url="top.jsp" />
	<c:choose>
		<c:when test="${not empty sessionScope.adminId && sessionScope.adminId == 'admin'  }">
			<c:import url="adminNav.jsp" />
		</c:when>
		<c:when test="${not empty sessionScope.adminId && sessionScope.adminId != 'admin'  }">
			<c:import url="restNav.jsp" />
		</c:when>
		<c:when test="${not empty sessionScope.email }">
		</c:when>
		<c:otherwise>
			<c:import url="nav.jsp" />
		</c:otherwise>
	</c:choose>
<body>
	<div class="wrap">
		<div id="formpath" style="margin-left:30%;"><c:import url="/${formpath }" /> </div>
		<c:import url="footer.jsp" />
	</div>
</body>
</html>