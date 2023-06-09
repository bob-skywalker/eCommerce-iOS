//
//  CartItem.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import Foundation

struct CartItem: Identifiable {
    var id = UUID()
    let item: Item
    var quantity: Int
    var size: String 
}
