package com.pofol.main.orders.delivery.repository;

import com.pofol.main.orders.delivery.domain.DeliveryDto;
import com.pofol.main.orders.delivery.domain.SearchDeliveryCondition;
import com.pofol.main.orders.order.domain.OrderDetailDto;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class DeliveryRepositoryImpl implements DeliveryRepository {

    private final SqlSession session;
    private String namespace = "delivery.repository.deliveryMapper.";

    @Override
    public int insert(DeliveryDto deliveryDto) throws Exception {
        return session.insert(namespace+"insert", deliveryDto);
    }

    @Override
    public DeliveryDto select(Long ord_det_id) throws Exception {
        return session.selectOne(namespace+"select", ord_det_id);
    }

    @Override
    public int update(DeliveryDto deliveryDto) throws Exception{
        return session.update(namespace+"updateStatus",deliveryDto);
    }

    @Override
    public List<OrderDetailDto> selectForDelivery() throws Exception {
        return session.selectList(namespace+"selectForDelivery");
    }

    @Override
    public List<DeliveryDto> selectListByWaybillNum(Long waybill_num) throws Exception {
        return session.selectList(namespace+"selectListByWaybillNum",waybill_num);
    }

    @Override
    public int searchResultCnt(SearchDeliveryCondition sc) throws Exception {
        return session.selectOne(namespace + "searchResultCnt", sc);
    }

    @Override
    public List<OrderDetailDto> searchSelectPage(SearchDeliveryCondition sc) throws Exception {
        return session.selectList(namespace + "searchSelectPage", sc);
    }

    @Override
    public String selectPackTypeByWaybillNum(Long waybill_num) throws Exception {
        return session.selectOne(namespace + "selectPackTypeByWaybillNum", waybill_num);
    }
}
