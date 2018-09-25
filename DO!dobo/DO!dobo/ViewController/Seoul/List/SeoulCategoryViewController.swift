//
//  SeoulCategoryViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 23..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulCategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 전체
    @IBAction func allAction(_ sender: UIButton) {
        let seoulVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulListViewController") as! SeoulListViewController
        
        seoulVC.category = 7
        
        self.navigationController?.pushViewController(seoulVC, animated: true)
    }
    
    //MARK: 시청각 장애인
    @IBAction func handiAction(_ sender: UIButton) {
        let seoulVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulListViewController") as! SeoulListViewController
        
        seoulVC.category = 5
        
        self.navigationController?.pushViewController(seoulVC, animated: true)
    }
  
    //MARK: 서울 시청사
    @IBAction func cityHallAction(_ sender: UIButton) {
        let seoulVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulListViewController") as! SeoulListViewController
        
        seoulVC.category = 3
        
        self.navigationController?.pushViewController(seoulVC, animated: true)
    }
    
    //MARK: 청계천
    @IBAction func riverAction(_ sender: UIButton) {
        let seoulVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulListViewController") as! SeoulListViewController
        
        seoulVC.category = 2
        
        self.navigationController?.pushViewController(seoulVC, animated: true)
    }
    
    //MARK: 서울로 7017
    @IBAction func seoulloAction(_ sender: UIButton) {
        let seoulVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulListViewController") as! SeoulListViewController
        
        seoulVC.category = 0
        
        self.navigationController?.pushViewController(seoulVC, animated: true)
    }
    
    //MARK: 유적지
    @IBAction func historyAction(_ sender: UIButton) {
        let seoulVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulListViewController") as! SeoulListViewController
        
        seoulVC.category = 4
        
        self.navigationController?.pushViewController(seoulVC, animated: true)
    }
    
    //MARK: 순례길
    @IBAction func wayAction(_ sender: UIButton) {
        let seoulVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulListViewController") as! SeoulListViewController
        
        seoulVC.category = 1
        
        self.navigationController?.pushViewController(seoulVC, animated: true)
    }
    
    //MARK: 기타
    @IBAction func etcAction(_ sender: UIButton) {
        let seoulVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulListViewController") as! SeoulListViewController
        
        seoulVC.category = 6
        
        self.navigationController?.pushViewController(seoulVC, animated: true)
    }
    
    
    
}
