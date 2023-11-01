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

</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />

	<jsp:include page="../common/nav.jsp" />



	<form action="/member/modify" method="post">
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">email</label>
			<input type="text" class="form-control" value="${mvo.email }"
				id="exampleFormControlInput1" name="email" placeholder="email"
				readonly="readonly">
		</div>
		
				<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">비밀번호</label>
			<input type="text" class="form-control" value="${mvo.pwd}"
				id="exampleFormControlInput1" name="pwd" placeholder="패스워드를 입력하시오">
		</div>
		

		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">닉네임</label>
			<input type="text" class="form-control" value="${mvo.nickName}"
				id="exampleFormControlInput1" name="nickName" placeholder="닉네임">
		</div>

		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">둥록
				날짜</label> <input type="text" class="form-control" value="${mvo.regAt }"
				id="exampleFormControlInput1" name="regAt" readonly="readonly">
		</div>


		<button type="submit" class="btn btn-outline-dark">수정하기</button>

	</form>

	<script type="text/javascript" src="/resources/js/boardComment.js"></script>

	<jsp:include page="../common/footer.jsp" />
</body>
</html>