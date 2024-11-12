//package com.pofol.util;
//
//import javax.sql.DataSource;
//import org.junit.jupiter.api.Test;
//import org.junit.jupiter.api.extension.ExtendWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.context.ApplicationContext;
//import org.springframework.context.annotation.PropertySource;
//import org.springframework.test.context.ContextConfiguration;
//import org.springframework.test.context.junit.jupiter.SpringExtension;
//@ExtendWith(SpringExtension.class) // Junit5
//@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
//@PropertySource("classpath:application.properties")
//public class S3ConfigTest  {
//    @Autowired
//    DataSource ds;
//
//    @Autowired
//    ApplicationContext ac;
//
//    @Value("${cloud.aws.s3.bucketName}")
//    private String bucketName; //버킷 이름
//    @Test
//    public void init() {
//        String[] beanDefinitionNames = ac.getBeanDefinitionNames();
//        for (String beanDefinitionName : beanDefinitionNames) {
//            System.out.println("beanDefinitionName = " + beanDefinitionName);
//        }
//    }
//}
