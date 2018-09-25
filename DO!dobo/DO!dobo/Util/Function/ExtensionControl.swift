//
//  ExtensionControl.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 22..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation
import UIKit
import SilentScrolly

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
    func simpleAlertwithHandler(title: String, message: String, cancelHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "수정하기",style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "나기기",style: .cancel, handler: cancelHandler)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //팝업 띄우기
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    //팝업 끄기
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
