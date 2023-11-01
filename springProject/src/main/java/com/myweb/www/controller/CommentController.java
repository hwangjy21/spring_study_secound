package com.myweb.www.controller;

import java.security.Principal;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.myweb.www.domain.CommentVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.PagingHandler;
import com.myweb.www.security.MemberVO;
import com.myweb.www.service.CommentService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/comment/*")
@RestController
public class CommentController {

	@Inject
	private CommentService csv;

	@PostMapping(value = "/post", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> post(@RequestBody CommentVO cvo) {
		log.info(">>>>>cvo>>" + cvo);
		int isOk = csv.post(cvo);
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping(value = "/{bno}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PagingHandler> spread(@PathVariable("bno") long bno, @PathVariable("page") int page) {
		log.info(">>>>> comment List bno/page >> " + bno + "/" + page);
		/*
		 * List<CommentVO> list = csv.getList(bno);
		 */
		PagingVO pgvo = new PagingVO(page, 5);
		return new ResponseEntity<PagingHandler>(csv.getList(bno, pgvo), HttpStatus.OK);

	}

	@DeleteMapping(value = "del/{cno}/{writer}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> delete(@PathVariable("cno") int cno, @PathVariable("writer") String writer,
			HttpServletRequest req, Principal principal) {
		log.info(" >>>> cno / writer  >> " + cno + " / " + writer);
		int isOk = 0;
		/* HttpSession ses = req.getSession(); */
		/* if(ses!=null) { */
		/* MemberVO mvo = (MemberVO) ses.getAttribute("ses"); */
		
		//로그인의 사용자 계장
		String username = principal.getName();
		/*
		 * log.info(">>>>>ses>>"+ses);
		 */
		if (writer.equals(username)) {

			isOk = csv.remove(cno);

		}

		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}


	@PutMapping(value = "/{cno}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> edit(@PathVariable("cno") long cno, @RequestBody CommentVO cvo
			) {
		log.info(" >>>> cno /: cvo >> " + cno + " / " + cvo);
		int isOk = 0;
		/*String username = principal.getName();
		log.info(username);
		if (writer.equals(username)) {*/
			isOk = csv.edit(cvo);

			/* } */
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
