//
//  SeoulDetail.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 25..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation

struct SeoulDetail: Codable {
    
    let dobo: SeoulDobo
    let review: [SeoulReview]?
}

struct SeoulDobo: Codable {
    let idx: Int
    let title: String
    let intro: String
    let content: String
    let image: String
    let course: [Course]?
    let bgi: String?
    let tourlist: [SeoulTourList]
}

struct SeoulTourList: Codable {
    let name: String
    let image: String
}




