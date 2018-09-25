//
//  SeoulDetail.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 25..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation

struct SeoulDetail: Codable {
    let idx: Int
    let title: String
    let intro: String
    let content: String
    let image: String
    let course: String
    let bgi: String
    let tourlist: String
    let review: [SeoulReview]
}


