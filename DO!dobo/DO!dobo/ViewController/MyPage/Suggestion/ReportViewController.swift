//
//  ReportViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 19..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //keyboard var
    @IBOutlet weak var c: NSLayoutConstraint!
    var keyboardDismissGesture: UITapGestureRecognizer?
    var constraintInitVal : CGFloat = 0
    var check = true
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn()
        setKeyboardSetting()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 건의사항 제출 액션
    @IBAction func suggestAction(_ sender: UIButton) {
        
        if titleTextField.text == "" || contentTextView.text == "" {
            
            let alertView = UIAlertController(title: "제출 실패", message: "모든 항목을 입력해주세요.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertView.addAction(ok)
            self.present(alertView, animated: true, completion: nil)
            
        } else {
            suggest(title: gsno(titleTextField.text), content: gsno(contentTextView.text))
        }
        
    }
    
    //MARK: 건의사항 - POST
    func suggest(title: String, content: String) {
        MyPageService.suggest(title: title, content: content) { (message) in
            
            //TODO: 팝업 라이브러리 추가
            if message == "success" {
                self.noticeSuccess("접수 완료", autoClear: true, autoClearTime: 1)
                self.navigationController?.popViewController(animated: true)
            }
            
            else {
                
                let alertView = UIAlertController(title: "서버 에러", message: "서버 상태가 불안정합니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alertView.addAction(ok)
                self.present(alertView, animated: true, completion: nil)
                
            }
            
        }
    }

}

extension ReportViewController {
    
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            if check {
                constraintInitVal = c.constant
                c.constant += keyboardSize.height
                
                self.view.layoutIfNeeded()
                check = false
            }
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            c.constant = constraintInitVal

            self.view.layoutIfNeeded()
            check = true
        }
    }
    
    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
}

