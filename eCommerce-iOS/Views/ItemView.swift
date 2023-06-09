//
//  ItemView.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import SwiftUI


struct ItemView: View {
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
            NavigationView {
                ScrollView{
                    VStack(alignment: .leading){
                        VStack(alignment: .leading, spacing: 12){
                            Text("Sustainable Materials")
                                .foregroundColor(.orange).bold()
                            Text(item.name)
                                .bold()
                            Text("$\(item.price)")
                                .foregroundColor(Color.gray)
                        }
                        
                        
                        AsyncImage(url: URL(string: item.imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                        } placeholder: {
                            ProgressView()
                        }
                        
                        VStack(spacing: 23){
                            HStack{
                                Text("Select Size")
                                Spacer()
                                Text("Size Guide")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            
                            LazyVGrid(columns: columns) {
                                ForEach(sizes, id: \.self) { size in
                                    Button {
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
                            Text("4 interest-free payments of $\(String(format: "%.2f", divideByFoudPrice)) with ") + Text("Klama ").bold() + Text("Learn More").underline()
                            Text(text)
                        }
                        .padding()
                        
                        
                    }
                    
                }
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {

    static var previews: some View {
        ItemView(item: Item(id: 1, imageUrl: "https://i.ibb.co/ZYW3VTp/brown-brim.png", name: "Brown Brim", price: 25))
    }
}
