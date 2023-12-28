package com.pofol.main.orders.delivery.controller;

import com.pofol.admin.order.Repository.AdminOrderDetailRepository;
import com.pofol.main.orders.delivery.domain.DeliveryDto;
import com.pofol.main.orders.delivery.domain.MismatchPackTypeException;
import com.pofol.main.orders.delivery.domain.PageHandler;
import com.pofol.main.orders.delivery.domain.SearchDeliveryCondition;
import com.pofol.main.orders.delivery.repository.DeliveryRepository;
import com.pofol.main.orders.delivery.service.DeliveryService;
import com.pofol.main.orders.order.domain.CodeTableDto;
import com.pofol.main.orders.order.domain.OrderDetailDto;
import com.pofol.main.orders.order.repository.OrderDetailRepository;
import com.pofol.main.orders.order.service.OrderDetailService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.Set;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/delivery")
public class DeliveryController {

    private final DeliveryService deliveryService;

    @GetMapping
    public String getDeliveryList(SearchDeliveryCondition sc, Model m){
        System.out.println("delivery");
        try{
//            List<OrderDetailDto> orderDetailDtos = deliveryService.selectForDelivery();
//            m.addAttribute("list", orderDetailDtos);

            //페이징
            int totalCnt = deliveryService.searchResultCnt(sc);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);
            m.addAttribute("ph", pageHandler);
            if(totalCnt == 0) {
                return "/admin/order/delivery";
            }

            //검색 결과에 따른 조회
            List<OrderDetailDto> list = deliveryService.searchSelectPage(sc);
            m.addAttribute("list", list);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "/admin/order/delivery";
    }

    @ResponseBody
    @PostMapping("/registerWaybillNum")
    public ResponseEntity<String> setDelivering(@RequestBody List<DeliveryDto> deliveryList){
        try{
            deliveryService.writeDelivery(deliveryList);
        }catch (MismatchPackTypeException m){
//            m.printStackTrace();
            System.out.println("Mismatch packType 발생");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Mismatch PackType");
        }catch (Exception e){
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("DELIVERING fail");
        }
        return ResponseEntity.ok("DELIVERING");
    }

    @ResponseBody
    @PostMapping("/DeliveryComplete")
    public ResponseEntity<String> setDeliveryComplete(@RequestBody List<Long> waybillNumList){
        try{
            deliveryService.selectListByWaybillNum(waybillNumList);
            return ResponseEntity.ok("DELIVERY_COMPLETE");
        }catch (Exception e){
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("DELIVERY_COMPLETE fail");
        }
    }
}
