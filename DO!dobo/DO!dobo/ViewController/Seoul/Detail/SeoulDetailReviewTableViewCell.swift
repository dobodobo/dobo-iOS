//
//  SeoulDetailReviewTableViewCell.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 17..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulDetailReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
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

    //MARK: 댓글 신고하기 기능
    @IBAction func reportAction(_ sender: UIButton) {
         self.actionClosure?()
    }
}
