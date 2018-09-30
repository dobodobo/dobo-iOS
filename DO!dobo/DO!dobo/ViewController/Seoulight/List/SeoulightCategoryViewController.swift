//
//  SeoulightCategoryViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 21..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulightCategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 전체 카테고리
    @IBAction func allAction(_ sender: UIButton) {
        let seoulightVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulightListViewController") as! SeoulightListViewController
        
        seoulightVC.category = "7"
        
        self.navigationController?.pushViewController(seoulightVC, animated: true)
    }
    
    //MARK: 문화 카테고리
    @IBAction func cultureAction(_ sender: UIButton) {
        let seoulightVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulightListViewController") as! SeoulightListViewController
        
        seoulightVC.category = "1"
        
        self.navigationController?.pushViewController(seoulightVC, animated: true)
    }
    
    //MARK: 액티비티 카테고리
    @IBAction func activityAction(_ sender: UIButton) {
        let seoulightVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulightListViewController") as! SeoulightListViewController
        
        seoulightVC.category = "2"
        
        self.navigationController?.pushViewController(seoulightVC, animated: true)
    }
    
    //MARK: 역사 카테고리
    @IBAction func historyAction(_ sender: UIButton) {
        let seoulightVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulightListViewController") as! SeoulightListViewController
        
        seoulightVC.category = "3"
        
        self.navigationController?.pushViewController(seoulightVC, animated: true)
    }
    
    //MARK: 먹방 카테고리
    @IBAction func eatAction(_ sender: UIButton) {
        let seoulightVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulightListViewController") as! SeoulightListViewController
        
        seoulightVC.category = "4"
        
        self.navigationController?.pushViewController(seoulightVC, animated: true)
    }
    
    //MARK: 축제 카테고리
    @IBAction func fesAction(_ sender: UIButton) {
        let seoulightVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulightListViewController") as! SeoulightListViewController
        
        seoulightVC.category = "5"
        
        self.navigationController?.pushViewController(seoulightVC, animated: true)
    }
    
    //MARK: 기타 카테고리
    @IBAction func etcAction(_ sender: UIButton) {
        let seoulightVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulightListViewController") as! SeoulightListViewController
        
        seoulightVC.category = "6" 
        
        self.navigationController?.pushViewController(seoulightVC, animated: true)
    }
    
    

}
