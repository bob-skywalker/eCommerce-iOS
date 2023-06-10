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
    @State private var showingApplePay = false
    @State private var animate = false
    
    let quantities = Array(1...10)
    
    var body: some View {
        NavigationView {
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
                                
                                
                                Stepper("", onIncrement: {
                                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                                    impactMed.impactOccurred()
                                    
                                    cartItemViewModel.setQuantity(for: item.id, to: item.quantity + 1)
                                }, onDecrement: {
                                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                                    impactMed.impactOccurred()
                                    cartItemViewModel.setQuantity(for: item.id, to: item.quantity - 1)})
                                .foregroundColor(.white)
                                .cornerRadius(15)
                                
                                
                                
                                
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                NavigationLink {
                    ApplePayView()
                } label: {
                    HStack(alignment: .center, spacing: 20){
                        Text("Tap To Pay: ").font(.title).foregroundColor(.white)
                        Text("$\(cartItemViewModel.totalCost)").bold().font(.title).foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(animate ? LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: true), value: animate)
                    .onAppear {
                        self.animate = true
                    }
                }
                
            }
            
            //            .navigationTitle("Checkout")
        }
        //        .navigationBarBackButtonHidden(true)
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
