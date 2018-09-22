//
//  ExtensionControl.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 22..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func gsno(_ value: String?) -> String { //String 옵셔널 벗기기
        return value ?? ""
    }
    
    func gino(_ value: Int?) -> Int { //Int 옵셔널 벗기기
        return value ?? 0
    }
    
    //확인 팝업
    func simpleAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    //확인, 취소 팝업
    func simpleAlertwithHandler(title: String, message: String, okHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension UITableViewCell {
    func gsno(_ value: String?) -> String { //String 옵셔널 벗기기
        return value ?? ""
    }
    
    func gino(_ value: Int?) -> Int { //Int 옵셔널 벗기기
        return value ?? 0
    }
}

extension NSObject {
    static var reuseIdentifier: String { //스토리보드 idetifier
        return String(describing: self)
    }
}
