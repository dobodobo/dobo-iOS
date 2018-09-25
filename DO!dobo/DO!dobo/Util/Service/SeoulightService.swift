//
//  SeoulightService.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 25..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SeoulightService: APIService {
    
    //MARK: 서울라이트 리스트 조회 - GET
    static func SeoulightInit(category: String, completion: @escaping ([Seoulight]) -> Void) {
        let URL = url("/seoulite/\(category)")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            
            switch res.result {
            case .success:
                
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let seoulightData = try decoder.decode(SeoulightData.self, from: value)
                        
                        if seoulightData.message == "success" {
                            print("서울라이트: 성공")
                            completion(seoulightData.result)
                        } else {
                            print("서울라이트: 서버 에러")
                        }
                        
                    } catch {
                        print("서울라이트: 변수 문제")
                    }
                }
                
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
    
    //MARK: 서울라이트 리스트 조회 (인기순) - GET
    static func SeoulightInitHit(category: String, completion: @escaping ([Seoulight]) -> Void) {
        let URL = url("/seoulite/\(category)?sort=count")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            
            switch res.result {
            case .success:
                
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let seoulightData = try decoder.decode(SeoulightData.self, from: value)
                        
                        if seoulightData.message == "success" {
                            print("서울라이트 인기순: 성공")
                            completion(seoulightData.result)
                        } else {
                            print("서울라이트 인기순: 서버 에러")
                        }
                        
                    } catch {
                        print("서울라이트 인기순: 변수 문제")
                    }
                }
                
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
    
    //MARK: 서울라이트 리스트 조회 (마감순) - GET
    static func SeoulightInitDue(category: String, completion: @escaping ([Seoulight]) -> Void) {
        let URL = url("/seoulite/\(category)?sort=due")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            
            switch res.result {
            case .success:
                
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let seoulightData = try decoder.decode(SeoulightData.self, from: value)
                        
                        if seoulightData.message == "success" {
                            print("서울라이트 마감순: 성공")
                            completion(seoulightData.result)
                        } else {
                            print("서울라이트 마감순: 서버 에러")
                        }
                        
                    } catch {
                        print("서울라이트 마감순: 변수 문제")
                    }
                }
                
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
    
    
    
    //MARK: 서울라이트 상세보기 - GET
    static func seoulightDetailInit(idx: Int, completion: @escaping (SeoulightDetail) -> Void) {
        let URL = url("/seoulite/\(idx)/detail")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            
            switch res.result {
            case .success:
                
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let seoulightDetailData = try decoder.decode(SeoulightDetailData.self, from: value)
                        
                        if seoulightDetailData.message == "success" {
                            print("서울라이트 상세보기: 성공")
                            completion(seoulightDetailData.result)
                        } else {
                            print("서울라이트 상세보기: 서버 에러")
                        }
                        
                    } catch {
                        print("서울라이트 상세보기: 변수 문제")
                    }
                }
                
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
    
    //MARK: 서울라이트 도보관광 예약하기 - POST
    static func bookSeoulight(idx: Int, completion: @escaping (_ message: String) -> Void) {
        
        let URL = url("/seoulite/\(idx)/reserve")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        Alamofire.request(URL, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            switch res.result {
            case .success:
                
                print("서울라이트 예약: 접근")
                
                if let value = res.result.value {
                    
                    let message = JSON(value)["message"].string
                    
                    if message == "success" {
                        print("서울라이트 예약: 성공")
                        completion("success")
                    }
                        
                    else {
                        print("서울라이트 예약: 실패")
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
    
    
    
    //MARK: 서울라이트 도보관광 리뷰 작성 - POST
    static func seoulightReview(idx: Int, content: String, completion: @escaping (_ message: String) -> Void) {
        
        let URL = url("/seoulite/\(idx)/review")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        let body: [String: Any] = [
            "content" : content
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            switch res.result {
            case .success:
                
                print("서울라이트 리뷰: 접근")
                
                if let value = res.result.value {
                    
                    let message = JSON(value)["message"].string
                    
                    if message == "success" {
                        print("서울라이트 리뷰: 성공")
                        completion("success")
                    }
                        
                    else {
                        print("서울라이트 리뷰: 실패")
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
