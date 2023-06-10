//
//  ItemView.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import SwiftUI
import Kingfisher


struct ItemView: View {
    @EnvironmentObject var cartItemViewModel: CartItemViewModel
    @EnvironmentObject var categoryViewModel : CategoryViewModel
    
    @Environment(\.dismiss) var dismiss
    @State private var showingLearnMore = false
    @State private var randomItems: [Item] = []{
        didSet{
            randomItems.forEach { item in
                print("Random Item: \(item)")
            }
        }
    }
    
    var item: Item
    let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var divideByFoudPrice: Double{
        Double(item.price) / Double(4)
    }
    
    @State private var selectedSize: String = "S"
    
    let sizes = ["S", "M", "L", "XL", "XXL", "3XL"]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView{
                VStack(alignment: .center){
                    VStack(alignment: .center, spacing: 12){
                        Text("Sustainable Materials")
                            .foregroundColor(.orange).bold()
                        Text("$\(item.price)")
                            .foregroundColor(Color.gray)
                    }
                    .padding()
                    
                    
                    KFImage(URL(string: item.imageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    VStack(spacing: 23){
                        HStack{
                            Text("Select Size")
                            Spacer()
                            NavigationLink {
                                SizeGuideView()
                            } label: {
                                Text("Size Guide")
                                    .foregroundColor(.blue).bold()
                                
                            }
                            
                        }
                        .padding()
                        
                        LazyVGrid(columns: columns) {
                            ForEach(sizes, id: \.self) { size in
                                Button {
                                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                                    impactMed.impactOccurred()
                                    self.selectedSize = size
                                } label: {
                                    Text(size)
                                        .bold()
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                }
                                .padding()
                                .background(selectedSize == size ? Color.blue : Color.white)
                                .foregroundColor(selectedSize == size ? .white : .black)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedSize == size ? .blue: .gray)
                                )
                                
                                
                            }
                        }
                        HStack{
                            Text("4 interest-free payments of $\(String(format: "%.2f", divideByFoudPrice)) with ") +
                            Text("Klama ").bold() +
                            Text("Learn More").underline().foregroundColor(.blue)
                        }
                        .onTapGesture{
                            showingLearnMore = true
                        }
                        
                        
                        Button {
                            cartItemViewModel.add(item: item, size: selectedSize)
                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                            impactMed.impactOccurred()
                        } label: {
                            HStack{
                                Image(systemName: "cart.fill")
                                Text("Add to Cart")
                                    .bold()
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        .padding()
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        
                        
                        Text(text)
                    }
                    .padding()
                    
                    
                }
                VStack(alignment: .center){
                    
                    Text("Explore More")
                        .font(Font.title3).bold()
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.brown)
                }
                .padding()

                
                ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(randomItems) { item in
                                NavigationLink {
                                    ItemView(item: item)
                                        .environmentObject(cartItemViewModel)
                                        .environmentObject(categoryViewModel)
                                } label: {
                                    KFImage(URL(string: item.imageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 105, height: 105)
                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(lineWidth: 1)
                                        )
                                }

                            }
                        }
                    .padding()
                }
                .sheet(isPresented: $showingLearnMore, content: {
                    VStack{
                        Image("klama")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                    }
                })
                .navigationTitle(item.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: CheckoutView()) {
                            Image(systemName: "cart.fill")
                                .foregroundColor(Color.brown)
                                .overlay(
                                    Group {
                                        if !cartItemViewModel.items.isEmpty {
                                            ZStack {
                                                Circle()
                                                    .fill(Color.red)
                                                    .frame(width: 20, height: 20)
                                                    .offset(x:10, y:-10)
                                                
                                                Text("\(cartItemViewModel.items.reduce(0) { $0 + $1.quantity })")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 12))
                                                    .offset(x:10, y:-10)
                                            }
                                        }
                                    }
                                    
                                )
                            
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.backward")
                        }
                        
                        
                    }
                }
                
                .onAppear(perform: {
                    randomItems = categoryViewModel.getRandomItems()
                })
                .navigationBarBackButtonHidden(true)
                .navigationViewStyle(StackNavigationViewStyle())
                
            }
        }
    }
    
    struct ItemView_Previews: PreviewProvider {
        
        static var previews: some View {
            ItemView(item: Item(id: 1, imageUrl: "https://i.ibb.co/ZYW3VTp/brown-brim.png", name: "Brown Brim", price: 25))
                .environmentObject(CartItemViewModel())
                .environmentObject(CategoryViewModel())
        }
    }
}
