//
//  SeoulightDetail.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 25..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation

struct SeoulightDetail: Codable {
    let dobo: Dobo

}

struct Dobo: Codable {
    let idx: Int
    let title: String
    let content: String
    let min_people: Int
    let max_people: Int
    let category: String
    let lang: String?
    let start_date: String
    let end_date: String
    let due_date: String
    let status: String
    let seoulite: Seoulite
    let bgi: [String]
    let tourlist: [DetailTourList]
    let course: [Course]
}

struct Seoulite: Codable {
    let seoulite_idx: Int
    let user_idx: Int
    let name: String
    let avatar: String?
    let email: String
    let intro: String
}

struct DetailTourList: Codable {
    let name: String
    let image: String
}

struct Course: Codable {
    let name: String
    let category: String
}



