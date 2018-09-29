//
//  SeoulightListViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 16..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulightListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tabelView: UITableView!
    
    var category: String = "0"
    var seoulights: [Seoulight] = [Seoulight]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn()
        
        seoulightInit(category: category)
        
        //pop swipe
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        //TableView
        tabelView.delegate = self
        tabelView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //네비게이션바 복구
        self.navigationController!.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.backgroundColor = UIColor.clear
    }
    
    @IBAction func AddCourseAction(_ sender: UIBarButtonItem) {
        let role = gsno(UserDefaults.standard.string(forKey: "role"))
        
        if role != "SEOULITE" {
            simpleAlert(title: "권한 없음", message:
                """
                서울라이트가 되어야 글 등록이 가능합니다.
                마이페이지에서 신청 가능합니다.
                """)
        } else {
            let addVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulightWriteTableViewController") as! SeoulightWriteTableViewController
            
            self.navigationController?.pushViewController(addVC, animated: true)
        }
    }
    
    
    //MARK: 인기순 액션
    @IBAction func hitAction(_ sender: UIButton) {
        hitSeoulightInit(category: category)
    }
    
    //MARK: 마감순 액션
    @IBAction func dueAction(_ sender: UIButton) {
        dueSeoulightInit(category: category)
    }
    
    //MARK: 서울라이트 리스트 조회 - GET
    func seoulightInit(category: String) {
        
        SeoulightService.SeoulightInit(category: category) { (seoulightData) in
            self.seoulights = seoulightData
            self.tabelView.reloadData()
        }
    }
    
    //MARK: 서울라이트 인기순 조회 - GET
    func hitSeoulightInit(category: String) {
        
        SeoulightService.SeoulightInitHit(category: category) { (seoulightData) in
            self.seoulights = seoulightData
            self.tabelView.reloadData()
        }
    }
    
    //MARK: 서울라이트 마감순 조회 - GET
    func dueSeoulightInit(category: String) {
        
        SeoulightService.SeoulightInitDue(category: category) { (seoulightData) in
            self.seoulights = seoulightData
            self.tabelView.reloadData()
        }
    }
    
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seoulights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeoulLightListTableViewCell") as! SeoulLightListTableViewCell
        
        cell.placeImageView.kf.setImage(with: URL(string: gsno(seoulights[indexPath.row].image)), placeholder: UIImage())
        cell.titleLabel.text = seoulights[indexPath.row].title
        cell.dateLabel.text = seoulights[indexPath.row].due_date
        cell.minPeopleLabel.text = String(seoulights[indexPath.row].min_people)
        cell.maxPeopleLabel.text = String(seoulights[indexPath.row].max_people)
        cell.languageLabel.text = seoulights[indexPath.row].lang
        
        return cell
    }
    
    //TODO: 다음 뷰 인텐트로 넘기기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let datailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            "SeoulightDetailViewController") as! SeoulightDetailViewController
        datailVC.idx = seoulights[indexPath.row].idx
        print(seoulights[indexPath.row].idx)
        self.navigationController?.pushViewController(datailVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
