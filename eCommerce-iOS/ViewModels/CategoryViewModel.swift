//
//  CategoryViewModel.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import Foundation
import SwiftUI
import Firebase

class CategoryViewModel: ObservableObject {
    @Published var categories = [Category]()
    let db = Firestore.firestore()

    func fetchCategories(){
        let categories = ["hats", "jackets", "mens", "sneakers", "womens"]
        
        var categoryStructs: [Category] = []
        
        for categoryName in categories {
            db.collection("categories").document(categoryName).getDocument { (document, error) in
                if let document = document, document.exists {
                    var items: [Item] = []
                    
                    if let itemDataArray = document.data()?["items"] as? [[String: Any]]{
                        for itemData in itemDataArray {
                            if let id = itemData["id"] as? Int,
                               let imageUrl = itemData["imageUrl"] as? String,
                               let name = itemData["name"] as? String,
                               let price = itemData["price"] as? Int {
                                let item = Item(id: id, imageUrl: imageUrl, name: name, price: price)
                                items.append(item)
                            }
                        }
                    }
                    
                    let category = Category(name: categoryName, items: items)
                    DispatchQueue.main.async {
                        self.categories.append(category)
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
}
