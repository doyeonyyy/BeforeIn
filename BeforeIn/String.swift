//
//  String.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/19.
//

import Foundation

extension String {
    
    // 아이디 정규 표현식
    // @와2글자 이상 확인 1@naver.com
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: self)
    }
    
    // 비밀번호 정규 표현식
    // 대소문자, 특수문자, 숫자 8자 이상
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }

}
