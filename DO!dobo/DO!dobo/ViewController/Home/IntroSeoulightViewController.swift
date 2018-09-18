//
//  IntroSeoulightViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 18..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class IntroSeoulightViewController: UIViewController {
    
    
    @IBOutlet weak var howTextView: UITextView!
    @IBOutlet weak var courseTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation bar background image
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"combinedShapeCopy"),for: .default)
        
        
        howTextView.text =
        """
        마이 페이지 > Seoulight 신청에서 양식에 맞게 작성하여 신청 가능합니다.
        관리자 심사 후, 신청 승인을 받은 후에 Seoulight가 되어
        코스 등록을 할 수 있습니다.
        * 단체 신청 시에는 대표자 기준으로 작성해주시면 됩니다.
        * 포트폴리오에는 자신의 소개와 경력, 어학 자격증 등
          자신이 Seoulight에 적합한 사람임을 보여주시면 됩니다.
        """
        
        courseTextView.text =
        """
        - 주제는 대한민국을 소개할 수 있는 분야 모두 가능합니다.
        - 도보 관광 코스는 1일 코스로 제한하며, 제한 시간은 없습니다.
        - 안내 언어는 한국어를 비롯한 모든 언어로 해설 가능하며,
          코스 등록 시에 해설 언어를 설정해주시면 됩니다.
        - 모집 인원 마감 및 신청 날짜 마감 시, 자동으로 예약이 마감됩니다.
        - 최소 인원이 충족되지 않을 시에는 코스가 취소됩니다.
        """

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
