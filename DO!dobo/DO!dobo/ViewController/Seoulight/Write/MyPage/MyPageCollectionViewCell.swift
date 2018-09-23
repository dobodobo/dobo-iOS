//
//  MyPageCollectionViewCell.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 20..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class MyPageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var placeView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //imageView shadow
        placeView.dropShadow(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), opacity: 3, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
//        placeImageView.layer.shadowColor = UIColor.purple.cgColor
//        placeImageView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        placeImageView.layer.shadowOpacity = 1
//        placeImageView.layer.shadowRadius = 1.0
//       placeImageView.clipsToBounds = false
        
        //imageView circle
        placeImageView.layer.masksToBounds = true
        placeImageView.layer.cornerRadius = 8
    }
    
}
