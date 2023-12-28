package com.pofol.main.orders.delivery.repository;

import com.pofol.main.orders.delivery.domain.DeliveryDto;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import static org.assertj.core.api.Assertions.*;

@ExtendWith(SpringExtension.class) // Junit5
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
class DeliveryRepositoryImplTest {

    @Autowired
    DeliveryRepository deliveryRepository;

    @Test
    void insert() throws Exception{
        DeliveryDto deliveryDto = new DeliveryDto(2000000051L, 10000000746L, 11111L, "you11", "DELIVERING", "냉장");
        deliveryRepository.insert(deliveryDto);
    }

    @Test
    void select() throws Exception{
        DeliveryDto select = deliveryRepository.select(2000000051L);
        System.out.println(select);
    }

    @Test
    void update() {
//        int update = deliveryRepository.update(2000000051L, "you11", "DELIVERY_COMPLETE");
//        assertThat(update).isEqualTo(1);
    }

    @Test
    void selectPackTypeByWaybillNum() throws Exception{
        String s = deliveryRepository.selectPackTypeByWaybillNum(111L);
        assertThat(s).isEqualTo(null);
    }
}