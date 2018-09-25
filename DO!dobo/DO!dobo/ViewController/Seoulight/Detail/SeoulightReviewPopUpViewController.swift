//
//  SeoulightReviewPopUpViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 24..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulightReviewPopUpViewController: UIViewController {

    //keyboard var
    @IBOutlet weak var c: NSLayoutConstraint!
    var keyboardDismissGesture: UITapGestureRecognizer?
    var constraintInitVal : CGFloat = 0
    var check = true
    
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var reviewTextView: UITextView!
    
    var idx: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKeyboardSetting()
        self.showAnimate()
        
        reviewView.layer.cornerRadius = 15
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 창닫기 액션
    @IBAction func dismissAction(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    //MARK: 댓글 등록 액션
    @IBAction func saveAction(_ sender: Any) {
        if reviewTextView.text == "" {
            simpleAlert(title: "등록 실패", message: "모든 항목을 입력해주세요.")
        } else {
            saveReview(content: reviewTextView.text)
        }

    }
    
    //MARK: 서울라이트 리뷰 등록 - POST
    func saveReview(content: String) {
        SeoulightService.seoulightReview(idx: idx, content: content) { (message) in
            print("dd\(self.idx)")
            if message == "success" {
                self.noticeSuccess("성공", autoClear: true, autoClearTime: 1)
                self.removeAnimate()
                self.navigationController?.popViewController(animated: true)
                
                let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulightDetailViewController") as! SeoulightDetailViewController
                
                detailVC.idx = self.idx
                
                self.navigationController?.pushViewController(detailVC, animated: true)
                
            } else {
                self.simpleAlert(title: "리뷰 등록 실패", message: "다시 시도해주세요.")
            }
        }
    }
    
    
    
}

//MARK: keyboard setting extension
extension SeoulightReviewPopUpViewController {
    
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
