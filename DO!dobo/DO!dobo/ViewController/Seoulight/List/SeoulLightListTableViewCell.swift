//
//  SeoulLightListTableViewCell.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 17..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulLightListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minPeopleLabel: UILabel!
    @IBOutlet weak var maxPeopleLabel: UILabel!
    
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        listView.dropShadow(color: #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1), opacity: 3, offSet: CGSize(width: -1, height: 1), radius: 4, scale: true)
        
        listView.layer.cornerRadius = 4
        placeImageView.clipsToBounds = true
        placeImageView.layer.cornerRadius = 4
        
        placeImageView.clipsToBounds = true
        languageImageView.layer.cornerRadius = 4


        if #available(iOS 11.0, *) {
            placeImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            listView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]

        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = listView.frame
            rectShape.position = listView.center
            rectShape.path = UIBezierPath(roundedRect: listView.bounds,    byRoundingCorners: [.bottomLeft , .topLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
            listView.layer.mask = rectShape

            rectShape.bounds = placeImageView.frame
            rectShape.position = placeImageView.center
            rectShape.path = UIBezierPath(roundedRect: placeImageView.bounds,    byRoundingCorners: [.bottomLeft , .topLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
            placeImageView.layer.mask = rectShape
        }
 
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
