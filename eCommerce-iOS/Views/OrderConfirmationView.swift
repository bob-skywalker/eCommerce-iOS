//
//  OrderConfirmationView.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/12/23.
//

import SwiftUI
import Kingfisher

struct OrderConfirmationView: View {
    @EnvironmentObject var cartItemViewModel: CartItemViewModel
    @State private var showingAlert = true
    @State private var textMessage = "Your order is successful!"
    
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.vertical){
                    ForEach(cartItemViewModel.items) { item in
                        HStack{
                            KFImage(URL(string: item.item.imageUrl))
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 35))
                                .frame(width: 150, height: 150)
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 10){
                                Text(item.item.name)
                                    .font(Font.body.bold())
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                Text("Size: \(item.size)")
                                    .font(Font.body)
                                    .foregroundColor(Color.gray)
                                
                                Text("$\(item.item.price * item.quantity)")
                                    .font(Font.title3.bold())
                                    .foregroundColor(Color.black)
                                
                                Text("Quantity: \(item.quantity)")
                                
                            }
                            .padding()
                        }
                        .padding(.top, 15)
                        .frame(maxWidth: .infinity)
                    }
                    HStack{
                        Spacer()
                        Text("Amount Paid:")
                        Text("$\(cartItemViewModel.totalCost)")
                    }
                    .font(.title2).bold()
                    .padding(.top, 30)
                    .padding(.horizontal, 15)

                }
                
                NavigationLink {
                    ContentView()
                } label: {
                    HStack(alignment: .center, spacing: 20){
                        Text("Continue Shopping")
                            .font(.title2).bold()
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                }

            }
            .alert("Thank You", isPresented: $showingAlert, actions: {
                Button("OK") {}
            }, message: {
                Text(textMessage)
            })
            .navigationTitle("Order Confirmation")
            .onDisappear(perform: emptyCart)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func emptyCart(){
        cartItemViewModel.items = []
    }
}

struct OrderConfirmationView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let cartItemViewModel = CartItemViewModel()
        let dummyItem = Item(id: 1, imageUrl: "https://i.ibb.co/ZYW3VTp/brown-brim.png", name: "Floral T-Shirt", price: 100)
        let dummyItem2 = Item(id: 2, imageUrl: "https://i.ibb.co/ZYW3VTp/brown-brim.png", name: "Floral T-Shirt", price: 20)
        cartItemViewModel.add(item: dummyItem, size: "M")
        cartItemViewModel.add(item: dummyItem2, size: "S")
        
        return OrderConfirmationView().environmentObject(cartItemViewModel)
    }
}
