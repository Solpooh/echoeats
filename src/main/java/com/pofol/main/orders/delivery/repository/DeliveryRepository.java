package com.pofol.main.orders.delivery.repository;

import com.pofol.main.orders.delivery.domain.DeliveryDto;
import com.pofol.main.orders.delivery.domain.SearchDeliveryCondition;
import com.pofol.main.orders.order.domain.OrderDetailDto;

import java.util.List;

public interface DeliveryRepository {

    int insert (DeliveryDto deliveryDto) throws Exception;
    DeliveryDto select(Long ord_det_id) throws Exception;
    int update(DeliveryDto deliveryDto) throws Exception;
    List<OrderDetailDto> selectForDelivery() throws Exception;
    List<DeliveryDto> selectListByWaybillNum(Long waybill_num) throws Exception;
    int searchResultCnt(SearchDeliveryCondition sc) throws Exception;
    List<OrderDetailDto> searchSelectPage(SearchDeliveryCondition sc) throws Exception;
    String selectPackTypeByWaybillNum(Long waybill_num) throws Exception;

}
