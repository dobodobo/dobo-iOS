//
//  MyPageService.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 22..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MyPageService: APIService {
    
    //MARK: 서울라이트 신청하기 - POST
    static func applySeoulight(name: String, birth: String, organization: String, portfolio: String, phone: String, intro: String, completion: @escaping (_ message: String) -> Void) {
        
        let URL = url("/seoulight/register")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        let body: [String: Any] = [
            "name" : name,
            "birth" : birth,
            "organization" : organization,
            "portfolio" : portfolio,
            "phone" : phone,
            "intro" : intro
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            switch res.result {
            case .success:
                
                print("서울라이트 신청하기 : 접근")
                
                if let value = res.result.value {
                    
                    let message = JSON(value)["message"].string
                    
                    if message == "success" {
                        print("서울라이트 신청하기 : 성공")
                        completion("success")
                    }
                        
                    else {
                        print("서울라이트 신청하기 : 실패")
                        completion("fail")
                    }
                }
                
                break
                
            case .failure(let err):
                
                print(err.localizedDescription)
                break
            }
        }
    }
    
    //MARK: 건의사항 - POST
    static func suggest(title: String, content: String, completion: @escaping (_ message: String) -> Void) {
        
        let URL = url("/users/feedback")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        let body: [String: Any] = [
            "title" : title,
            "content" : content
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            switch res.result {
            case .success:
                
                print("건의사항 : 접근")
                
                if let value = res.result.value {
                    
                    let message = JSON(value)["message"].string
                    
                    if message == "success" {
                        print("건의사항 : 성공")
                        completion("success")
                    }
                        
                    else {
                        print("건의사항 : 실패")
                        completion("fail")
                    }
                }
                
                break
                
            case .failure(let err):
                
                print(err.localizedDescription)
                break
            }
        }
    }
    
    //MARK:
    
    
}
