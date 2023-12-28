package com.pofol.main.orders.order.service;

import com.pofol.main.member.dto.*;
import com.pofol.main.member.repository.*;
import com.pofol.main.member.service.PointService;
import com.pofol.main.orders.order.domain.*;
import com.pofol.main.orders.order.repository.OrderDetailRepository;
import com.pofol.main.orders.order.repository.OrderHistoryRepository;
import com.pofol.main.orders.order.repository.OrderRepository;
import com.pofol.main.orders.payment.domain.PaymentDiscountDto;
import com.pofol.main.orders.payment.repository.PaymentDiscountRepository;
import com.pofol.main.product.cart.SelectedItemsDto;
import com.pofol.main.product.cart.CartRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService{

    private final MemberRepository memRepo;
    private final AddressRepository addressRepository;
    private final DelNotesRepository delNotesRepository;
    private final CouponRepository couponRepository;
    private final PointService pointService;
    private final CartRepository cartRepo;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final OrderHistoryRepository orderHistoryRepository;
    private final PaymentDiscountRepository paymentDiscountRepository;

    @Override
    @Transactional
    public OrderCheckout writeCheckout(List<SelectedItemsDto> items) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String mem_id = authentication.getName(); //회원id

        int tot_prod_price = 0; //총 주문 금액;
        int origin_prod_price = 0; //총 원래 상품 금액;
        int dlvy_fee = 0;
        String tot_prod_name; //총 상품명

        OrderCheckout oc = new OrderCheckout(items);

        try{
            for (SelectedItemsDto item : items) {
                ProductOrderCheckout prod = cartRepo.selectProductOrderCheckout(item);
                item.setProductOrderCheckout(prod);

                if(item.getOpt_prod_id() == null){ //일반 상품일 때
                    tot_prod_price += prod.getDisc_price() * item.getQty(); //총 주문금액 계산
                    origin_prod_price += prod.getProd_price() * item.getQty(); //총 원래 상품 금액
                }else{ //option상품일 때
                    tot_prod_price += prod.getOpt_disc_price() * item.getQty();
                    origin_prod_price += prod.getOpt_price() * item.getQty();
                }
                item.calculateProductTotal(); //각 상품별 총 주문금액과 원래 금액 계산
            }

            oc.setTot_prod_price(tot_prod_price);
            oc.setOrigin_prod_price(origin_prod_price);

            //배송비 구하기
            if(tot_prod_price < 40000){
                dlvy_fee = 3000;
            }
            oc.setDlvy_fee(dlvy_fee);

            //총 상품명 구하기
            SelectedItemsDto firstItem = items.get(0);
            ProductOrderCheckout firstProd = firstItem.getProductOrderCheckout();
            int tot_ord_qty = items.size(); //총 상품 수량

            if(firstItem.getOpt_prod_id() == null){ //일반 상품일 때
                tot_prod_name = firstProd.getProd_name();
            } else { //option 상품일 때
                tot_prod_name = firstProd.getOpt_prod_name();
            }

            if(tot_ord_qty > 1){ //상품수량이 1개일 때
                tot_prod_name += " 외 " + (tot_ord_qty-1) +"개";
            }

            oc.setTot_prod_name(tot_prod_name);


            //회원정보 가져오기
            oc.setMemberDto(memRepo.selectMember(mem_id));

            //배송지
            oc.setAddressDto(addressRepository.selectDefaultAddress(mem_id));

            //배송요청사항 가져오기
            oc.setDelNotesDto(delNotesRepository.select_delNotes(mem_id));

            //쿠폰 정보 가져오기. (단, 총 주문 금액이 쿠폰 사용 가능한 최소 금액보다 클 경우에만 사용 가능)
            List<CouponJoinDto> couponJoinDtos =  Collections.synchronizedList(couponRepository.selectMembersWithCoupons(mem_id));
            Iterator<CouponJoinDto> it = couponJoinDtos.iterator();
            while (it.hasNext()){
                if(tot_prod_price < it.next().getMin_amt()){
                    it.remove();
                }
            }
            oc.setCouponList(couponJoinDtos);

            //적립금 정보 가져오기
            oc.setAvailablePoint(pointService.getAvailablePoint(mem_id));

            return oc;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    @Override
    @Transactional
    public PaymentDiscountDto calculatePayment(PaymentDiscountDto pdd) {
        Long coupon_id = pdd.getCoupon_id();// 쿠폰 id
        int coupon_disc = 0; //쿠폰 사용 금액
        Integer reserves_used = pdd.getPoint_used(); // 적립금 사용 금액
        int discountPrice = 0; //할인 총 금액

        try{
            if(coupon_id != null){ //쿠폰 사용 시
                CouponDto coupon = couponRepository.select_coupon(coupon_id);
                if(coupon.getType().equals("cash")){ //쿠폰이 할인 금액일 때
                    coupon_disc = coupon.getCash_rate();
                }else { //쿠폰이 할인율일 때(최대 사용 금액이 존재)
                    coupon_disc = pdd.getTot_prod_price() * coupon.getCash_rate() / 100;
                    if(coupon_disc > coupon.getMax_disc_amt()){ //최대 사용 금액보다 쿠폰할인 금액이 클 경우
                        coupon_disc = coupon.getMax_disc_amt();
                    }
                }
                pdd.setCoupon_disc(coupon_disc);
                discountPrice += coupon_disc;
            }
            if(reserves_used != null){ //적립금 할인 금액이 입력시
                discountPrice += reserves_used;
            }
            pdd.setTot_pay_price(pdd.getTot_prod_price() - discountPrice + pdd.getDlvy_fee());

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return pdd;
    }


    @Override
    @Transactional
    public Long writeOrder(OrderCheckout oc) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String mem_id = authentication.getName(); //회원id

        System.out.println("writeOrder 주문서 = " + oc);
        List<SelectedItemsDto> items = oc.getSelectedItems();

        //주문 table 작성
        OrderDto orderDto = new OrderDto(mem_id, oc.getTot_prod_name(), oc.getTot_prod_price(), oc.getTot_pay_price(), oc.getOrigin_prod_price() - oc.getTot_prod_price(), items.size(), oc.getDlvy_fee(), oc.getPay_way(), items.size(), mem_id, mem_id);
        try {
            orderRepository.insert(orderDto);
            Long ord_id = orderDto.getOrd_id();

            //주문 상세 table 작성
            for (SelectedItemsDto item : items) {
                ProductOrderCheckout prod = cartRepo.selectProductOrderCheckout(item);
                item.setProductOrderCheckout(prod);
                item.calculateProductTotal();

                OrderDetailDto orderDetailDto;
                if(item.getOpt_prod_id() == null || item.getOpt_prod_id().isEmpty() ){ //일반 상품일 때
                    orderDetailDto = new OrderDetailDto(ord_id, mem_id, item.getProd_id(), "ORDERING", prod.getProd_name(), item.getQty(), prod.getDisc_price() * item.getQty(), prod.getPack_type(), mem_id, mem_id);
                }else { //option 상품일 때
                    orderDetailDto = new OrderDetailDto(ord_id, mem_id, item.getProd_id(), item.getOpt_prod_id(), "ORDERING", prod.getOpt_prod_name(), item.getQty(), prod.getOpt_disc_price() * item.getQty(), prod.getPack_type(), mem_id, mem_id);
                }
                orderDetailRepository.insert(orderDetailDto);
            }

            //주문 이력 table 작성
            OrderHistoryDto orderHistoryDto = new OrderHistoryDto(ord_id, mem_id, "ORDERING", oc.getTot_prod_name(), oc.getTot_prod_price(), oc.getTot_pay_price(), items.size(), oc.getPay_way(), mem_id, mem_id);
            orderHistoryRepository.insert(orderHistoryDto);

            //할인 금액 정보 table 작성
            PaymentDiscountDto paymentDiscountDto = new PaymentDiscountDto(ord_id, oc.getProd_disc(), oc.getCoupon_disc(), oc.getCoupon_id(), oc.getPoint_used());
            paymentDiscountRepository.insert(paymentDiscountDto);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        return orderDto.getOrd_id();
    }


    @Override
    @Transactional
    public void modifyOrder(Long ord_id, String code_name) {
        System.out.println("modifyOrder");
        try {
            //주문 상세 table
            List<OrderDetailDto> items = orderDetailRepository.selectList(ord_id);
            for (OrderDetailDto item : items) {
                item.setCode_name(code_name);
                orderDetailRepository.updateStatus(item);
                System.out.println("item: "+item);
            }

            //주문 table
            OrderDto orderDto = orderRepository.select(ord_id);
            orderDto.setStatus(items);
            orderRepository.updateStatus(orderDto);
            System.out.println("orderDto: "+orderDto);

            //주문 이력 table
            OrderHistoryDto orderHistoryDto = orderHistoryRepository.selectMaxByOrdId(ord_id); //sql 한번 더 확인
            orderHistoryDto.setStatus(orderDto);
            orderHistoryRepository.insert(orderHistoryDto);
            System.out.println("orderHist: "+orderHistoryDto);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * @param mem_id(유저ID)
     * @param period(검색범위:현재기준-day)
     * @return List<OrderDto>
     * @feat : mypage에 주문리스트를 가져오는 메서드
     **/ 
	@Override
	public List<OrderDto> selectAllByUserIdAndPeriod(Map map) throws Exception {
		return orderRepository.selectAllByUserIdAndPeriod(map);
	}
	/**
     * @param ord_id(주문ID)
     * @return String
     * @feat : mypage에 주문리스트 메인 이미지를 가져오는 메서드
     **/ 
	@Override
	public String selectByOrderMainImg(Long ord_id) {
		return orderRepository.selectByOrderMainImg(ord_id);
	}
	/**
     * @param ord_id(주문ID)
     * @return OrderDto
     * @feat : mypage에 주문상세의 결제정보를 가져오는 메서드
     **/ 
	@Override
	public OrderDto selectByOrderId(Long ord_id) {
		// TODO Auto-generated method stub
		return orderRepository.selectByOrderId(ord_id);
	}
}
