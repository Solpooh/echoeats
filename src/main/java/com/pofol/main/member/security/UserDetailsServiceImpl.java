package com.pofol.main.member.security;

import com.pofol.main.member.dto.MemberDto;
import com.pofol.main.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    MemberService service;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;


    //security-context(Authentication(Userdetails))
    @Override
    public UserDetails loadUserByUsername(String mem_id) throws UsernameNotFoundException {

        System.out.println("---------------UserDetailsService---------------");


        MemberDto vo2 = null;
        try {
            vo2 = service.select(mem_id);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        System.out.println(vo2);
        if (vo2 == null) {
            return null;
        }

        //UserDetails 객체 생성 (Authentication에 넣기 위해)
        SecurityUser securityUser = new SecurityUser();

        securityUser.setUsername(vo2.getMem_id());
        String pwd = vo2.getMem_pwd();
        securityUser.setPassword(pwd);
        securityUser.setMem_name(vo2.getMem_name());

        List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
        grantedAuthorities.add(new SimpleGrantedAuthority(vo2.getRole()));
        securityUser.setAuthorities(grantedAuthorities);


        System.out.println("securityUser = " + securityUser);


        return securityUser;
    }


}


//        Authentication authentication = new UsernamePasswordAuthenticationToken(
//                securityUser,securityUser.getPassword(),securityUser.getAuthorities());
//
//        System.out.println("authentication = " + authentication);
//
//        SecurityContextHolder.getContext().setAuthentication(authentication);