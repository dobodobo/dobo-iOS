//
//  SeoulListViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 17..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import Kingfisher

class SeoulListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var category: Int = 0
    var seouls: [Seoul] = [Seoul]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pop swipe
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        seoulInit(category: category)
        
    //self.navigationController?.navigationBar.setBottomBorderColor(color: #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1), height: 0.5)
        
        //TableView
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        seoulInit(category: category)
    }
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seouls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeoulListTableViewCell") as! SeoulListTableViewCell
        
        cell.placeImageView.kf.setImage(with: URL(string: gsno(seouls[indexPath.row].image)), placeholder: UIImage())
        cell.titleLabel.text = seouls[indexPath.row].title
        cell.introTextView.text = seouls[indexPath.row].intro
        
        return cell
    }
    
    //TODO: 다음 뷰 인텐트로 넘기기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let datailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            "SeoulDetailViewController") as! SeoulDetailViewController
        datailVC.idx = seouls[indexPath.row].idx
        self.navigationController?.pushViewController(datailVC, animated: true)
    }
    
    
    //MARK: 서울 리스트 조회 - GET
    func seoulInit(category: Int) {
        SeoulService.SeoulListInit(category: category) { (seoulData) in
            
            self.seouls = seoulData
            self.tableView.reloadData()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UINavigationBar {
    
    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
}
