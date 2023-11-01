<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>

<style type="text/css">
#exampleFormControlInput1 {
	pointer-events: none;
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />

	<jsp:include page="../common/nav.jsp" />




	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">email</label> <input
			type="text" class="form-control" value="${mvo.email }"
			id="exampleFormControlInput1" name="email" placeholder="email"
			readonly="readonly">
	</div>

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">닉네임</label>
		<input type="text" class="form-control" value="${mvo.nickName}"
			id="exampleFormControlInput1" name="nickName" placeholder="닉네임"
			>
	</div>

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">둥록 날짜</label>
		<input type="text" class="form-control" value="${mvo.regAt }"
			id="exampleFormControlInput1" name="regAt" readonly="readonly">
	</div>
	
		<div class="mb-3">
		
		<label for="exampleFormControlInput1" class="form-label">등급</label>
<c:forEach items="${mvo.authList}" var="auth">


    <input type="text" class="form-control" value="${auth.auth}" id="exampleFormControlInput1" name="auth" readonly="readonly">
</c:forEach>
</div>
	
	<a href="/member/modify?email=${mvo.email}"><button type="button"
			class="btn btn-outline-dark">수정하기</button></a>
	
	<a href="/member/remove?email=${mvo.email}"><button type="button"
			class="btn btn-outline-dark">삭제하기</button></a>
		
	<script type="text/javascript" src="/resources/js/boardComment.js"></script>

	<jsp:include page="../common/footer.jsp" />
</body>
</html>