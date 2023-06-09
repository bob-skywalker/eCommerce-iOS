//
//  Items.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import Foundation


struct Items: Codable{
    struct Item: Codable, Identifiable {
        
    }
    
    let name: String
    var items: [Item]
    
    
    
    
}
