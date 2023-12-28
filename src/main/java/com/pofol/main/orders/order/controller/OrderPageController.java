package com.pofol.main.orders.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.pofol.main.orders.order.domain.OrderHistoryDto;
import com.pofol.main.orders.order.service.OrderHistoryService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pofol.main.member.dto.AddressDto;
import com.pofol.main.member.dto.DelNotesDto;
import com.pofol.main.member.dto.MemberDto;
import com.pofol.main.member.service.AddressService;
import com.pofol.main.member.service.DelNotesService;
import com.pofol.main.member.service.MemberService;
import com.pofol.main.orders.order.domain.OrderDetailDto;
import com.pofol.main.orders.order.domain.OrderDto;
import com.pofol.main.orders.order.service.OrderDetailService;
import com.pofol.main.orders.order.service.OrderService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class OrderPageController {

    private final OrderService orderService;
    private final OrderDetailService ordDetService;
	private final OrderHistoryService orderHistoryService;
    private final MemberService memService;
    private final AddressService addrService;
    private final DelNotesService delNotesService;

    @GetMapping("/order")
    public String order(Integer period, Model m){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String mem_id = authentication.getName();

		// period
		if(period == null)
			period = 90;
		try {
			Map map = new HashMap();
	        map.put("mem_id", mem_id);
	        map.put("period", period);
	        // 주문 정보 가져오기 <- 주문 이력에서 가져오기
			List<OrderHistoryDto> list = orderHistoryService.selectFinalOrderHistory(map);

			for(OrderHistoryDto dto : list) {
				dto.setProd_img_id(orderService.selectByOrderMainImg(dto.getOrd_id()));
			}
			m.addAttribute("ordList",list);
			m.addAttribute("mypage", "order");
		} catch (Exception e) {

			e.printStackTrace();
		}
    	return "/member/mypage";
    }

	@GetMapping("/order/{ord_id}")
    public String orderDet(@PathVariable Long ord_id, Model m, HttpServletRequest request){
		System.out.println("OrderController.order()");
		System.out.println("OrderController.order().ord_id = "+ ord_id);
		try {
			// 주문번호에 대한 주문 상세들 List<ordDetDto>
			List<OrderDetailDto> ordDetList = ordDetService.selectAllByOrdId(ord_id);
			for(OrderDetailDto ordDetDto : ordDetList) {
				ordDetDto.setProd_img_id(ordDetService.selectByOrderDetImg(ordDetDto.getOrd_det_id()));
				ordDetDto.setColumn_sts(ordDetService.selectByCodeName(ordDetDto.getCode_name()));
			}
			m.addAttribute("ordDetList", ordDetList);
			// 배송조회 ( 어디서갖고와야되나?? -> 배송테이블에서 갖고옴 )
			// 결제정보
			OrderDto ordDto = orderService.selectByOrderId(ord_id);
			m.addAttribute("ordDto", ordDto);
			// 주문정보 ( 주문번호, 회원이름, 결제일시=주문일시 )
			MemberDto memDto = memService.select(ordDto.getMem_id());
			m.addAttribute("mem_id", memDto.getMem_id());
			// 배송정보 ( 배송지 배송요청사항 )
			AddressDto addrDto = addrService.getDefaultAddress(memDto.getMem_id());
			DelNotesDto dnDto = delNotesService.getDelNotes(); // mem_id에 대한 배송요청
			System.out.println("addrDto = "+addrDto);
			System.out.println("dnDto = "+dnDto);
			// 추가정보 ( 어디서갖고옴?? )

		} catch (Exception e) {
			e.printStackTrace();
		}
    	return "/order/mypageOrderDet";
    }
}
