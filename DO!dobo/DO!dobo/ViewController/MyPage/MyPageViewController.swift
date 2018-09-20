//
//  MyPageViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 20..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    //TODO: 해설사일 때만 보이기
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var reportView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.layer.frame.width/2
        
        reportView.layer.addBorder(edge: .top, color: #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1), thickness: 1)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TODO: 회원이면 리턴 1, 시민해설사면 리턴 2
    //MARK: TableView method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath ) as! MyPageTableViewCell
        
        cell.listNameLabel.text = "신청리스트"
        cell.collectionView.reloadData()
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = .zero
        cell.layoutMargins = .zero
        
        return cell
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

