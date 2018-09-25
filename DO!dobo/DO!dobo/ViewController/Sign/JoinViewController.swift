//
//  JoinViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 22..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var pwdCheckTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    //keyboard var
    @IBOutlet weak var c: NSLayoutConstraint!
    var keyboardDismissGesture: UITapGestureRecognizer?
    var constraintInitVal : CGFloat = 0
    var check = true
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        
        isNullCheck()
        setKeyboardSetting()
        
        //imageView circle
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.layer.frame.width / 2
        profileImageView.layer.borderWidth = 1;
        profileImageView.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.7843137255, blue: 0.7764705882, alpha: 1)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 이미지 피커 액션
    @IBAction func opnImagePicker(_ sender: UITapGestureRecognizer) {
        openGallery()
    }
    
    //MARK: 회원가입 액션
    @IBAction func joinAction(_ sender: UIButton) {
        
        if let pImage = profileImageView.image {
            //공백 검사
            if pwdCheckTextField.text == "" || pwdTextField.text == "" || nameTextField.text == "" || idTextField.text == "" {
                simpleAlert(title: "회원가입 실패", message: "모든 항목을 입력해주세요")
            }
            
            //동일성 체크
            else if pwdCheckTextField.text != pwdTextField.text {
                simpleAlert(title: "회원가입 실패", message: "비밀번호가 일치하지 않습니다.")
            }
            
            else {
                join(email: gsno(idTextField.text), pwd: gsno(pwdTextField.text), name: gsno(nameTextField.text), profileImage: pImage)
            }
        }

    }
    
    //MARK: dismiss 액션
    @IBAction func dismissAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func join(email: String, pwd: String, name: String, profileImage: UIImage) {
        
        SignService.join(email: email, pwd: pwd, nick: name, avatar: profileImage) { (message) in
            
            if message == "success" {
                self.saveButton.setImage(#imageLiteral(resourceName: "finishBtnFill"), for: .normal)
                self.dismiss(animated: true, completion: nil)
            }
            
            else if message == "exist_id" {
                self.simpleAlert(title: "회원가입 실패", message: "이미 존재하는 이메일입니다.")
            }
            
            else {
                self.simpleAlert(title: "회원가입 실패", message: "서버가 불안정합니다.")
            }
        }
    }
        
    //TODO: 예외처리하기
    func isNullCheck() {
        if idTextField.text != "" && pwdTextField.text != "" && pwdCheckTextField.text != "" {
            saveButton.setImage(#imageLiteral(resourceName: "finishBtnFill"), for: .normal)
        }
    }
}

//MARK: keyboard setting extension
extension JoinViewController {
    
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

// MARK: 이미지 첨부
extension JoinViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Method
    @objc func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    // imagePickerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("사용자가 취소함")
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        defer {
        //            self.dismiss(animated: true) {
        //                print("이미지 피커 사라짐")
        //            }
        //        }
        
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageView.image = editedImage
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profileImageView.image = originalImage
        }
        
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
    
}


