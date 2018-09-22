//
//  MyPageViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 20..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import Kingfisher

class MyPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    //TODO: 해설사일 때만 보이기
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var seoulightImageView: UIImageView!
    
    @IBOutlet weak var reportView: UIView!
    
    var rowCnt: Int?
    
    var role = UserDefaults.standard.string(forKey: "role")
    
    var myPage: MyPage?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        myPageInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //server
        myPageInit()
        print(role ?? "")
        
        //tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        //profile image circle
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.layer.frame.width/2
        
        //view border
        reportView.layer.addBorder(edge: .top, color: #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1), thickness: 1)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableView method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if role == "SEOULITE" {
            return 2
        } else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath ) as! MyPageTableViewCell

            cell.listNameLabel.text = "신청 리스트"
            cell.collectionView.reloadData()
            cell.tag = 0


            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath ) as! MyPageTableViewCell
            
            cell.listNameLabel.text = "개설 리스트"
            cell.collectionView.reloadData()
            cell.tag = 1
        
            return cell
        }
    }
    
    //MARK: 시민해설사 신청하기
    @IBAction func applyAction(_ sender: UIButton) {
        let applyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulightApplyViewController") as! SeoulightApplyViewController
        
        self.navigationController?.pushViewController(applyVC, animated: true)
    }
    
    //MARK: 마이페이지 조회 - GET
    func myPageInit() {
        MyPageService.myPageInit{ (myPage) in
            
            self.nameLabel.text = myPage.nick
            self.emailLabel.text = myPage.email
            self.role = myPage.role
            self.profileImageView.kf.setImage(with: URL(string: self.gsno(myPage.avatar)), placeholder: UIImage())
            self.isRole()

        }
    }
    
    //MARK: 서울라이트/회원 판단 함수
    func isRole() {
        
        if role == "SEOULITE" {
            seoulightImageView.isHidden = false
            applyButton.isHidden = true
        } else {
            seoulightImageView.isHidden = true
            applyButton.isHidden = false
        }
    }
    

}

//view border 관련 extension
extension CALayer {
    
        func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
            
            let border = CALayer();
            
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect(x:0, y:self.frame.height - thickness, width:self.frame.width, height:thickness)
                break
            case UIRectEdge.left:
                border.frame = CGRect(x:0, y:0, width: thickness, height: self.frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect(x:self.frame.width - thickness, y: 0, width: thickness, height:self.frame.height)
                break
            default:
                break
            }
            
            border.backgroundColor = color.cgColor;
            
            self.addSublayer(border)
    }
}

