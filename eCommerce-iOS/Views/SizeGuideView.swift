//
//  SizeGuideView.swift
//  eCommerce-iOS
//
//  Created by Bo Zhong on 6/9/23.
//

import SwiftUI

struct SizeGuideView: View {
    
    var body: some View {
        VStack{
            VStack{
                
                Image("sizeGuide")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))

            }
            .cornerRadius(20)
            .shadow(radius: 20)
        }
//        .background(.black.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 35))
            
    }
}

struct SizeGuideView_Previews: PreviewProvider {
    @State static var showingSizeGuide = false
    
    static var previews: some View {
        SizeGuideView()
    }
}
