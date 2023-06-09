//
//  CheckoutView.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import SwiftUI
import Kingfisher

struct CheckoutView: View {
    @EnvironmentObject var cartItemViewModel: CartItemViewModel
    
    let quantities = Array(1...10)
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ForEach(cartItemViewModel.items, id: \.item.id) { item in
                    HStack{
                        KFImage(URL(string: item.item.imageUrl))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 10){
                            Text(item.item.name)
                                .font(Font.title2)
                            Text("Size: \(item.size)")
                                .font(Font.callout)
                            Text("$\(item.item.price)")
                                .font(Font.title3)
                           
                            Button {
                                withAnimation {
                                    cartItemViewModel.remove(item: item.item, size: item.size)
                                }
                            } label: {
                                Text("Remove Item")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 15)
                                    .background(.red)
                                    .cornerRadius(15)
                            }

                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Checkout")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let cartItemViewModel = CartItemViewModel()
        let dummyItem = Item(id: 1, imageUrl: "https://i.ibb.co/ZYW3VTp/brown-brim.png", name: "Floral T-Shirt", price: 100)
        let dummyItem2 = Item(id: 2, imageUrl: "https://i.ibb.co/ZYW3VTp/brown-brim.png", name: "Floral T-Shirt", price: 20)
        cartItemViewModel.add(item: dummyItem, size: "M")
        cartItemViewModel.add(item: dummyItem2, size: "S")
        return CheckoutView().environmentObject(cartItemViewModel)
    }
}
