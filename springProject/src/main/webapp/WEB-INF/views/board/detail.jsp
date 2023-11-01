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

	<c:set value="${bdto.bvo }" var="bvo"></c:set>



	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">BNO</label> <input
			type="text" class="form-control" value="${bvo.bno }"
			id="exampleFormControlInput1" name="bno" placeholder="title"
			readonly="readonly">
	</div>

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">title</label>
		<input type="text" class="form-control" value="${bvo.title }"
			id="exampleFormControlInput1" name="title" placeholder="title"
			readonly="readonly">
	</div>

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">writer</label>
		<input type="text" class="form-control" value="${bvo.writer }"
			id="exampleFormControlInput1" name="writer" readonly="readonly">
	</div>

	<div class="xon">
		<label for="exampleFormControlTextarea1" class="form-label">content</label>
		<textarea class="form-control" id="exampleFormControlTextarea1"
			readonly="readonly" name="content" rows="3">${bvo.content }</textarea>
	</div>

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">등록 날짜</label>
		<input type="text" class="form-control" value="${bvo.regAt}"
			id="exampleFormControlInput1" name="modAt" readonly="readonly">
	</div>

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">수정 날짜</label>
		<input type="text" class="form-control" value="${bvo.modAt}"
			id="exampleFormControlInput1" name="modAt" readonly="readonly">
	</div>

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">조회수</label> <input
			type="text" class="form-control" value="${bvo.readCount}"
			id="exampleFormControlInput1" name="modAt" readonly="readonly">
	</div>

	<!-- 파일 표시 영역 -->
	<div>
		<ul>

			<!-- file 개수 만큼 li를 추가하여 파일을 표시 타입이 1일 경우만 표시-->
			<!-- li 
					div => img 그림표시
					div=> div 파일이름 , 작성일자 span 크기 설정
						 -->
			<c:set value="${bdto.flist}" var="flist"></c:set>
			<!-- 하나의 파일만 따와서 fvo로 저장 -->
			<c:forEach items="${flist}" var="fvo">
				<li style="margin-left: -1%; list-style: none;"><c:choose>
						<c:when test="${fvo.fileType>0 }">

							<div>

								<!-- /upload/year/month/dat/uuid_(th)_file_name -->

								<img style="width: 300px; height: 300px;" alt="그림 없당"
									src="/upload/${fn: replace(fvo.saveDir,'\\','/')}/
										${fvo.uuid}_${fvo.fileName}">

							</div>
						</c:when>
						<c:otherwise>

							<div>
								<!-- file 아이콘 같으 모양 값으로 넣을 수 있음 -->
							</div>
						</c:otherwise>

					</c:choose>
					<div>
						<br>

						<h4>
							${fvo_uuid}_${fvo.fileName } <span class="badge bg-secondary">
								${fvo.fileSize }byte</span>
						</h4>
					</div>


					<hr></li>
			</c:forEach>


		</ul>

	</div>


	<a href="/board/modify?bno=${bvo.bno}"><button type="button"
			class="btn btn-outline-dark" id="memberBtn">수정하기</button></a>


	<a href="/board/delete?bno=${bvo.bno}"><button type="button"
			class="btn btn-outline-dark"  id="memberBtn2">삭제하기</button></a>


	<br>
	<hr>

	<!-- 댓글 라인 -->

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.mvo.email" var="authEmail"></sec:authentication>
		<div>
			<div class="input-group mb-3">
				<span class="input-group-text" id="cmtWriter">${authEmail }</span> <input
					type="text" class="form-control" placeholder="댓글을 입력하세요"
					id="cmtText">
				<button type="button" class="btn btn-outline-dark" id="cmtPostBtn">댓글
					완료</button>
			</div>
		</div>

	</sec:authorize>

	<!--댓글 표시라인 -->
	<ul class="list-group list-group-flush" id="cmtListArea">
		<li class="list-group-item">
			<div class="mb-3">
				<div class="fw-bold">Writer</div>
				Content
			</div> <span class="badge rounded-pill text-bg-dark">modAt</span>

		</li>



		<li class="list-group-item">
			<div class="mb-3">
				<div class="fw-bold">Writer</div>
				Content
			</div> <span class="badge rounded-pill text-bg-dark">modAt</span>

		</li>

	</ul>




	<!-- 댓글 페이징 라인 -->
	<div>
		<div>

			<button type="button" id="moreBtn" data-page="1" class="btn btn-dark"
				style="visibility: hidden">MORE+</button>
		</div>

	</div>
	<!-- 모달 창 라인 -->

	<div class="modal" tabindex="-1" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" name="writer">${authEmail }</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="input-group mb-3">

						<input type="text" class="form-control" placeholder="댓글을 입력하세요"
							id="cmtTextMod">
						<button type="button" class="btn btn-outline-dark" id="cmtModBtn">댓글
							완료</button>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>

					</div>
				</div>
			</div>
		</div>

	</div>
	<script type="text/javascript">
		let isMod = '<c:out value="${isMod}"/>';
		console.log(isMod);
		if (parseInt(isMod)) {
			alert("게시글 수정 성공");
		}

		let bnoVal = '<c:out value="${bvo.bno}" />';
		let authEmail = '<c:out value="${authEmail}" />';
		let bvoWriter = '<c:out value="${bvo.writer}" />'; // 새로운 변수 bvoWriter를 정의

		console.log(bnoVal + " / " + authEmail);
		
		let memberBtn = document.getElementById("memberBtn");
		
		let memberBtn2 = document.getElementById("memberBtn2");
		if (bvoWriter != authEmail) {
			memberBtn.style.display = "none";
			memberBtn2.style.display = "none";
		}
	</script>

	<script type="text/javascript" src="/resources/js/boardComment.js"></script>

	<jsp:include page="../common/footer.jsp" />

</body>
</html>