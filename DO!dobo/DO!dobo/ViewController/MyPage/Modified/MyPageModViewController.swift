//
//  MyPageModViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 20..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import Kingfisher

class MyPageModViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var pwdModTextField: UITextField!
    @IBOutlet weak var pwdCheckTextField: UITextField!
    
    //keyboard var
    @IBOutlet weak var c: NSLayoutConstraint!
    var keyboardDismissGesture: UITapGestureRecognizer?
    var constraintInitVal : CGFloat = 0
    var check = true
    
    @IBOutlet weak var seoulightButton: UIButton!
    @IBOutlet weak var seoulightImageView: UIImageView!
    
    let name = UserDefaults.standard.string(forKey: "name")
    let email = UserDefaults.standard.string(forKey: "email")
    
        let imagePicker : UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageInit()
        isRole()
        nameLabel.text = name
        emailLabel.text = email
        
        setBackBtn()
        setKeyboardSetting()
        
        //imageView circle
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.layer.frame.width/2

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 프로필 이미지 선택 액션
    @IBAction func profileGesture(_ sender: UITapGestureRecognizer) {
       openGallery()

    }
    
    //MARK: 프로필 수정 액션
    @IBAction func modifyAction(_ sender: UIButton) {
        
//        //TODO: 팝업추가
//        if let pImage = profileImageView.image {
//
//            //비밀번호 공백 검사 및 비밀번호 수정 성공
//            if pwdModTextField.text != "" && pwdCheckTextField.text != "" {
//                if pwdModTextField.text == pwdCheckTextField.text {
//                    modpwd(pwd: gsno(pwdModTextField.text))
//                    self.noticeSuccess("성공", autoClear: true, autoClearTime: 1)
//                    let MyPageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
//
//                    self.navigationController?.pushViewController(MyPageVC, animated: true)
//                } else { // 비밀번호 수정 실패(수정 값, 확인 값 다를 때)
////                    simpleAlert(title: "수정 실패", message: "비밀번호가 일치하지 않습니다.")
//                    self.noticeError("수정 실패", autoClear: true, autoClearTime: 1)
//                }
//            }
//
//            //비밀번호 수정 값이나 확인 값만 들어있을 때
//            else if (pwdModTextField.text != "" && pwdCheckTextField.text == "") ||
//                (pwdModTextField.text == "" && pwdCheckTextField.text != "") {
//                simpleAlertwithHandler(title: "비밀번호 수정", message:
//            """
//            비밀번호가 수정되지 않았습니다.
//            수정하시겠습니까?
//            """) { (cancelHandler) in
//                self.navigationController?.popViewController(animated: true)
//                }
//            }
//
//            modProfileImage(avatar: pImage)
//            self.noticeSuccess("성공", autoClear: true, autoClearTime: 1)
//            self.navigationController?.popViewController(animated: true)
//
//        }
        
        //TODO: 팝업추가
        if let pImage = profileImageView.image {
            
            //비밀번호 수정 값이나 확인 값만 들어있을 때
            if (pwdModTextField.text != "" && pwdCheckTextField.text == "") ||
                (pwdModTextField.text == "" && pwdCheckTextField.text != "")  {
                simpleAlertwithHandler(title: "비밀번호 수정", message:
            """
            비밀번호가 수정되지 않았습니다.
            수정하시겠습니까?
            """) { (cancelHandler) in
                self.navigationController?.popViewController(animated: true)
                }
            }
            
            //공백 검사
            else if pwdModTextField.text != "" && pwdCheckTextField.text != "" {
                
                //동일성 체크 성공
                if pwdModTextField.text == pwdCheckTextField.text {
                    modProfileImage(avatar: pImage)
                    modpwd(pwd: gsno(pwdModTextField.text))
                    
                }else {
                    self.noticeError("수정 실패", autoClear: true, autoClearTime: 1)
                }
            }
            
            else {
                modProfileImage(avatar: pImage)
            }
            
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
        

        
//        if pwdModTextField.text != "" && pwdCheckTextField.text != "" {
//            if pwdModTextField.text == pwdCheckTextField.text {
//                modpwd(pwd: gsno(pwdModTextField.text))
//                self.navigationController?.popViewController(animated: true)
//            } else {
//                simpleAlert(title: "수정 실패", message: "비밀번호가 일치하지 않습니다.")
//            }
//        }
        
//        if pwdModTextField.text != "" || pwdCheckTextField.text != "" {
//            simpleAlertwithHandler(title: "비밀번호 수정", message:
//            """
//            비밀번호가 수정되지 않았습니다.
//            그대로 나가시겠습니까?
//            """) { (okHandler) in
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
        
    }
    
    //MARK: 프로필 사진 조회 - GET
    func profileImageInit() {
            MyPageService.myPageInit{ (myPage) in
                
                self.profileImageView.kf.setImage(with: URL(string: self.gsno(myPage.avatar)), placeholder: UIImage())
            }
    }
    
    //MARK: 프로필 수정 - PUT
    func modProfileImage(avatar: UIImage) {
        MyPageService.modProfileImage(avatar: avatar) { (message) in
            
            if message == "success" {
                self.noticeSuccess("성공", autoClear: true, autoClearTime: 1)
                self.navigationController?.popViewController(animated: true)

            }
            
            else if message == "internal_server_error" {
                self.simpleAlert(title: "서버 에러", message: "서버 상태가 불안정 합니다.")
            }
            
            else {
                self.simpleAlert(title: "수정 실패", message: "다시 시도해주세요.")
            }
        }
    }
    
    //MARK: 비밀번호 수정 - PUT
    func modpwd(pwd: String) {
        
        MyPageService.modPwd(pwd: pwd) { (message) in
            
            if message == "success" {
                //TODO: 팝업 추가
                self.noticeSuccess("성공", autoClear: true, autoClearTime: 1)
                
            }
                
            else if message == "internal_server_error" {
                self.simpleAlert(title: "서버 에러", message: "서버 상태가 불안정 합니다.")
            }
                
            else {
                self.simpleAlert(title: "수정 실패", message: "다시 시도해주세요.")
            }
        }
    }
    
    //MARK: 서울라이트/회원 판단 함수
    func isRole() {
        let role = UserDefaults.standard.string(forKey: "role")
        
        if role == "SEOULITE" {
            seoulightImageView.isHidden = false
            seoulightButton.isHidden = true
        } else {
            seoulightImageView.isHidden = true
            seoulightButton.isHidden = false
        }
    }
    
}

//MARK: keyboard setting extension
extension MyPageModViewController {
    
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
extension MyPageModViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

