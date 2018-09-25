//
//  Seoulight.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 25..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation

struct Seoulight: Codable {
    let idx: Int
    let min_people: Int
    let max_people: Int
    let title: String
    let content: String
    let category: String
    let due_date: String
    let status: String
    let image: String?
    let lang: String?
    let count: Int
}
