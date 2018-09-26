//
//  SeoulightDetailReviewTableViewCell.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 17..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulightDetailReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    @IBOutlet weak var reportButton: UIButton!
    
     var actionClosure : (()->Void)? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        reviewView.dropShadow(color: #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: 댓글 신고 기능
    @IBAction func reportAction(_ sender: UIButton) {
        self.actionClosure?()
    }
    

}

extension UIView {
    //MARK: UIView shadow
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


