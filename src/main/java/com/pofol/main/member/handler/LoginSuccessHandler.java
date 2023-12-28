package com.pofol.main.member.handler;

import com.pofol.main.member.dto.GradeDto;
import com.pofol.main.member.repository.CouponRepository;
import com.pofol.main.member.service.CouponService;
import com.pofol.main.member.service.GradeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    CouponService couponService;

    @Autowired
    GradeService gradeService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        System.out.println("---------------LoginSuccessHandler---------------");

        String fullURL = request.getRequestURL().toString();
        String baseURL = fullURL.substring(0, fullURL.indexOf(request.getRequestURI()));

        //String username = request.getParameter("mem_id");
        String username = authentication.getName();
        if(username != null){
            System.out.println("username : "+username);
            //nullpointer 에러 발생
            //회원가입 후 로그인 할 때
            int cp_qty = couponService.member_cp_qty_count(username);
            System.out.println(cp_qty);
            request.getSession().setAttribute("mem_have_cp_qty", cp_qty);

        }

        //마이페이지 상단 등급 표시
        GradeDto gradeDto = gradeService.show_grade(authentication.getName());

        request.getSession().setAttribute("mem_grade", gradeDto);




        //가로챈 주소를 보유
        //사용자가 직접url로 /member/admin을 입력했을 때 필요
        RequestCache requestCache = new HttpSessionRequestCache();
        SavedRequest savedRequest = requestCache.getRequest(request, response);
        System.out.println(savedRequest);


        //현재 세션값 확인
        Enumeration<String> list = request.getSession().getAttributeNames();
        while(list.hasMoreElements()){
            String a= list.nextElement();
            System.out.println("세션 Attribute 확인 : "+a+" : "+ request.getSession().getAttribute(a));

        }

        HttpSession session = request.getSession();
        String referer = (String) session.getAttribute("referer");
        session.removeAttribute("referer");
        System.out.println("referer : "+ referer);

        //refer이 있다 = 정상적인(버튼을 클릭해서) 루트로 왔다
        //refer이 없다 = url로 진입
        //savedRequest는 가로챘을 때만 가지고 있다
        if(referer != null){
            System.out.println("referer != null");
            //로그인버튼 2번 누르고 카카오 로그인
            if (referer.contains("/member/login_form")){
//                referer = baseURL+"/main"; // 그냥/main으로 하면 가끔씩 에러가 난다
                referer = "/main";
            }
            response.sendRedirect(referer);
        }else{
            // 그럼 둘 다 null 일 때는 어떻게 하냐?
            if (savedRequest == null){
                referer =baseURL+"/main";
                response.sendRedirect(referer);
            }else {
                System.out.println("referer는 null  savedRequest는 null이 아님");

            //얘는 사용자가 직접 /member/admin을 입력했을 때 필요
            //이 때는 referer가 null이고, savedRequest가 가로챈 주소를 가지고 있다
            response.sendRedirect(savedRequest.getRedirectUrl());

        }


        }
    }


}



//    // IP, 세션 ID
//    WebAuthenticationDetails web = (WebAuthenticationDetails) authentication.getDetails();
//        System.out.println("IP : " + web.getRemoteAddress());
//                System.out.println("Session ID : " + web.getSessionId());
//
//                // 인증 ID
//                System.out.println("name : " + authentication.getName());
//
//                // 권한 리스트
//                List<GrantedAuthority> authList = (List<GrantedAuthority>) authentication.getAuthorities();
//        System.out.print("권한 : ");
//        for (int i = 0; i < authList.size(); i++) {
//        System.out.print(authList.get(i).getAuthority() + " ");
//        }
//        System.out.println();