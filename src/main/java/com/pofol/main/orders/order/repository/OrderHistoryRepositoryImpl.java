package com.pofol.main.orders.order.repository;

import com.pofol.main.orders.order.domain.OrderDetailDto;
import com.pofol.main.orders.order.domain.OrderHistoryDto;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class OrderHistoryRepositoryImpl implements OrderHistoryRepository{

    private final SqlSession session;

    private String namespace = "order.repository.orderHistoryMapper.";


    @Override
    public int insert(OrderHistoryDto orderHistoryDto) throws Exception {
        if(orderHistoryDto.getOrd_date() == null) {
            orderHistoryDto.setOrd_date(new Date());
        }
        return session.insert(namespace+"insert",orderHistoryDto);
    }

    @Override
    public OrderHistoryDto select(Long ord_hist_id) throws Exception {
        return session.selectOne(namespace+"select",ord_hist_id);
    }

    @Override
    public List<OrderHistoryDto> selectList(Long ord_id) throws Exception {
        return session.selectList(namespace+"selectList",ord_id);
    }

    @Override
    public OrderHistoryDto selectOne(Long ord_id) throws Exception {
        return session.selectOne(namespace+"selectOne",ord_id);
    }
    @Override
	public OrderHistoryDto selectMaxByOrdId(Long ord_id) throws Exception {
		return session.selectOne(namespace+"selectMaxByOrdId",ord_id);
	}

    @Override
    public List<OrderHistoryDto> selectFinalOrderHistory(Map map) throws Exception {
        return session.selectList(namespace + "selectFinalOrderHistory", map);
    }

    @Override
    public int delete(Long ord_hist_id) throws Exception {
        return session.delete(namespace+"delete",ord_hist_id);
    }

    @Override
    public int deleteList(Long ord_id) throws Exception {
        return session.delete(namespace+"deleteList",ord_id);
    }

    @Override
    public List<OrderHistoryDto> selectAll() throws Exception {
        return session.selectList(namespace+"selectAll");
    }

    @Override
    public int deleteAll() throws Exception {
        return session.delete(namespace+"deleteAll");
    }

    @Override
    public int count() throws Exception {
        return session.selectOne(namespace+"count");
    }
}
