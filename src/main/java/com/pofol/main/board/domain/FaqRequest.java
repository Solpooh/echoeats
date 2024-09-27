package com.pofol.main.board.domain;

import lombok.Data;

@Data
public class FaqRequest {
    private FaqDto faqDto;
    private SearchBoardCondition searchBoardCondition;
}
