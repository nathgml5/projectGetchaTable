<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<link href="resources/css/common/index.css" rel="stylesheet" id="index">
<body>
<c:import url="nav.jsp" />
<div id="index">
	<div id="head"> <c:import url="top.jsp" /></div>
	<div id="formpath"><c:import url="/${formpath }" /> </div>
	<div id="foot"> <%@include file="footer.jsp"  %></div>
</div>
</body>
</html>