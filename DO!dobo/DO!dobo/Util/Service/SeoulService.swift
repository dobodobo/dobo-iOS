//
//  SeoulService.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 24..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SeoulService: APIService {
    
    //MARK: 서울 리스트 조회 - GET
    static func SeoulListInit(category: Int, completion: @escaping ([Seoul]) -> Void) {
        let URL = url("/seoul/\(category)")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            
            switch res.result {
            case .success:
                
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let seoulData = try decoder.decode(SeoulData.self, from: value)
                        
                        if seoulData.message == "success" {
                            print("서울: 성공")
                            completion(seoulData.result)
                        } else {
                            print("서울: 서버 에러")
                        }
                        
                    } catch {
                        print("서울: 변수 문제")
                    }
                }
                
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
    
    //MARK: 서울 도보 관광 상세보기 - GET
    
    
    //MARK: 서울 도보관광 리뷰 작성 - POST
    static func seoulReview(idx: Int, content: String, completion: @escaping (_ message: String) -> Void) {
        
        let URL = url("/seoul/\(idx)/review")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        let body: [String: Any] = [
            "content" : content
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            switch res.result {
            case .success:
                
                print("서울 리뷰 : 접근")
                
                if let value = res.result.value {
                    
                    let message = JSON(value)["message"].string
                    
                    if message == "success" {
                        print("서울 리뷰 : 성공")
                        completion("success")
                    }
                        
                    else {
                        print("서울 리뷰 : 실패")
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
    
}
