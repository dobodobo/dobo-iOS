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
    @IBOutlet weak var courseSearchTextField: UITextField!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var datePicker = UIDatePicker()
    

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
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == courseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeoulightAddCourseCollectionViewCell", for: indexPath) as! SeoulightAddCourseCollectionViewCell
            
            cell.nameLabel.text = "서울창조경제혁신센터"
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeoulightAddImageCollectionViewCell", for: indexPath) as! SeoulightAddImageCollectionViewCell
            
            
            return cell
        }
    }

}

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
