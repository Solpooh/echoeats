//package com.pofol.main.product.service;
//
//import com.pofol.main.product.domain.OptionProductDto;
//import com.pofol.main.product.domain.ProductDto;
//import com.pofol.main.product.domain.ProductImageDto;
//import com.pofol.main.product.repository.ProductRepository;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//import org.springframework.web.multipart.MultipartFile;
//
//import java.util.Objects;
//
//@Slf4j
//@RequiredArgsConstructor
//@Service
//public class ProductServiceImpl implements ProductService {
//
//    private final ProductRepository productRepository;
//
//    private final AwsS3ImgUploaderService awsS3ImgUploaderService;
//
//    @Transactional
//    @Override
//    public void productEnroll(ProductDto productDto) {
//        try {
//            log.info("-----------상품 이미지등록 시작-----------");
//            log.info("{}", productDto);
//            // productRepository.insert(productDto);
//            MultipartFile productImage = productDto.getProd_img();
//            String imgUrl = awsS3ImgUploaderService.uploadImageToS3(
//                    productDto.getProd_img(), "product");
//            productDto.setProd_img_id(imgUrl);
//            productRepository.insert(productDto);
//            productDto.setRg_num("ecoeats");
//            productDto.setMd_num("ecoeats");
//            ProductImageDto productImageDto = new ProductImageDto();
//            productImageDto.setMd_num(productDto.getMd_num());
//            productImageDto.setProd_img_id(imgUrl);
//            productImageDto.setProd_id(productDto.getProd_id());
//            productImageDto.setOri_file_name(productImage.getOriginalFilename());
//            productImageDto.setSer_file_name(AwsS3ImgUploaderService.generateFileName(Objects.requireNonNull(productImage.getOriginalFilename())));
//            productImageDto.setRg_num(productDto.getRg_num());
//            log.info("{}", productImageDto);
//            productImageEnroll(productImageDto);
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//
//        if (productDto.getOptionProductList() != null && !productDto.getOptionProductList().isEmpty()) {
//            log.info("-----------옵션 상품등록 시작-----------");
//            log.info("{}, {}", productDto.getProd_id(), productDto.getOptionProductList());
//            char optionName = 'A';
//            for (OptionProductDto option : productDto.getOptionProductList()) {
//                if(option.getOpt_prod_name() != null && !option.getOpt_prod_name().isEmpty()) {
//                    option.setOpt_prod_id(productDto.getProd_id() + String.valueOf(optionName++));
//                    log.info("productDto.getProd_id() : {}", productDto.getProd_id());
//                    log.info("opt_prod_id : {}", option.getOpt_prod_id());
//                    option.setProd_id(productDto.getProd_id());
//                    option.setOpt_prod_name(option.getOpt_prod_name());
//                    option.setOpt_price(option.getOpt_price());
//                    option.setOpt_prod_qty(option.getOpt_prod_qty());
//                    option.setOpt_prod_sts(option.getOpt_prod_sts());
//                    option.setRg_num(productDto.getRg_num());
//                    option.setMd_num(productDto.getMd_num());
//                    try {
//                        optionProductEnroll(option);
//                    } catch (Exception e) {
//                        throw new RuntimeException(e);
//                    }
//                }
//            }
//        }
////        else {
////            log.info("-----------옵션 상품등록 안했을 때 -----------");
////            OptionProductDto defaultOption = new OptionProductDto();
////            defaultOption.setOpt_prod_id(productDto.getProd_id() + "A");
////            defaultOption.setProd_id(productDto.getProd_id());
////            defaultOption.setOpt_prod_name(defaultOption.getOpt_prod_name());
////            defaultOption.setOpt_price(defaultOption.getOpt_price());
////            defaultOption.setOpt_prod_qty(defaultOption.getOpt_prod_qty());
////            defaultOption.setOpt_prod_sts(defaultOption.getOpt_prod_sts());
////            defaultOption.setRg_num(productDto.getRg_num());
////            defaultOption.setMd_num(productDto.getMd_num());
////            try {
////                optionProductEnroll(defaultOption);
////            } catch (Exception e) {
////                throw new RuntimeException(e);
////            }
////        }
//    }
//
//    @Override
//    public int productCount() {
//        try {
//            return productRepository.count();
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//    }
//
//    @Override
//    public void productImageEnroll(ProductImageDto productImageDto) throws Exception {
//        productRepository.insertImage(productImageDto);
//    }
//
//    @Override
//    public void optionProductEnroll(OptionProductDto optionProductDto) throws Exception {
//        productRepository.insertOption(optionProductDto);
//    }
//
//    @Override
//    public void productInfoEnroll(ProductDto productDto) throws Exception {
//        productRepository.insertInfo(productDto);
//    }
//}
