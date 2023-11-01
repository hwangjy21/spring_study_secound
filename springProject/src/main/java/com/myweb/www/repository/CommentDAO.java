package com.myweb.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myweb.www.domain.CommentVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.PagingHandler;

public interface CommentDAO {

	int insert(CommentVO cvo);

	/* List<CommentVO> getList(int bno); */

	int delete(long cno);

	int update(CommentVO cvo);

	PagingHandler getList(int bno, PagingVO pgvo);

	int selectOnBnoTotalCount(long bno);

	List<CommentVO> selectListPaging(@Param("bno") long bno, @Param("pgvo") PagingVO pgvo);

	void deleteAll(int bno);

}
