package com.pofol.main.member.controller;

import com.pofol.main.member.dto.MemberDto;
import com.pofol.main.member.repository.MemberRepository;
import com.pofol.main.member.security.SecurityUser;
import com.pofol.main.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@Controller
@RequestMapping("/member")
public class MemberController {
    @Autowired
    MemberService memberService;
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @RequestMapping(value = "/login_form", method = RequestMethod.GET)
    public String loginGET(HttpServletRequest request,HttpServletResponse response, Model model, Authentication authentication) {
        HttpSession session = request.getSession();
        //만약 인증이 되어 있는 회원이면 이전에 왔던 곳에서 리다이렉트
        //1. 인증된 회원과 익명사용자의 Authentication을 확인
        System.out.println("로그인GET : " + authentication);
        String referer = request.getHeader("Referer"); //login_form
        String ser = request.getServletPath();
        System.out.println("ser : " +ser);

        //동적 url
        String fullURL = request.getRequestURL().toString();
        String baseURL = fullURL.substring(0, fullURL.indexOf(request.getRequestURI()));

        //referer - o 버튼으로 들어옴
        //referer - x url
        //loginsuccesshandler를 위해 존재
        if(referer != null){
            session.setAttribute("referer", referer);
        }else {
            session.removeAttribute("referer");
        }
        System.out.println("referer  :  "+referer);

        //로그인 실패 메세지
        //로그인 실패 - 홈페이지 - 로그인 페이지 - 문구가 없어지지 않고 여전히 있음
        String errormsg = (String)session.getAttribute("errormsg");
        if(errormsg != null){
            model.addAttribute("errormsg", errormsg);
            session.removeAttribute("errormsg");
        }
        String input_id = (String) session.getAttribute("input_id");
        if(input_id != null){
            model.addAttribute("input_id", input_id);
            session.removeAttribute("input_id");
        }

        //2. 게시판 - 로그인 - 게시판
        // 그냥 로그인 버튼을 클릭했을 경우 login success에서 referer이나 savedRequest는 생기지 않는다(가로챘을때는 생김)
        //그래서 referer을 세션에 저장해서 로그인 성공했을 경우 referer쪽으로 보낸다
        //12월11일 로그인 - url에 로그인 폼 - 500에러 (referer nullpoint)
        if (authentication != null) {
            if(referer == null){
                System.out.println("들옴");

                return "redirect:"+baseURL+"/main";
                //return "main";

            }
            if(referer.contains("/member/login_form")){
                System.out.println("인증이 되고 referer가 login폼");
                return "main";
            }else {
                return "redirect:" + referer;
            }
        }else {
            return "member/login_form";
        }
    }




    @GetMapping("/join")
    public String memberJoin() {
        return "member/join_form";
    }

    //회원가입
    @PostMapping("/join")
    @ResponseBody
    public MemberDto join(@RequestBody MemberDto memberDto) throws Exception{
        String encode = bCryptPasswordEncoder.encode(memberDto.getMem_pwd());
        memberDto.setMem_pwd(encode);
        memberService.signin(memberDto);
        return memberDto;
    }

    //아이디체크
    @GetMapping("/checkId")
    @ResponseBody
    public int idCheck(String mem_id) throws Exception {
        if(mem_id == null || mem_id.isEmpty()){
            return -1;
        } else {
            return memberRepository.checkId(mem_id);}
    }
    //이메일 체크
    @GetMapping("/checkEmail")
    @ResponseBody
    public int emailCheck(String mem_email) throws Exception {
        if(mem_email == null || mem_email.isEmpty()){
            return -1;
        } else {
            return memberRepository.checkEmail(mem_email);
        }
    }
}

