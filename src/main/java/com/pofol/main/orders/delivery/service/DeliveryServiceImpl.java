package com.pofol.main.orders.delivery.service;

import com.pofol.main.orders.delivery.domain.DeliveryDto;
import com.pofol.main.orders.delivery.domain.MismatchPackTypeException;
import com.pofol.main.orders.delivery.domain.SearchDeliveryCondition;
import com.pofol.main.orders.delivery.repository.DeliveryRepository;
import com.pofol.main.orders.order.domain.OrderDetailDto;
import com.pofol.main.orders.order.repository.OrderDetailRepository;
import com.pofol.main.orders.order.service.OrderDetailService;
import com.pofol.main.orders.order.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static okhttp3.internal.framed.ErrorCode.INTERNAL_ERROR;

@Service
@RequiredArgsConstructor
public class DeliveryServiceImpl implements DeliveryService{

    private final DeliveryRepository deliveryRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final OrderDetailService orderDetailService;

    @Override
    @Transactional
    public void writeDelivery(List<DeliveryDto> deliveryList) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String mem_id = authentication.getName(); //회원id

//        if(authentication instanceof AnonymousAuthenticationToken){
//            //여기는 인증이 안되었을 때만 실행
//        }

        try {
            //운송장번호가 같으면 포장 타입이 같아야한다! 그걸 확인하는 것
            for (DeliveryDto delivery : deliveryList) {
                String packType = deliveryRepository.selectPackTypeByWaybillNum(delivery.getWaybill_num());
                if (packType != null) {
                    if (!delivery.getPack_type().equals(packType)) {
                        throw new MismatchPackTypeException(INTERNAL_ERROR);
                    }
                }
            }
            for (DeliveryDto delivery : deliveryList) {
                OrderDetailDto dto = new OrderDetailDto(delivery.getOrd_det_id(), "DELIVERING", mem_id);
                orderDetailService.update(dto); //주문 상세table을 기준으로 modify
                delivery.setMember(mem_id);
                delivery.setDlvy_sts("DELIVERING");
                Long ord_id = orderDetailRepository.select(delivery.getOrd_det_id()).getOrd_id();
                delivery.setOrd_id(ord_id);
                deliveryRepository.insert(delivery);
            }
        } catch (MismatchPackTypeException m) {
            throw new MismatchPackTypeException();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    @Override
    @Transactional
    public void selectListByWaybillNum(List<Long> waybillNumList) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String mem_id = authentication.getName(); //회원id
        System.out.println("mem_id: "+mem_id);


        try {
            for (Long waybillNum : waybillNumList) {
                List<DeliveryDto> deliveryList = deliveryRepository.selectListByWaybillNum(waybillNum);
                for (DeliveryDto delivery : deliveryList) {
                    OrderDetailDto dto = new OrderDetailDto(delivery.getOrd_det_id(), "DELIVERY_COMPLETE", mem_id);
                    orderDetailService.update(dto);
                    delivery.setMd_num(mem_id);
                    delivery.setDlvy_sts("DELIVERY_COMPLETE");
                    deliveryRepository.update(delivery);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * @return List<OrderDetailDto>
     * @feat : 관리자 배송 페이지에서 주문상세를 가져오는 메서드
     */
    @Override
    public List<OrderDetailDto> selectForDelivery() {
        try {
            return deliveryRepository.selectForDelivery();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public int searchResultCnt(SearchDeliveryCondition sc) {
        try {
            return deliveryRepository.searchResultCnt(sc);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<OrderDetailDto> searchSelectPage(SearchDeliveryCondition sc) {
        try {
            return deliveryRepository.searchSelectPage(sc);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
