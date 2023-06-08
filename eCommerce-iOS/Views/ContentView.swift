//
//  ContentView.swift
//  eCommerce-iOS
//
//  Created by bo zhong on 6/8/23.
//

import SwiftUI

struct ContentView: View { 
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
