<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<style>
	#restBody{ display:flex; }
	#restNav{position:fixed; height:100%;}
	#restContent { overflow:auto;margin-left:240px; width:100%; padding:50px 50px 50px 50px; height:100%;
		background-image: url('resources/img/common/daeliseok.jfif');
		min-height: 100%; background-size: cover; }
</style>
<body id="restBody">
<div id="restNav">
	<c:import url="restNav.jsp"/>
</div>
<div id="restContent">	
	<c:import url="/${formpath }" />
</div>
</body>
</html>

