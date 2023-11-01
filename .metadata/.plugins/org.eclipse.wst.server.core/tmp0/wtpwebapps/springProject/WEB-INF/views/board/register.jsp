<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>                                                                                                                                                
<body>
<jsp:include page="../common/header.jsp" />

<jsp:include page="../common/nav.jsp" />

<sec:authentication property="principal.mvo.email" var="authEmail"></sec:authentication>
<form action="/board/register" method="post" enctype="multipart/form-data">
<div class="mb-3">
  <label for="exampleFormControlInput1" class="form-label">title</label>
  <input type="text" class="form-control" id="exampleFormControlInput1"  name ="title" placeholder="title" id="t">
</div>

<div class="mb-3">
  <label for="exampleFormControlInput1" class="form-label">writer</label>
  <input type="text" class="form-control" id="exampleFormControlInput1"  name ="writer" placeholder="글을 작성하세요." id="w" value="${authEmail }" readonly="readonly">
</div>
<div class="xon">
  <label for="exampleFormControlTextarea1" class="form-label">content</label>
  <textarea class="form-control" id="exampleFormControlTextarea1" name="content" rows="3"></textarea>
</div>

<div class="mb-3">
 
  <input type="file" class="form-control" name="files"   id="files" style="display: none" multiple="multiple">
<!--INPUT BUTTON TREIGGER 용도의 버튼  -->

<button type="button" id="trigger" class="btn btn-outline-success">파일 업로드</button><br><br>


</div>

<div class="mb-3" id="fileZone">

<!--  첨부파일이 표시되는 곳-->
</div>

<button type="submit" class="btn btn-outline-dark" id="regBtn">글쓰기 완료</button><br><br>
</form>
<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>