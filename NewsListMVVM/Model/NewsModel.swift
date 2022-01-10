//
//  NewsModel.swift
//  NewsListMVVM
//
//  Created by shree on 10/01/22.
//

import Foundation
struct News: Codable{
    let title: String?
    let description: String?
}

struct NewsModel: Codable {
    let articles: [News]
}
