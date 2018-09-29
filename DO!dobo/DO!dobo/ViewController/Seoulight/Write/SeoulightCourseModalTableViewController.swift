//
//  SeoulightCourseModalTableViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 29..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import GooglePlaces

class SeoulightCourseModalTableViewController: UITableViewController {

    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var seeButton: UIButton!
    @IBOutlet weak var culButton: UIButton!
    @IBOutlet weak var actButton: UIButton!
    @IBOutlet weak var busButton: UIButton!
    @IBOutlet weak var etcButton: UIButton!
    var category: String = ""
    var courseCategoryNum: Int = 0
    
    @IBOutlet weak var courseSearchTextField: UITextField!
    var course: String = ""
    var courseNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func categoryAction(_ sender: UIButton) {
        
        if sender == foodButton {
            foodButton .isSelected = !foodButton.isSelected
            foodButton .setImage(#imageLiteral(resourceName: "addCourseFoodGreen"), for: UIControlState.normal)
            seeButton.setImage(#imageLiteral(resourceName: "addCourseSightseeing"), for: UIControlState.normal)
            actButton.setImage(#imageLiteral(resourceName: "addCourseActivity"), for: UIControlState.normal)
            culButton.setImage(#imageLiteral(resourceName: "addCourseCulture"), for: UIControlState.normal)
            busButton.setImage(#imageLiteral(resourceName: "addCourseBus"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "addCourseEtc"), for: UIControlState.normal)
            category = "0"
        } else if sender == seeButton {
            seeButton .isSelected = !seeButton.isSelected
            seeButton.setImage(#imageLiteral(resourceName: "addCourseSightseeingGreen"), for: UIControlState.normal)
            foodButton.setImage(#imageLiteral(resourceName: "addCourseFood"), for: UIControlState.normal)
            actButton.setImage(#imageLiteral(resourceName: "addCourseActivity"), for: UIControlState.normal)
            culButton.setImage(#imageLiteral(resourceName: "addCourseCulture"), for: UIControlState.normal)
            busButton.setImage(#imageLiteral(resourceName: "addCourseBus"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "addCourseEtc"), for: UIControlState.normal)
            category = "1"
        } else if sender == actButton {
            actButton.isSelected = !actButton.isSelected
            actButton.setImage(#imageLiteral(resourceName: "addCourseActivityGreen"), for: UIControlState.normal)
            seeButton.setImage(#imageLiteral(resourceName: "addCourseSightseeing"), for: UIControlState.normal)
            foodButton.setImage(#imageLiteral(resourceName: "addCourseFood"), for: UIControlState.normal)
            culButton.setImage(#imageLiteral(resourceName: "addCourseCulture"), for: UIControlState.normal)
            busButton.setImage(#imageLiteral(resourceName: "addCourseBus"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "addCourseEtc"), for: UIControlState.normal)
            category = "2"
        } else if sender == culButton {
            culButton.isSelected = !culButton.isSelected
            culButton.setImage(#imageLiteral(resourceName: "addCourseCultureGreen"), for: UIControlState.normal)
            seeButton.setImage(#imageLiteral(resourceName: "addCourseSightseeing"), for: UIControlState.normal)
            actButton.setImage(#imageLiteral(resourceName: "addCourseActivity"), for: UIControlState.normal)
            foodButton.setImage(#imageLiteral(resourceName: "addCourseFood"), for: UIControlState.normal)
            busButton.setImage(#imageLiteral(resourceName: "addCourseBus"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "addCourseEtc"), for: UIControlState.normal)
            category = "3"
        } else if sender == busButton {
            busButton.isSelected = !busButton.isSelected
            busButton.setImage(#imageLiteral(resourceName: "addCourseBusGreen"), for: UIControlState.normal)
            seeButton.setImage(#imageLiteral(resourceName: "addCourseSightseeing"), for: UIControlState.normal)
            actButton.setImage(#imageLiteral(resourceName: "addCourseActivity"), for: UIControlState.normal)
            culButton.setImage(#imageLiteral(resourceName: "addCourseCulture"), for: UIControlState.normal)
            foodButton.setImage(#imageLiteral(resourceName: "addCourseFood"), for: UIControlState.normal)
            etcButton.setImage(#imageLiteral(resourceName: "addCourseEtc"), for: UIControlState.normal)
            category = "4"
        } else {
            etcButton.isSelected = !etcButton.isSelected
            etcButton.setImage(#imageLiteral(resourceName: "addCourseEtcGreen"), for: UIControlState.normal)
            seeButton.setImage(#imageLiteral(resourceName: "addCourseSightseeing"), for: UIControlState.normal)
            actButton.setImage(#imageLiteral(resourceName: "addCourseActivity"), for: UIControlState.normal)
            culButton.setImage(#imageLiteral(resourceName: "addCourseCulture"), for: UIControlState.normal)
            busButton.setImage(#imageLiteral(resourceName: "addCourseBus"), for: UIControlState.normal)
            foodButton.setImage(#imageLiteral(resourceName: "addCourseFood"), for: UIControlState.normal)
            category = "5"
            
        }
    }
    
    //MARK: 코스 검색 액션
    @IBAction func courseSearchAction(_ sender: UITextField) {
            courseSearchTextField.resignFirstResponder()
            let acController = GMSAutocompleteViewController()
            acController.delegate = self
            present(acController, animated: true, completion: nil)
    }
    
    //MARK: 코스 추가 액션
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        
        if category == "" || course == "" {
            simpleAlert(title: "추가 실패", message: "모든 항목을 입력해주세요.")
        } else {
            NotificationCenter.default.post(name: Notification.Name("addCourse"), object: course)
            NotificationCenter.default.post(name: Notification.Name("addCategory"), object: category)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
}

//MARK: Google Place API extension
extension SeoulightCourseModalTableViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Get the place name from 'GMSAutocompleteViewController'
        // Then display the name in textField
        courseSearchTextField.text = place.name
        
        course = gsno(courseSearchTextField.text)
        
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

