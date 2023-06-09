//
//  ContentView.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CategoryViewModel()
    @State private var showCheckout = false
    
    let columns = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    var body: some View {
            GeometryReader { geo in
                NavigationView {
                    ScrollView(.vertical){
                        LazyVGrid(columns: columns, spacing: 20, content: {
                            ForEach(viewModel.categories, id: \.name) { category in
                                Section {
                                    ForEach(category.items, id: \.id) { item in
                                        VStack{
                                            AsyncImage(url: URL(string: item.imageUrl)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(maxWidth: geo.size.width * 0.50)
                                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                                    .shadow(color: .gray, radius: 10, x: 0, y: 10)
                                                    .padding()
                                                
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            VStack(spacing: 10){
                                                Text(item.name.capitalized)
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
                                } header: {
                                    Text(category.name.capitalized)
                                        .font(.largeTitle)
                                        .foregroundColor(.gray)
                                        .bold()
                                        .padding(.top)
                                }
                            
                        }
                    })
                    .onAppear(perform: viewModel.fetchCategories)
                }
                    .navigationTitle("eCommerce")
                    .navigationBarTitleDisplayMode(.inline)
                    .sheet(isPresented: $showCheckout) {
                        CheckoutView()
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing){
                            NavigationLink {
                                CheckoutView()
                            } label: {
                                Image(systemName: "cart.fill")
                                    .resizable()
                                    .frame(width:24, height: 24)
                                    .foregroundColor(Color.brown)
                            }

                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
