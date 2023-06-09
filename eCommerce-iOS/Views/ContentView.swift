//
//  ContentView.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @EnvironmentObject var cartItemViewModel: CartItemViewModel
    @EnvironmentObject var categoryViewModel : CategoryViewModel
    @State private var showCheckout = false
    
    let columns = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    var body: some View {
            GeometryReader { geo in
                NavigationView {
                    ScrollView(.vertical){
                            LazyVGrid(columns: columns, spacing: 20, content: {
                                ForEach(categoryViewModel.categories, id: \.name) { category in
                                    Section {
                                        ForEach(category.items, id: \.id) { item in
                                            VStack{
                                                NavigationLink {
                                                    ItemView(item: item)
                                                } label: {
                                                    VStack{
                                                        KFImage(URL(string: item.imageUrl))
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(maxWidth: geo.size.width * 0.50)
                                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                                            .shadow(color: .gray, radius: 10, x: 0, y: 10)
                                                            .padding()
                                                        VStack(spacing: 10){
                                                            Text(item.name.capitalized)
                                                                .foregroundColor(.black)
                                                                .font(SwiftUI.Font.footnote)
                                                                .lineLimit(1)
                                                                .padding(7)
                                                                .background(Color.gray.opacity(0.2))
                                                                .cornerRadius(3)
                                                            Text("$\(item.price)")
                                                                .foregroundColor(.black).bold()
                                                        }
                                                        .padding(.bottom, 10)
                                                        
                                                    }
                                                }
                                                
                                            }
                                        }
                                    } header: {
                                        Text(category.name.capitalized)
                                            .font(.largeTitle)
                                            .foregroundColor(.gray)
                                            .bold()
                                            .padding(.top)
                                    }
                                    
                                }
                            })
                        }
                    .navigationTitle("eCommerce")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing){
                            NavigationLink {
                                CheckoutView()
                            } label: {
                                Image(systemName: "cart.fill")
                                    .resizable()
                                    .frame(width:24, height: 24)
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

            }
                .navigationBarBackButtonHidden(true)
                .onAppear(perform: categoryViewModel.fetchCategories)
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CartItemViewModel())
            .environmentObject(CategoryViewModel())

    }
}
