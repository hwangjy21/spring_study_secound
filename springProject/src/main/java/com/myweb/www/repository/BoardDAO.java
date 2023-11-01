package com.myweb.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	List<BoardVO> list(PagingVO pagingVO);

	BoardDTO detail(int bnso);

	int modify(BoardVO bvo);

	int readCount(@Param("bno")long bno, @Param("cnt")int cnt);

	int delete(int bno);

	int totalCount(PagingVO pagingVO);

	long selectOneBno();

	BoardVO getDetail(long bno);

	BoardVO getDetail1(long bno);

	int f_total(BoardVO bvo);

	int c_total(BoardVO bvo);





}
