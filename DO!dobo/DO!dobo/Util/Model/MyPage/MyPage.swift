//
//  MyPage.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 23..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import Foundation

struct MyPage: Codable {
    let email: String
    let nick: String
    let avatar: String?
    let role: String
    let askTourList: [AskTourList]?
    let madeTourList: [MadeTourList]?
}

struct MadeTourList: Codable {
    let title: String
    let content: String
    let image: String?
    let status: String
}

struct AskTourList: Codable {
    let dIdx: Int
    let title: String
    let content: String
    let image: String?
    let status: String
}


