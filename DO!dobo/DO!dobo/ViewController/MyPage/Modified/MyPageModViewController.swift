//
//  MyPageModViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 20..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class MyPageModViewController: UIViewController {
    
//    var homeController: UIViewController?
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var c: NSLayoutConstraint!
    var keyboardDismissGesture: UITapGestureRecognizer?
    var constraintInitVal : CGFloat = 0
    var check = true
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    //TODO: 일반 회원일때, 보이기
    @IBOutlet weak var seoulightButton: UIButton!
    
    //TODO: 서울라이트일 때, 보이기
    @IBOutlet weak var SeoulightImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        homeController = self
        
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
    
    @IBAction func profileGesture(_ sender: UITapGestureRecognizer) {
       openGallery()

    }
    
}

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

//protocol Gallery : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    var homeController : UIViewController? {get set}
//    func openGalleryCamera()
//}
//
//extension Gallery {
//
//    func openGalleryCamera(){
//        let selectAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        let libraryAction = UIAlertAction(title: "앨범", style: .default) { _ in if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            imagePicker.allowsEditing = true
//            self.homeController?.present(imagePicker, animated: true, completion: nil)
//            }
//
//        }
//        let cameraAction = UIAlertAction(title: "카메라", style: .default) {
//            _ in  if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
//                let imagePicker = UIImagePickerController()
//                imagePicker.delegate = self
//                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
//                imagePicker.allowsEditing = true
//                self.homeController?.present(imagePicker, animated: true, completion: nil)
//            }
//        }
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//        selectAlert.addAction(libraryAction)
//        selectAlert.addAction(cameraAction)
//        selectAlert.addAction(cancelAction)
//        self.homeController?.present(selectAlert, animated: true, completion: nil)
//    }
//}
//
