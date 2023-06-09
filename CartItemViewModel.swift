//
//  CartItemViewModel.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import Foundation

class CartItemViewModel: ObservableObject {
    @Published var items = [CartItem]()
    
    func add(item: Item) {
        if let index = items.firstIndex(where: { $0.item.id == item.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(item: item, quantity: 1))
        }
    }
    
    func remove(item: Item){
        if let index = items.firstIndex(where: { $0.item.id == item.id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
        }
    }
    
    var totalCost: Int {
        return items.reduce(0) { $0 + $1.item.price * $1.quantity}
    }
}
