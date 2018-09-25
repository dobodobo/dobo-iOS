//
//  SeoulightDetailData.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 25..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation

struct SeoulightDetailData: Codable {
    let status: Int
    let message: String
    let result: Seoulight
    let review: [SeoulightReview]
}
