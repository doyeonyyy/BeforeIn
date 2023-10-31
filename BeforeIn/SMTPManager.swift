//
//  SMTPManager.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/30.
//

import Foundation
import SwiftSMTP

class SMTPManager {
    private let hostSMTP = SMTP(hostname: "smtp.naver.com", email: Secret.email, password: Secret.password)
  func sendAuth(userEmail: String, completion: @escaping (Int, Bool) -> Void) {
    let code = Int.random(in: 10000...99999)
    let fromUser = Mail.User(email: Secret.email)
    let toUser = Mail.User(email: userEmail)
    let verificationCode = String(code)
    let emailContent = """
    [비포인]
    
    비포인 인증 메일
    
    인증번호 : [\(verificationCode)]
    
    APP에서 인증번호를 입력해주세요.
    """
    let mail = Mail(from: fromUser, to: [toUser], subject: "비포인 인증 안내", text: emailContent)
    hostSMTP.send([mail], completion: { _, fail in
      if let error = (fail.first?.1 as? NSError) {
        print(error)
        completion(code, false)
      } else {
        completion(code, true)
        print(code)
      }
    })
  }
}
