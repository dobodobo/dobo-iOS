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
    
    //MARK: 마이페이지 조회 - GET
    static func myPageInit(completion: @escaping (MyPage) -> Void) {

        let URL = url("/users/mypage")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            
            switch res.result {
                
            case .success:
                
                print("마이페이지 : 진입")
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    
                    let message = JSON(value)["status"].int
                    print(message)
                    
                    do {
                        let myPageData = try decoder.decode(MyPageData.self, from: value)
                        
                        if myPageData.status == 200 {
                
                            let message = JSON(value)["message"].string
                            print(message)
 
                            if myPageData.message == "success" {
                                 print("마이페이지 : 성공")
                                completion(myPageData.result)
                            } else {
                                print("마이페이지 : 실패")
                            }
                            
                        } else {
                            print("마이페이지 : 서버 에러")
                        }
                        
                    } catch {
                        print("마이페이지 : 변수 에러")
                    }
                    
                }
                
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
        
    }
    
    //MARK: 프로필 이미지 수정 - PUT
    static func modProfileImage(avatar: UIImage, completion: @escaping (_ message: String) -> Void) {
        
        let URL = url("/users/avatar")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        let avatarData = UIImageJPEGRepresentation(avatar, 0.3)
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(avatarData!, withName: "avatar", fileName: "photo.jpg", mimeType: "image/jpeg")
            
        }, to: URL, method: .put, headers: token_header) { (encodingResult) in
            
            switch encodingResult {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _) :
                
                upload.responseData(completionHandler: {(res) in
                    switch res.result {
                        
                    case .success :
                        print("프로필 이미지 수정 : 진입")
                        if let value = res.result.value {
                            
                            let message = JSON(value)["message"].string
                            print("message: \(String(describing: message))")
                            
                            if message == "success" {
                                print("프로필 이미지 수정 : 성공")
                                completion("success")
                            }
                                
                            else if message == "internal_server_error" {
                                print("프로필 이미지 수정 : 서버 에러")
                                completion("internal_server_error")
                            }
                            
                            else {
                                print("프로필 이미지 수정 : 실패")
                                completion("fail")
                            }
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                })
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    
    //MARK: 비밀번호 수정 - PUT
    static func modPwd(pwd: String, completion: @escaping (_ message: String) -> Void) {
        let URL = url("/users/pwd")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        let body : [String: Any] = [
            "pwd" : pwd
        ]
        
        Alamofire.request(URL, method: .put, parameters: body, encoding: JSONEncoding.default, headers: token_header).responseData() { res in
            
            switch res.result {
            case .success:
                
                print("비밀번호 수정 : 진입")
                if let value = res.result.value {
                    
                    let message = JSON(value)["message"].string
                    
                    if message == "success" {
                        print("비밀번호 수정 : 성공")
                        completion("success")
                    }
                    
                    else if message == "internal_server_error" {
                        print("프로필 이미지 수정 : 서버 에러")
                        completion("internal_server_error")
                    }
                    
                    else {
                        print("비밀번호 수정 : 실패")
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
    
    //MARK: 서울라이트 신청하기 - POST
    static func applySeoulight(name: String, birth: String, organization: String, portfolio: String, email: String, phone: String, intro: String, completion: @escaping (_ message: String) -> Void) {
        
        let URL = url("/seoulight/register")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let token_header = [ "token" : token ]
        
        let body: [String: Any] = [
            "name" : name,
            "birth" : birth,
            "organization" : organization,
            "portfolio" : portfolio,
            "email": email,
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
