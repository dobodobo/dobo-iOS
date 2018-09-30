//
//  MainViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 16..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var doboImageView: UIImageView!
    @IBOutlet weak var doboNameTextView: UITextView!
    
    @IBOutlet weak var seoulightImageView: UIImageView!
    @IBOutlet weak var seoulightNameTextView: UITextView!
    @IBOutlet weak var seoulightDateLabel: UILabel!
    @IBOutlet weak var seoulightminPeopleLabel: UILabel!
    @IBOutlet weak var seoulightmaxPeopleLabel: UILabel!
    
    var doboIdx = 5
    var seoulightIdx = 1
    
    override func viewWillAppear(_ animated: Bool) {
        //네비게이션바 복구
        self.navigationController!.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doboInit(idx: doboIdx)
        //TODO: 서울라이트 대표글 정하기
        seoulightInit(idx: seoulightIdx)
        
        doboNameTextView.text =
        """
        서울로
        근·현대 건축기행
        """
        
        seoulightNameTextView.text =
        """
        양재 시민의 숲
        - 꽃 시장 탐방 코스
        """
        
        //imageView shadow
        
        doboImageView.dropShadow(color: #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), opacity: 5, offSet: CGSize(width: -3, height: 10), radius: 5, scale: true)
        seoulightImageView.dropShadow(color: #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1), opacity: 5, offSet: CGSize(width: -3, height: 10), radius: 5, scale: true)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: 오늘의 도보 - GET
    func doboInit(idx: Int) {
        SeoulService.seoulDetailInit(idx: idx) { (seoulDetailData) in
        
            self.doboImageView.kf.setImage(with: URL(string: (seoulDetailData.dobo.image)), placeholder: UIImage())
        }
    }
    
    //MARK: 오늘의 도보 with 서울라이트 - GET
    func seoulightInit(idx: Int) {
        SeoulightService.seoulightDetailInit(idx: idx) { (seoulightDetailData) in
            
            self.seoulightImageView.kf.setImage(with: URL(string: seoulightDetailData.dobo.bgi[0]), placeholder: UIImage())
            self.seoulightDateLabel.text = seoulightDetailData.dobo.due_date
            self.seoulightminPeopleLabel.text = String(seoulightDetailData.dobo.min_people)
            self.seoulightmaxPeopleLabel.text = String(seoulightDetailData.dobo.max_people)
        }
    }
    
    //MARK: 해당 도보 상세페이지로 이동
    @IBAction func doboDatailAction(_ sender: UITapGestureRecognizer) {
        let datailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            "SeoulDetailViewController") as! SeoulDetailViewController
        datailVC.idx = doboIdx
        self.navigationController?.pushViewController(datailVC, animated: true)
    }
    
    //MARK: 해당 서울라이트 상세페이지로 이동
    @IBAction func seoulightAction(_ sender: UITapGestureRecognizer) {
        let datailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:
            "SeoulightDetailViewController") as! SeoulightDetailViewController
        datailVC.idx = seoulightIdx
        self.navigationController?.pushViewController(datailVC, animated: true)
        
    }
    
    //MARK: 서울도보관광 소개 페이지로 이동
    @IBAction func doboIntroAction(_ sender: UIButton) {
        let doboIntroNaviVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroSeoulNaviVC")
        
        self.present(doboIntroNaviVC, animated: true, completion: nil)
    }
    
    @IBAction func seoulightIntroAction(_ sender: UIButton) {
        let seoulightIntroNaviVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroSeoulightNaviVC")
        
        self.present(seoulightIntroNaviVC, animated: true, completion: nil)
    }
    
    //MARK: 서울라이트 소개 페이지로 이동
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

