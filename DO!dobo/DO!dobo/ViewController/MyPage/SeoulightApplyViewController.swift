//
//  SeoulightApplyViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 20..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulightApplyViewController: UIViewController {

    @IBOutlet weak var c: NSLayoutConstraint!
    var keyboardDismissGesture: UITapGestureRecognizer?
    var constraintInitVal : CGFloat = 0
    var check = true
    
    @IBOutlet weak var singleButton: UIButton!
    @IBOutlet weak var orgButton: UIButton!
    var single: String?
    
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

    //MARK: 개인/단체 선택
    @IBAction func peopleAction(_ sender: UIButton) {
        
        if sender == singleButton {
            singleButton.isSelected = !singleButton.isSelected
            singleButton.setImage(#imageLiteral(resourceName: "group2"), for: UIControlState.normal)
            orgButton.setImage(#imageLiteral(resourceName: "group4Copy"), for: UIControlState.normal)
            single = "개인"
        }
            
        else {
            orgButton.isSelected = !orgButton.isSelected
            orgButton.setImage(#imageLiteral(resourceName: "group4Copy2"), for: UIControlState.normal)
            singleButton.setImage(#imageLiteral(resourceName: "group2Copy"), for: UIControlState.normal)
            single = "단체"
        }
    }
    
}

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

