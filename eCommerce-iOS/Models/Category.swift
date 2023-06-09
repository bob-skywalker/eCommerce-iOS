//
//  Category.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import Foundation

struct Category: Codable{
    let name: String
    var items: [Item]
}

struct Item: Identifiable, Codable{
    let id: Int
    let imageUrl: String
    let name: String
    let price: Int
}
