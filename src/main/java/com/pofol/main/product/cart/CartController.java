package com.pofol.main.product.cart;

import com.pofol.main.member.dto.GradeDto;
import com.pofol.main.member.service.GradeService;
import com.pofol.main.product.category.CategoryDto;
import com.pofol.main.product.category.CategoryList;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartRepository cartRepository;
    private final GradeService gradeService;
    private final CartService cartService;
    private final CategoryList categoryList;

    // 상품 수량에 따라 상품 가격 계산
    @ResponseBody
    @PostMapping("/ProductCalculation")
    public List<CartDto> productCalculation(@RequestBody List<CartDto> cartDtoList) {

        for (CartDto cartDto : cartDtoList) {
            if (cartDtoList.size() == 1) {
                cartDto.setTotal_price(cartDto.getDisc_price() * cartDto.getQty());
            } else {
                cartDto.setTotal_price(cartDto.getOpt_disc_price() * cartDto.getQty());
            }
        }

        return cartDtoList;
    }

    // 장바구니 페이지로 가기
    @GetMapping
    public String goCartPage(Model model) {

        // 회원 아이디 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String memberID = authentication.getName();

        try {
            // 대 카테고리 리스트 정렬 (header의 카테고리 정렬)
            List<CategoryDto> bigCategoryProductList = categoryList.bigCateList();
            model.addAttribute("categoryList", bigCategoryProductList);

            // 장바구니 리스트 정렬
            List<CartDto> cartProductList = cartService.getCartProductList(memberID);
            model.addAttribute("cartProductList", cartProductList);

            // 회원 등급 가져오기
            if (!memberID.equals("anonymousUser")) {
                GradeDto memberGrade = gradeService.show_grade(memberID);
                model.addAttribute("memberGrade", memberGrade);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/product/cart";
    }

    // 장바구니에 상품 저장
    @ResponseBody
    @PostMapping("/saveProduct")
    public ResponseEntity<String> saveProductCart(@RequestBody List<CartDto> cartDtoList) {

        System.out.println("save/Product 실행됨");
        
        for (CartDto cartDto : cartDtoList) {
            if (cartDto.getQty() != 0) {
                try {
                    cartService.saveCartProduct(cartDto);
                } catch (Exception e) {
                    e.printStackTrace();
                    return ResponseEntity.badRequest().body("장바구니 담기 실패");
                }
            }

        }
        System.out.println("last 실행");
        return ResponseEntity.ok("장바구니 담기 성공");
    }
}
