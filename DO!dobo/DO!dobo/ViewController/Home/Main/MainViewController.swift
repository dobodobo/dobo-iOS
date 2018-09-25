//
//  MainViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 16..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var doboImageView: UIImageView!
    @IBOutlet weak var doboNameTextView: UITextView!
    
    @IBOutlet weak var seoulightImageView: UIImageView!
    @IBOutlet weak var seoulightNameTextView: UITextView!
    @IBOutlet weak var seoulightDateLabel: UILabel!
    @IBOutlet weak var seoulightminPeopleLabel: UILabel!
    @IBOutlet weak var seoulightmaxPeopleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doboNameTextView.text =
        """
        여의나루
        밤도깨비시장
        """
        
        seoulightNameTextView.text =
        """
        양재 시민의 숲
        꽃 시장 탐방 코스
        """
        
        //imageView shadow
        
        doboImageView.dropShadow(color: #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), opacity: 5, offSet: CGSize(width: -3, height: 10), radius: 5, scale: true)
        seoulightImageView.dropShadow(color: #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1), opacity: 5, offSet: CGSize(width: -3, height: 10), radius: 5, scale: true)
        
        // Do any additional setup after loading the view, typically from a nib.
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

