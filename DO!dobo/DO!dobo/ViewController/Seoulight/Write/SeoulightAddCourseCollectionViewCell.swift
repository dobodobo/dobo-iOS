//
//  SeoulightAddCourseCollectionViewCell.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 21..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulightAddCourseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backImageView.layer.masksToBounds = true
        backImageView.layer.cornerRadius = 13.5
    }
}
