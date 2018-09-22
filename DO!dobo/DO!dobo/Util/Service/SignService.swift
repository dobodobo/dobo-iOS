//
//  SignService.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 22..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SignService: APIService {

    //TODO: 에러 처리 확인
    //MARK: 회원가입
    static func join(email: String, pwd: String, nick: String, avatar: UIImage, completion: @escaping (_ message: String) -> Void){
        
        let URL = url("/users/signup")
        
        let emailData = email.data(using: .utf8)
        let pwdData = pwd.data(using: .utf8)
        let nickData = nick.data(using: .utf8)
        let avatarData = UIImageJPEGRepresentation(avatar, 0.3)

        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(emailData!, withName: "email")
            multipartFormData.append(pwdData!, withName: "pwd")
            multipartFormData.append(nickData!, withName: "nick")
            multipartFormData.append(avatarData!, withName: "avatar", fileName: "photo.jpg", mimeType: "image/jpeg")
            
        }, to: URL, method: .post, headers: nil ) { (encodingResult) in
            
            switch encodingResult {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _) :
                
                upload.responseData(completionHandler: {(res) in
                    switch res.result {
                        
                    case .success :
                        print("회원가입 : 진입")
                        if let value = res.result.value {
                            
                            let message = JSON(value)["message"].string
                            print("message: \(String(describing: message))")
                            
                            if message == "success" {
                                print("회원가입 : 성공")
                                completion("success")
                            }
                        
                            else if message == "exist_id" {
                                print("아이디 중복")
                                completion("exist_id")
                            }
                        
                            else if message == "internal_server_error" {
                                print("서버 에러")
                                completion("internal_server_error")
                                
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
    
    //TODO: 없는 아이디 에러 처리 확인
    //MARK: 로그인
    static func login(email: String, pwd: String, completion: @escaping (_ message: String) -> Void){
        
        let URL = url("/users/signin")
        
        let body: [String: Any] = [
            "email" : email,
            "pwd" : pwd
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseData() { res in
            switch res.result{
                
            case .success:
                print("로그인 : 진입")
                
                if let value = res.result.value{
                    
                    
                    
                    if let message = JSON(value)["message"].string {
                        
                        let des = JSON(value)["description"].string
                        
                        UserDefaults.standard.set(JSON(value)["result"]["profile"]["email"].string, forKey: "id") //회원 아이디
                        
                        if message == "success"{ // 로그인 성공
                            print("로그인 : 성공")
                            
                            UserDefaults.standard.set(JSON(value)["result"]["token"].string, forKey: "token") //회원 토큰
                            let token = UserDefaults.standard.string(forKey: "token")
                            
                            print("토큰 : \(token ?? "")")
                        
                            completion("success")
                        }
                        
                        else if message == "login_fail" { // 로그인 실패
                            print(des ?? "")
                            completion("login_fail")
                        }
                        
                        else if message == "not_signin" {
                                print(des ?? "")
                                completion("not_signin")
                        }
                        
                        else if message == "not_match_email_or_pw" {
                                print(des ?? "")
                                completion("not_match_email_or_pw")
                            
                        }
                        
                        else if message == "expired_token" {
                            print(des ?? "")
                            completion("expired_token")
                            
                        }
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
