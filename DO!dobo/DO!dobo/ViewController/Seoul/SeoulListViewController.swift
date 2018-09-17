//
//  SeoulListViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 17..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeoulListTableViewCell") as! SeoulListTableViewCell
        
        cell.placeImageView.image = #imageLiteral(resourceName: "rectangle5.png")
        cell.titleLabel.text = "수원 화성"
        cell.introTextView.text = "화성의 경치와 역사를 함께 느꺄보세요."
        cell.dateLabel.text = "2019.10.01"
        cell.peopleLabel.text = "3~6명"
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
