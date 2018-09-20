//
//  IntroSeoulViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 18..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class IntroSeoulViewController: UIViewController {

    @IBOutlet weak var timeTextView: UITextView!
    @IBOutlet weak var peopleTextView: UITextView!
    @IBOutlet weak var moneyTextView: UITextView!
    @IBOutlet weak var reservationTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        //navigation bar background image
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"combinedShapeCopy"),for: .default)
        
        timeTextView.text =
        """
        평일:10시, 14시 / 주말:10시, 14시, 15시
        * 자세한 휴관일 및 운영 시간은 각 코스별 상세보기를 참고해주세요.
        """
        
        peopleTextView.text =
        """
        개인 - 1인 ~ 10인
        단체 - 21인 이상 (경복궁, 창덕궁, 성균관 코스)
              11인 이상 (그 외 코스)
        """
    
        moneyTextView.text =
        """
        무료
        * 궁궐 입장료 및 문화 체험료, 교통비 등은 개인 부담입니다.
        """
        
        reservationTextView.text =
        """
        개인 - 관광일 기준 3일 전
        단체 - 관광일 기준 5일 전
        """

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: dismiss
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
