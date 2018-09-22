//
//  SeoulightWriteTableViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 21..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import GooglePlaces

class SeoulightWriteTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var cultureButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var festButton: UIButton!
    @IBOutlet weak var eatButton: UIButton!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var etcButton: UIButton!
    var category: String?
    
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var peopleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var finishTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var courseSearchTextField: UITextField!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var datePicker = UIDatePicker()
    
    let pickerView = UIPickerView()
    var categoryArr = [#imageLiteral(resourceName: "group2Copy.png"), #imageLiteral(resourceName: "group4Copy.png"), #imageLiteral(resourceName: "group23.png")]
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    var imageArr: [UIImage] = [#imageLiteral(resourceName: "icAdImage")]
    var imageNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //datePicker
        initDatePicker1()
        initDatePicker2()
        
        //collectionView method
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 카테고리 액션
    @IBAction func categoryAction(_ sender: UIButton) {
        
        if sender == cultureButton {
            cultureButton.isSelected = !cultureButton.isSelected
            cultureButton.setImage(#imageLiteral(resourceName: "cultureGreen"), for: UIControlState.normal)
            historyButton.setImage(#imageLiteral(resourceName: "historyGray"), for: UIControlState.normal)
            festButton.setImage(#imageLiteral(resourceName: "festivalGray"), for: UIControlState.normal)
            eatButton.setImage(#imageLiteral(resourceName: "foodGray"), for: UIControlState.normal)
            activityButton.setImage(#imageLiteral(resourceName: "activityGray"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "etcGray"), for: UIControlState.normal)
            category = "문화"
        } else if sender == historyButton {
            historyButton.isSelected = !historyButton.isSelected
            cultureButton.setImage(#imageLiteral(resourceName: "cultureGray"), for: UIControlState.normal)
            historyButton.setImage(#imageLiteral(resourceName: "historyGreen"), for: UIControlState.normal)
            festButton.setImage(#imageLiteral(resourceName: "festivalGray"), for: UIControlState.normal)
            eatButton.setImage(#imageLiteral(resourceName: "foodGray"), for: UIControlState.normal)
            activityButton.setImage(#imageLiteral(resourceName: "activityGray"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "etcGray"), for: UIControlState.normal)
            category = "역사"
        } else if sender == festButton {
            festButton.isSelected = !festButton.isSelected
            cultureButton.setImage(#imageLiteral(resourceName: "cultureGray"), for: UIControlState.normal)
            historyButton.setImage(#imageLiteral(resourceName: "historyGray"), for: UIControlState.normal)
            festButton.setImage(#imageLiteral(resourceName: "festivalGreen"), for: UIControlState.normal)
            eatButton.setImage(#imageLiteral(resourceName: "foodGray"), for: UIControlState.normal)
            activityButton.setImage(#imageLiteral(resourceName: "activityGray"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "etcGray"), for: UIControlState.normal)
            category = "축제"
        } else if sender == eatButton {
            eatButton.isSelected = !eatButton.isSelected
            cultureButton.setImage(#imageLiteral(resourceName: "cultureGray"), for: UIControlState.normal)
            historyButton.setImage(#imageLiteral(resourceName: "historyGray"), for: UIControlState.normal)
            festButton.setImage(#imageLiteral(resourceName: "festivalGray"), for: UIControlState.normal)
            eatButton.setImage(#imageLiteral(resourceName: "foodGreen"), for: UIControlState.normal)
            activityButton.setImage(#imageLiteral(resourceName: "activityGray"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "etcGray"), for: UIControlState.normal)
            category = "먹방"
        } else if sender == activityButton {
            activityButton.isSelected = !activityButton.isSelected
            cultureButton.setImage(#imageLiteral(resourceName: "cultureGray"), for: UIControlState.normal)
            historyButton.setImage(#imageLiteral(resourceName: "historyGray"), for: UIControlState.normal)
            festButton.setImage(#imageLiteral(resourceName: "festivalGray"), for: UIControlState.normal)
            eatButton.setImage(#imageLiteral(resourceName: "foodGray"), for: UIControlState.normal)
            activityButton.setImage(#imageLiteral(resourceName: "activityGreen"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "etcGray"), for: UIControlState.normal)
            category = "액티비티"
        } else {
            etcButton.isSelected = !etcButton.isSelected
            cultureButton.setImage(#imageLiteral(resourceName: "cultureGray"), for: UIControlState.normal)
            historyButton.setImage(#imageLiteral(resourceName: "historyGray"), for: UIControlState.normal)
            festButton.setImage(#imageLiteral(resourceName: "festivalGray"), for: UIControlState.normal)
            eatButton.setImage(#imageLiteral(resourceName: "foodGray"), for: UIControlState.normal)
            activityButton.setImage(#imageLiteral(resourceName: "activityGray"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "etcGreen"), for: UIControlState.normal)
            category = "기타"
        
        }
        
    }
    
    
    //MARK: dismiss
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: 글 등록 액션
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func categryIconAction(_ sender: UIButton) {
        
    }
    
    
    //MARK: 코스 검색 액션
    @IBAction func courseSearchAction(_ sender: UITextField) {
        
        courseSearchTextField.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }


    // MARK: TableView method
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    //TODO: 코스 추가시 높이 복구, 초기 및 코스 없으면 0
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var height = super.tableView(tableView, heightForRowAt: indexPath)
//        if (indexPath.row == 8) {
//            height = 0.0
//        }
//        return height
//    }
    
    //MARK: CollectionView method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == courseCollectionView {
            return 6
        }
        
        else {
            return imageArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == courseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeoulightAddCourseCollectionViewCell", for: indexPath) as! SeoulightAddCourseCollectionViewCell
            
            cell.nameLabel.text = "서울창조경제혁신센터"
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeoulightAddImageCollectionViewCell", for: indexPath) as! SeoulightAddImageCollectionViewCell
            
            if indexPath.row == 0 {
                cell.deleteButton.isHidden = true
            } else {
                 cell.deleteButton.isHidden = false
            }
            
            cell.placeImageView.image = imageArr[indexPath.row]
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteCellFromButton(button:)), for: .touchUpInside)
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if imageNum < 5 {
                openGallery()
            }
            
            else if imageNum >= 5 {
                let message = UIAlertController(title: "사진 개수 초과", message: "사진은 최대 5장까지 첨부 가능합니다.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                message.addAction(action)
                self.present(message, animated: true,completion: nil)
            }
        }
    }
    
    @objc func deleteCellFromButton(button: UIButton) {
        
        imageArr.remove(at: button.tag)
        imageNum -= 1
        imageCollectionView.reloadData()
    }

}

//extension SeoulightWriteTableViewController : UIPickerViewDelegate, UIPickerViewDataSource {
//    
//    //UIPickerViewDelegate
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    //UIPickerViewDelegate
//    //컴포넌트 당 row 가 몇개가 될 것인가
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return categoryArr.count
//    }
//    
//    ///UIPickerViewDataSource 위한 것
//    //각각의 row 에 어떠한 내용이 들어갈 것인가
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> UIImage? {
//        return categoryArr[row]
//        
//    }
//    
//    func initPicker(){
//        //구현 후에 해당 pickerView의 데이터 소스와 델리게이트가 있는 위치 알려 주는 것
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        
//        setButtonView(button: categoryButton, selector: #selector(selectedPicker), inputView: pickerView)
//        
//    }
//    
//    
//    func setButtonView(button : UIButton, selector : Selector, inputView : Any){
//        
//        let bar = UIToolbar()
//        bar.sizeToFit()
//        
//        let doneButton = UIBarButtonItem(title: "확인", style: .done
//            , target: self, action: selector)
//        
//        bar.setItems([doneButton], animated: true)
//        button.inputAccessoryView = bar
//        
//        if let tempView = inputView as? UIView {
//            button.inputView = tempView
//        }
//        if let tempView = inputView as? UIControl {
//            button.inputView = tempView
//        }
//        
//    }
//    
//    @objc func selectedPicker(){
//        
//        let row = pickerView.selectedRow(inComponent: 0)
//        
//        categoryButton.text = categoryArr[row]
//        
//        view.endEditing(true)
//    }
//}



//MARK: Google Place API extension
extension SeoulightWriteTableViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Get the place name from 'GMSAutocompleteViewController'
        // Then display the name in textField
        courseSearchTextField.text = place.name
        
        // Dismiss the GMSAutocompleteViewController when something is selected
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
}

// MARK: 이미지 첨부
extension SeoulightWriteTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            imageArr.append(editedImage)
            imageNum += 1
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageArr.append(originalImage)
            imageNum += 1
        }
        
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
            self.imageCollectionView.reloadData()
        }
    }
}


//MARK: date picker extension
extension SeoulightWriteTableViewController {
    
    func initDatePicker1(){
        
        datePicker.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        guard let date = dateFormatter.date(from: "1996.01.29") else {
            fatalError("포맷과 맞지 않아 데이터 변환이 실패했습니다")
        }
        
        datePicker.date = date
        
        datePicker.maximumDate = Date()
        
        setTextfieldView(textField: dateTextField, selector: #selector(selectedDatePicker1), inputView: datePicker)
    }
    
    func initDatePicker2(){
        
        datePicker.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        guard let date = dateFormatter.date(from: "1996.01.29") else {
            fatalError("포맷과 맞지 않아 데이터 변환이 실패했습니다")
        }
        
        datePicker.date = date
        
        datePicker.maximumDate = Date()
        
        setTextfieldView(textField: finishTextField, selector: #selector(selectedDatePicker2), inputView: datePicker)
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
    
    @objc func selectedDatePicker1(){
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy.MM.dd"
        
        let date = dateformatter.string(from: datePicker.date)
        
        dateTextField.text = date
        
        view.endEditing(true)
    }
    
    @objc func selectedDatePicker2(){
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy.MM.dd"
        
        let date = dateformatter.string(from: datePicker.date)
        
        finishTextField.text = date
        
        view.endEditing(true)
    }
    
}
