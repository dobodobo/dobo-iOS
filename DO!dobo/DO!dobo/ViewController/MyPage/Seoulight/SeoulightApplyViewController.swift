//
//  SeoulightApplyViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 20..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulightApplyViewController: UIViewController {

    //keyboaed var
    @IBOutlet weak var c: NSLayoutConstraint!
    var keyboardDismissGesture: UITapGestureRecognizer?
    var constraintInitVal : CGFloat = 0
    var check = true
    
    //toggle btn var
    @IBOutlet weak var singleButton: UIButton!
    @IBOutlet weak var orgButton: UIButton!
    var single: Int?
    
    //pickerView var
    let datePicker = UIDatePicker()

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var orgTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var introTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn()
        setKeyboardSetting()
        initDatePicker()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: 개인/단체 선택
    @IBAction func peopleAction(_ sender: UIButton) {
        
        if sender == singleButton {
            singleButton.isSelected = !singleButton.isSelected
            singleButton.setImage(#imageLiteral(resourceName: "group23"), for: UIControlState.normal)
            orgButton.setImage(#imageLiteral(resourceName: "group4Copy"), for: UIControlState.normal)
            single = 0
        }
            
        else {
            orgButton.isSelected = !orgButton.isSelected
            orgButton.setImage(#imageLiteral(resourceName: "people"), for: UIControlState.normal)
            singleButton.setImage(#imageLiteral(resourceName: "group2Copy"), for: UIControlState.normal)
            single = 1
        }
    }
    
    //MARK: 서울라이트 신청하기 액션
    @IBAction func seoulightApplyAction(_ sender: UIButton) {
        if nameTextField.text == "" || single == nil || birthTextField.text == "" || orgTextField.text == "" || phoneTextField.text == "" || portTextField.text == "" {
            
        self.simpleAlert(title: "신청 실패", message: "필수 항목을 모두 입력해주세요.")
            
        } else {
            applySeoulight(name: gsno(nameTextField.text), birth: gsno(birthTextField.text), organization: gsno(orgTextField.text), portfolio: gsno(portTextField.text), phone: gsno(phoneTextField.text), intro: gsno(introTextView.text))
        }
    }
    
    //TODO: 개인/단체 변수 추가(single)
    //MARK: 서울라이트 신청하기 - POST
    func applySeoulight(name: String, birth: String, organization: String, portfolio: String, phone: String, intro: String) {
        MyPageService.applySeoulight(name: name, birth: birth, organization: organization, portfolio: portfolio, phone: phone, intro: intro) { (message) in
            
            if message == "success" {
                
                //FIXME: 알림 메시지 수정
                self.simpleAlert(title: "신청 완료", message:
                    """
                    관리자 심사 후, 추후 기재하신 번호를 통하여
                    결과가 발표됩니다.
                    """
                )
                
            }
            
            else {
                self.simpleAlert(title: "신청 실패" , message: "다시 시도해주세요.")
            }
            
        }
    }
    
    
}

//MARK: keyboard setting extension
extension SeoulightApplyViewController{
    
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

//MARK: date picker extension
extension SeoulightApplyViewController  {
    
    func initDatePicker(){
        
        datePicker.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        guard let date = dateFormatter.date(from: "1996.01.29") else {
            fatalError("포맷과 맞지 않아 데이터 변환이 실패했습니다")
        }
        
        datePicker.date = date
        
        datePicker.maximumDate = Date()
        
        
        setTextfieldView(textField: birthTextField, selector: #selector(selectedDatePicker), inputView: datePicker)
    }
    
    func setTextfieldView(textField:UITextField, selector : Selector, inputView : Any){
        
        let bar = UIToolbar()
        bar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "확인", style: .done
            , target: self, action: selector)
        
        bar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = bar
        
        if let tempView = inputView as? UIView {
            textField.inputView = tempView
        }
        if let tempView = inputView as? UIControl {
            textField.inputView = tempView
        }
        
    }
    
    @objc func selectedDatePicker(){
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy.MM.dd"
        
        let date = dateformatter.string(from: datePicker.date)
        
        birthTextField.text = date
        
        view.endEditing(true)
    }
    
}

