package com.myweb.www.security;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MemberVO {
private String email;
private String pwd;
private String nickName;
private String regAt;
private String lastLogin;
private List<AuthVO> authList;
//AUTH의 권한을 받기 위해서


}