package com.pofol.main.orders.order.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pofol.main.orders.order.domain.OrderDetailDto;
import com.pofol.main.orders.order.domain.OrderDto;
import com.pofol.main.orders.order.domain.OrderHistoryDto;
import com.pofol.main.orders.order.domain.SearchOrderCondition;
import com.pofol.main.orders.order.repository.OrderDetailRepository;
import com.pofol.main.orders.order.repository.OrderHistoryRepository;
import com.pofol.main.orders.order.repository.OrderRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderDetailServiceImpl implements OrderDetailService {
	
	private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final OrderHistoryRepository orderHistoryRepository;
	
	@Override
	public OrderDetailDto selectByOrderDetId(Long ord_det_id) throws Exception{
		return orderDetailRepository.selectByOrderDetId(ord_det_id);
	}
	@Override
	public int insert(OrderDetailDto orderDetailDto) throws Exception {
		return orderDetailRepository.insert(orderDetailDto);
	}
	@Override
	public OrderDetailDto select(Long ord_det_id) throws Exception {
		return orderDetailRepository.select(ord_det_id);
	}
	@Override
	public List<OrderDetailDto> selectList(Long ord_id) throws Exception {
		return orderDetailRepository.selectList(ord_id);
	}
	@Override
	public int updateStatus(OrderDetailDto orderDetailDto) throws Exception {
		return orderDetailRepository.updateStatus(orderDetailDto);
	}
	@Override
	public int delete(Long ord_det_id) throws Exception {
		return orderDetailRepository.delete(ord_det_id);
	}
	@Override
	public List<OrderDetailDto> selectAll() throws Exception {
		return orderDetailRepository.selectAll();
	}
	@Override
	public int deleteAll() throws Exception {
		return orderDetailRepository.deleteAll();
	}
	@Override
	public int count() throws Exception {
		return orderDetailRepository.count();
	}
	@Override
	public int update(OrderDetailDto orderDetailDto) throws Exception {
        System.out.println("OrderDetailServiceImpl.update");
        try {
            //주문 상세 table
        	orderDetailRepository.update(orderDetailDto);
        	orderDetailDto = orderDetailRepository.select(orderDetailDto.getOrd_det_id());
        	Long ord_id = orderDetailDto.getOrd_id();
            List<OrderDetailDto> items = orderDetailRepository.selectList(ord_id);
            //주문 table
            OrderDto orderDto = orderRepository.select(ord_id);
            orderDto.setStatus(items);
            orderRepository.updateStatus(orderDto);
            //주문 이력 table
            OrderHistoryDto orderHistoryDto = orderHistoryRepository.selectMaxByOrdId(ord_id);
            orderHistoryDto.setStatus(orderDto);
            orderHistoryRepository.insert(orderHistoryDto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
		return 1;
	}
	/**
	 * @param ord_id(주문ID)
	 * @return List<OrderDetailDto>
	 * @feat : mypage에 주문상세리스트를 가져오는 메서드
	 **/ 
	@Override
	public List<OrderDetailDto> selectAllByOrdId(Long ord_id) throws Exception {
		return orderDetailRepository.selectAllByOrdId(ord_id);
	}
	/**
	 * @param ord_det_id(주문상세ID)
	 * @return String
	 * @feat : mypage에 주문상세리스트의 이미지의 url을 가져오는 메서드
	 **/ 
	@Override
	public String selectByOrderDetImg(Long ord_det_id) throws Exception{
		return orderDetailRepository.selectByOrderDetImg(ord_det_id);
	}
	/**
	 * @param code_name
	 * @return String
	 * @feat : mypage에서 주문상세의 배송상태를 code테이블에서 가져오는 메서드
	 **/
	@Override
	public String selectByCodeName(String code_name) throws Exception{
		return orderDetailRepository.selectByCodeName(code_name);
	}
	/**
	 * @param ord_det_id
	 * @return OrderDetailDto
	 * @feat : inquiry에서 주문상세를 가져오는 메서드
	 **/
	@Override
	public List searchSelectPage(SearchOrderCondition sc) throws Exception {
		List<OrderDetailDto> list = orderDetailRepository.searchSelectPage(sc);
		for(OrderDetailDto dto: list) {
			dto.setColumn_sts(orderDetailRepository.selectByCodeName(dto.getCode_name()));
			dto.setProd_img_id(orderDetailRepository.selectByOrderDetImg(dto.getOrd_det_id()));
		}
		return list;
	}
	@Override
	public int searchResultCnt(SearchOrderCondition sc) throws Exception {
		return orderDetailRepository.searchResultCnt(sc);
	}
}
