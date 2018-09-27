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
    var category: Int = 0
    
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var finishTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var courseSearchTextField: UITextField!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var minPeopleTextField: UITextField!
    @IBOutlet weak var maxPeopleTextField: UITextField!
    
    var datePicker = UIDatePicker()
    
    let pickerView = UIPickerView()
    var categoryArr = [#imageLiteral(resourceName: "group2Copy.png"), #imageLiteral(resourceName: "group4Copy.png"), #imageLiteral(resourceName: "group23.png")]
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    var imageArr: [UIImage] = [#imageLiteral(resourceName: "icAdImage")]
    var orimageArr: [UIImage] = []
    var imageNum: Int = 0
    
    var courseArr: [String] = []
    var courseNum: Int = 0
    var allDic : [[String : String]] = []
    
    
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
        
        //keyboard method
        NotificationCenter.default.addObserver(self, selector: #selector(SeoulightWriteTableViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SeoulightWriteTableViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        courseCollectionView.reloadData()
        
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
            category = 1
        } else if sender == historyButton {
            historyButton.isSelected = !historyButton.isSelected
            cultureButton.setImage(#imageLiteral(resourceName: "cultureGray"), for: UIControlState.normal)
            historyButton.setImage(#imageLiteral(resourceName: "historyGreen"), for: UIControlState.normal)
            festButton.setImage(#imageLiteral(resourceName: "festivalGray"), for: UIControlState.normal)
            eatButton.setImage(#imageLiteral(resourceName: "foodGray"), for: UIControlState.normal)
            activityButton.setImage(#imageLiteral(resourceName: "activityGray"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "etcGray"), for: UIControlState.normal)
            category = 3
        } else if sender == festButton {
            festButton.isSelected = !festButton.isSelected
            cultureButton.setImage(#imageLiteral(resourceName: "cultureGray"), for: UIControlState.normal)
            historyButton.setImage(#imageLiteral(resourceName: "historyGray"), for: UIControlState.normal)
            festButton.setImage(#imageLiteral(resourceName: "festivalGreen"), for: UIControlState.normal)
            eatButton.setImage(#imageLiteral(resourceName: "foodGray"), for: UIControlState.normal)
            activityButton.setImage(#imageLiteral(resourceName: "activityGray"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "etcGray"), for: UIControlState.normal)
            category = 5
        } else if sender == eatButton {
            eatButton.isSelected = !eatButton.isSelected
            cultureButton.setImage(#imageLiteral(resourceName: "cultureGray"), for: UIControlState.normal)
            historyButton.setImage(#imageLiteral(resourceName: "historyGray"), for: UIControlState.normal)
            festButton.setImage(#imageLiteral(resourceName: "festivalGray"), for: UIControlState.normal)
            eatButton.setImage(#imageLiteral(resourceName: "foodGreen"), for: UIControlState.normal)
            activityButton.setImage(#imageLiteral(resourceName: "activityGray"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "etcGray"), for: UIControlState.normal)
            category = 4
        } else if sender == activityButton {
            activityButton.isSelected = !activityButton.isSelected
            cultureButton.setImage(#imageLiteral(resourceName: "cultureGray"), for: UIControlState.normal)
            historyButton.setImage(#imageLiteral(resourceName: "historyGray"), for: UIControlState.normal)
            festButton.setImage(#imageLiteral(resourceName: "festivalGray"), for: UIControlState.normal)
            eatButton.setImage(#imageLiteral(resourceName: "foodGray"), for: UIControlState.normal)
            activityButton.setImage(#imageLiteral(resourceName: "activityGreen"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "etcGray"), for: UIControlState.normal)
            category = 2
        } else {
            etcButton.isSelected = !etcButton.isSelected
            cultureButton.setImage(#imageLiteral(resourceName: "cultureGray"), for: UIControlState.normal)
            historyButton.setImage(#imageLiteral(resourceName: "historyGray"), for: UIControlState.normal)
            festButton.setImage(#imageLiteral(resourceName: "festivalGray"), for: UIControlState.normal)
            eatButton.setImage(#imageLiteral(resourceName: "foodGray"), for: UIControlState.normal)
            activityButton.setImage(#imageLiteral(resourceName: "activityGray"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "etcGreen"), for: UIControlState.normal)
            category = 6
        
        }
        
    }
    
    //MARK: dismiss
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: 글 등록 액션
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
        if courseNum >= 2 && imageNum >= 2 && category != 0 && languageTextField.text != "" && titleTextField.text != "" && contentTextView.text != "" && minPeopleTextField.text != "" && maxPeopleTextField.text != "" && dateTextField.text != "" && finishTextField.text != "" {
            
            writeSeoulightCourse()
        } else {
            
            if courseNum == 0 || imageNum == 0 || category == 0 || languageTextField.text == "" || titleTextField.text == "" || contentTextView.text == "" || minPeopleTextField.text == "" || maxPeopleTextField.text == "" || dateTextField.text == "" || finishTextField.text == "" {
                simpleAlert(title: "글 등록 실패", message: "모든 항목을 입력해주세요.")
            }
            
            if courseNum < 2 && imageNum < 2 {
                simpleAlert(title: "글 등록 실패", message: "최소 2개의 코스와 사진을 등록하셔야 합니다.")
            } else {
                if courseNum < 2 {
                    simpleAlert(title: "글 등록 실패", message: "최소 2개의 코스를 등록하셔야 합니다.")
                }
                
                if imageNum < 2 {
                    simpleAlert(title: "글 등록 실패", message: "최소 2개의 사진을 첨부하셔야 합니다.")
                }
            }
        }
    }
    
    //MARK: 서울라이트 글등록 - POST
    func writeSeoulightCourse() {
        
        for i in 0 ... courseNum - 1 {

            let sample : [String: String] = ["category" : "1", "name":  courseArr[i]]
            
            allDic.append(sample)
        }
        
        for i in 1 ... imageNum {
            
            orimageArr.append(imageArr[i])
        }
        
        SeoulightService.writeSeoulightCourse(category: String(category), lang: gsno(languageTextField.text), title: gsno(titleTextField.text), content: contentTextView.text, min_people: gsno(minPeopleTextField.text), max_people: gsno(maxPeopleTextField.text), start_date: gsno(dateTextField.text), due_date: gsno(finishTextField.text), bgi: orimageArr, course: ["course" : allDic]) { (message) in
            
            if message == "success" {
                self.noticeSuccess("등록 성공", autoClear: true, autoClearTime: 1)
                self.dismiss(animated: true, completion: nil)
            } else {
                self.simpleAlert(title: "등록 실패", message: "다시 시도해주세요.")
            }
        }
    }
    
    //MAKR: 코스 카테고리 피커뷰 액션
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
    
    //MARK: 코스 목록 창 유동적으로 보이기
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = super.tableView(tableView, heightForRowAt: indexPath)

        if courseNum == 0 {
            if (indexPath.row == 8) {
                height = 0.0

            }
        }

        return height
    }
    
    //MARK: CollectionView method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == courseCollectionView {
            return courseArr.count
        }
        
        else {
            return imageArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == courseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeoulightAddCourseCollectionViewCell", for: indexPath) as! SeoulightAddCourseCollectionViewCell
            
            cell.nameLabel.text = courseArr[indexPath.row]
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteCourseFromButton(button:)), for: .touchUpInside)
            
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
            cell.deleteButton.addTarget(self, action: #selector(deleteImageFromButton(button:)), for: .touchUpInside)
            
            return cell
            
        }
    }
    
    //MARK: 사진 갯수 제한
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if imageNum < 5 {
                openGallery()
            } else  {
                
                self.simpleAlert(title: "사진 개수 초과", message: "사진은 최대 5장까지 첨부 가능합니다.")
            }
        }
    }
    
    //MARK: 코스 삭제
    @objc func deleteCourseFromButton(button: UIButton) {
        
        courseArr.remove(at: button.tag)
        courseNum -= 1
        courseCollectionView.reloadData()
    }
    
    //MARK: 이미지 삭제
    @objc func deleteImageFromButton(button: UIButton) {
        
        imageArr.remove(at: button.tag)
        imageNum -= 1
        imageCollectionView.reloadData()
    }

}

//MARK: Google Place API extension
extension SeoulightWriteTableViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Get the place name from 'GMSAutocompleteViewController'
        // Then display the name in textField
        courseSearchTextField.text = place.name
        
        courseArr.append(gsno(courseSearchTextField.text))
        courseNum += 1
        
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
    
//    let currentDate: Date = Date()
//    var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
//    calendar.timeZone = TimeZone(identifier: "UTC")!
//    var components: DateComponents = DateComponents()
//    components.calendar = calendar
//    components.year = -18
//    let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
//    components.year = -150
//    let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
//    self.minimumDate = minDate
//    self.maximumDate = maxDate
    
    func initDatePicker1(){
        
        datePicker.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let minDate = Calendar.current.date(byAdding: .day, value: +1, to: Date())
        
        datePicker.minimumDate = minDate
        
        datePicker.date = minDate!
        
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: +1, to: Date())!
        
        setTextfieldView(textField: dateTextField, selector: #selector(selectedDatePicker1), inputView: datePicker)
    }
    
    func initDatePicker2(){
        
        datePicker.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let minDate = Calendar.current.date(byAdding: .day, value: +1, to: Date())
        
        datePicker.minimumDate = minDate

        datePicker.date = minDate!
        
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: +1, to: Date())!
        
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
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateformatter.string(from: datePicker.date)
        
        dateTextField.text = date
        
        view.endEditing(true)
    }
    
    @objc func selectedDatePicker2(){
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateformatter.string(from: datePicker.date)
        
        finishTextField.text = date
        
        view.endEditing(true)
    }
    
}

//MARK: tableVC keyboard setting extension
extension SeoulightWriteTableViewController {

    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        })
    }
}
