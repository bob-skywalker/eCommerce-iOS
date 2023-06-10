//
//  CartItemViewModel.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import Foundation

class CartItemViewModel: ObservableObject {
    @Published var items = [CartItem]()
    
    func add(item: Item, size: String) {
        if let index = items.firstIndex(where: { $0.item.id == item.id && $0.size == size}) {
            items[index].quantity += 1
        } else {
            items.insert(CartItem(item: item, quantity: 1, size: size), at: 0)
        }
    }
    
    func remove(item: Item, size: String ){
        if let index = items.firstIndex(where: { $0.item.id == item.id && $0.size == size}) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
        }
    }
    
    func updateQuantity(for itemId: UUID, size: String, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == itemId && $0.size == size}) {
            items[index].quantity = quantity
        }
    }
    
    func setQuantity(for itemId: UUID, to newQuantity: Int){
        if let index = items.firstIndex(where: {$0.id == itemId}) {
            if newQuantity == 0 {
                items.remove(at: index)
            } else {
                items[index].quantity = newQuantity
            }
        }
    }
    
    var totalCost: Int {
        return items.reduce(0) { $0 + $1.item.price * $1.quantity}
    }
}
