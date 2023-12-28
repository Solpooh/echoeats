package com.pofol.main.member.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pofol.main.member.dto.KakaoProfile;
import com.pofol.main.member.dto.MemberDto;
import com.pofol.main.member.dto.OAuthToken;
import com.pofol.main.member.handler.LoginSuccessHandler;
import com.pofol.main.member.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Controller
public class KakaoController {

    @Autowired
    AuthenticationManager authenticationManager;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    LoginSuccessHandler loginSuccessHandler;


    @GetMapping(value = "/auth/kakao/callback",produces = "text/plain; charset=UTF-8")
    public void kakaoCallback(String code, HttpServletRequest httprequest, HttpServletResponse httpresponse,
                                Authentication authentication) throws Exception {
        //post방식으로 key : value 형식으로 데이터를 요청(카카오쪽으로)
        //post방식은 url이나 a태그로 요청 못함, 그래서 RestTemplate를 사용
        RestTemplate rt = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");


        String fullURL = httprequest.getRequestURL().toString();
        System.out.println("fullURL: " + fullURL);

        String baseURL = fullURL.substring(0, fullURL.indexOf(httprequest.getRequestURI()));
        System.out.println("baseURL: " + baseURL);

        MultiValueMap<String,String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", "adb16712b617f7a830213eb50de44a79");
        params.add("redirect_uri", baseURL+"/auth/kakao/callback");
        params.add("code", code);

        //헤더와 바디를 하나의 오브젝트에 담기
        //exchange메서드가 매개변수에 HttpEntity라는 것을 넣게 되어 있다
        HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest =
                new HttpEntity<>(params,headers);

        //post방식으로 Http요청 - reponse변수에 응답 받음
        ResponseEntity <String> response = rt.exchange(
                "https://kauth.kakao.com/oauth/token",
                HttpMethod.POST,
                kakaoTokenRequest,
                String.class
        );

        ObjectMapper objectMapper = new ObjectMapper();
        OAuthToken oAuthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
        System.out.println("카카오 엑세스 토큰: "+oAuthToken.getAccess_token());


        //회원 정보 얻어오기
        RestTemplate rt2 = new RestTemplate();
        HttpHeaders headers2 = new HttpHeaders();
        headers2.add("Authorization","Bearer "+oAuthToken.getAccess_token());
        headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");


        //헤더와 바디를 하나의 오브젝트에 담기
        //exchange메서드가 매개변수에 HttpEntity라는 것을 넣게 되어 있다
        HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest =
                new HttpEntity<>(headers2);

        //post방식으로 Http요청 - reponse변수에 응답 받음
        ResponseEntity <String> response2 = rt2.exchange(
                "https://kapi.kakao.com/v2/user/me",
                HttpMethod.POST,
                kakaoProfileRequest,
                String.class
        );

        ObjectMapper objectMapper2 = new ObjectMapper();
        KakaoProfile kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);

        String id = kakaoProfile.getId() ;
        String name = kakaoProfile.getProperties().getNickname();
        String pwd = bCryptPasswordEncoder.encode("kakao");

        MemberDto memberDto1 = memberRepository.selectMember(id);

        System.out.println(memberDto1);

        //db에 없다면 회원가입 시킨다
        if (memberDto1 == null){
            MemberDto memberDto = new MemberDto(id,name,pwd);
            memberRepository.insertMember(memberDto);
        }

        //로그인 시켜서 - 인증을 진행
        Authentication authenticate = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(id, "kakao"));
        SecurityContextHolder.getContext().setAuthentication(authenticate);

        System.out.println("authenticate : "+authenticate);

        loginSuccessHandler.onAuthenticationSuccess(httprequest, httpresponse,authenticate);


    }
}
