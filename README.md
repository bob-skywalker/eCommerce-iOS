# eCommerce-iOS

[eCommerce](https://lnkd.in/gFdv6B9g) My first swiftUI iOS e-commerce app is live and I'm thrilled about it. Built from scratch using SwiftUI, Firebase, and KingFisher, this project was a perfect blend of challenge and creativity.  
**Key Features:**

* Fully-functional e-commerce app developed using SwiftUI, Firebase, and KingFisher, offering a seamless shopping experience.

* Built entirely from scratch, the app offers an original, user-friendly interface that seamlessly merges challenge and creativity.

* Actively seeking further development opportunities, promising continued growth and innovation in future projects and versions of the app.

* Constantly adding new features and new UI views.

## Technologies, Libraries, APIs

* Kingfisher - image caching on users device

* Firebase API - fetch async data from Google Firebase

* SwiftUI, MVVC design pattern, Delegate Protocol, JSON parser

**Front-end:**

* Swift
* Kingfisher
* Swift Struct
* Computed Properties
* SwiftUI

**Module Bundler** 

* Cocoapod
* Swift Package Manager 
* UIImageView with async URL fetch functionality 

# Aplication Preview

## Clime8 Layout

![Clime8 Layout](https://i.postimg.cc/J7d5MRMS/IMG-6929.png)


## Code Snippet

**Utilizes Swift LazyVGrid to render content only when user scrolls near it** 
```swift
  
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
```
