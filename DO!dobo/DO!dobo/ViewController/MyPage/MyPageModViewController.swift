//
//  MyPageModViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 20..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class MyPageModViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    //TODO: 일반 회원일때, 보이기
    @IBOutlet weak var seoulightButton: UIButton!
    
    //TODO: 서울라이트일 때, 보이기
    @IBOutlet weak var SeoulightImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn()
        
        //imageView circle
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.layer.frame.width/2
        

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
