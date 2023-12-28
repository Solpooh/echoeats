package com.pofol.main.orders.delivery.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import okhttp3.internal.framed.ErrorCode;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MismatchPackTypeException extends RuntimeException {
    ErrorCode errorCode;
}
