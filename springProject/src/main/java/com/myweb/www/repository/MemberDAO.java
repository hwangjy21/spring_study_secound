package com.myweb.www.repository;

import java.util.List;

import com.myweb.www.security.AuthVO;
import com.myweb.www.security.MemberVO;

public interface MemberDAO {

	int insert(MemberVO mvo);



	int insertAuthInit(String email);



	MemberVO selectEmail(String username);



	List<AuthVO> selectAuths(String username);



	int updateLastLogin(String authEmail);



	List<MemberVO> list(MemberVO mvo);



	List<AuthVO> getList_a(MemberVO mvo);



	MemberVO getDetail(String email);



	int modify(MemberVO mvo);



	int delete(String email);



	void delete_a(String email);



	void getDetail_a(String email);



	List<AuthVO> getDetail_ab(String email);

}
