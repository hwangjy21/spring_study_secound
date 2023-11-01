package com.myweb.www.security;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.myweb.www.repository.MemberDAO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class CustomAuthMemberServic implements UserDetailsService {
//DB와 확인을 해주는 역할을 하는 서비스
	@Inject
	private MemberDAO mdao;
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//userName DB에 설정되어있는 email 인지를 체크해서
		//인증하여 해당 객체를 AuthMember로 리턴
		//db와 매칭을 하여
		
		//username에 로그인 정보가 들어온다.
		
		//DB
		MemberVO mvo = mdao.selectEmail(username);
		
		if(mvo==null) {
			throw new UsernameNotFoundException(username);
		}
		mvo.setAuthList(mdao.selectAuths(username));
		log.info(">>>>>userDetails>>"+mvo);
	
		return new AuthMember(mvo);
	}

}
