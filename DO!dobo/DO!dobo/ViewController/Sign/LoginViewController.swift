//
//  LoginViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 22..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //keyboard var
    @IBOutlet weak var c: NSLayoutConstraint!
    var keyboardDismissGesture: UITapGestureRecognizer?
    var constraintInitVal : CGFloat = 0
    var check = true
    
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var introStackView: UIStackView!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var idTextBoxImageView: UIImageView!
    @IBOutlet weak var pwdTextBoxImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
        
        setKeyboardSetting()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        if idTextField.text == "" || pwdTextField.text == "" {
            
            self.simpleAlert(title: "로그인 실패", message: "모든 항목을 입력해주세요.")

        } else {
            login(email: gsno(idTextField.text), pwd: gsno(pwdTextField.text))
        }
        
        
    }
    
    //TODO: 팝업 삭제하기 - 예외 처리 끝나면
    //MARK: 로그인 - POST
    func login(email: String, pwd: String) {
        SignService.login(email: email, pwd: pwd) { (message) in
            
            if message == "success"{
                self.pwdTextBoxImageView.image = #imageLiteral(resourceName: "loginTextbox")
                let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabVC")
            
                self.present(tabVC, animated: true, completion: nil)
            }
                
            else if message == "not_match_email_or_pw" {
                
                self.pwdTextBoxImageView.image = #imageLiteral(resourceName: "loginTextboxError")
                self.simpleAlert(title: "로그인 실패", message: "아이디 또는 비밀번호가 일치하지 않습니다.")
                
            }
            
            else if message == "not_signin" {
                
                self.idTextBoxImageView.image = #imageLiteral(resourceName: "loginTextboxError")
                self.simpleAlert(title: "로그인 실패", message: "아이디가 존재하지 않습니다.")
                
            }
                
            else {
                
                self.simpleAlert(title: "로그인 실패", message: "다시 시도해주세요.")
                
            }
            
        }
        
    }
    
    
}

//MARK: keyboard setting extension
extension LoginViewController {
    
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if check {
                
                self.loginImageView.image = #imageLiteral(resourceName: "loginGraphic")
                self.introStackView.isHidden = true
                
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
            
            self.loginImageView.image = #imageLiteral(resourceName: "loginFullGraphic")
            self.introStackView.isHidden = false
            
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
