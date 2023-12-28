package com.pofol.main.orders.inquiry.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pofol.main.orders.inquiry.domain.InquiryDto;
import com.pofol.main.orders.inquiry.service.InquiryImgService;
import com.pofol.main.orders.inquiry.service.InquiryPrdService;
import com.pofol.main.orders.inquiry.service.InquiryService;
import com.pofol.main.orders.order.domain.CodeTableDto;
import com.pofol.main.orders.order.domain.OrderDetailDto;
import com.pofol.main.orders.order.service.OrderDetailService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
public class InquiryController {
	
	private final InquiryService inqServ;
	private final InquiryImgService inqImgServ;
	private final InquiryPrdService inqPrdServ;
	
	private final OrderDetailService ordDetServ;
	
	@GetMapping("/inquiry/form")
    public String inquiryForm(Long ord_det_id ,Model m, HttpServletRequest request){
		System.out.println("inquiryForm");
		try {
			if(ord_det_id != null) {
				OrderDetailDto dto = ordDetServ.selectByOrderDetId(ord_det_id);
				dto.setProd_img_id(ordDetServ.selectByOrderDetImg(ord_det_id));
				m.addAttribute("ordDetDto", dto);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
    	return "/order/mypageInquiry";
    }
	
	@PostMapping("/inquiry/form/submit")
    public ResponseEntity<String> inquiryFormSubmit(InquiryDto inqDto, HttpSession session){
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		String id = authentication.getName();
		// 회원id 정보 session or security
		if (session.getAttribute("id") == null) {
		    session.setAttribute("id", "you11");
		}
		String id = (String) session.getAttribute("id");
        try{
        	inqDto.setMem_id(id).setRg_num(id).setMd_num(id);
        	inqServ.insert(inqDto);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("INQ_SUBMIT_ERR", HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<String>("INQ_SUBMIT_OK", HttpStatus.OK);
    }
	
	@GetMapping("/inquiry/list")
    public String inquiryList(Model m, HttpSession session){
		System.out.println("inquiryForm");
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		String id = authentication.getName();
		// 회원id 정보 session or security
		if (session.getAttribute("id") == null) {
		    session.setAttribute("id", "you11");
		}
		String id = (String) session.getAttribute("id");
		try {
			List<InquiryDto> inqList = inqServ.selectAllByUserId(id);
			for(InquiryDto dto : inqList) {
				dto.setImgList(inqImgServ.selectAllByInqId(dto.getInquiry_id()));
			}
			m.addAttribute("inqList",inqList);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return "/order/mypageInquiryList";
    }
	
	@ResponseBody
	@PostMapping("/inquiry/listView")
    public ResponseEntity inquiryView(@RequestBody Map<String, Long> data, HttpSession session) {
		try {
			InquiryDto dto = inqServ.selectByinqId(data.get("inquiry_id"));
			dto.setImgList(inqImgServ.selectAllByInqId(dto.getInquiry_id()));
			dto.setType(inqServ.selectNametoSts(dto.getType()));
			dto.setDet_type(inqServ.selectNametoSts(dto.getDet_type()));
			return new ResponseEntity(dto, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity(HttpStatus.BAD_REQUEST);
		}
	}
	
	@ResponseBody
	@PostMapping("/inquiry/getDetType")
	public ResponseEntity inquiryGetDetType(@RequestBody Map<String, String> data){
		try {
    		List<CodeTableDto> typeList = inqServ.selectCodeTypeByCodeName(data.get("inquiryType"));
    		if (typeList == null) // dt = dateType
				throw new Exception("inquiryGetDetType");
    		return new ResponseEntity(typeList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity(HttpStatus.BAD_REQUEST);
		}
    }

	@ModelAttribute
    public void inquiryGetPageData(Model m){
    	try {
    		List<CodeTableDto> typeList = inqServ.selectCodeType(111);
    		if (typeList == null) // dt = dateType
				throw new Exception("selectCodeType(111) failed");

    		m.addAttribute("typeList",typeList);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}
