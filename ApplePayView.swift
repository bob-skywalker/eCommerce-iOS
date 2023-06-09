//
//  ApplePayView.swift
//  eCommerce-iOS
//
//  Created by Bo Zhong on 6/9/23.
//

import SwiftUI

struct ApplePayView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var cardNumber = "123456789"
    @State private var expirationDate = "06/24"
    @State private var cvv = "123"
    
    var body: some View {
        VStack {
                    Text("Payment Details")
                        .font(.title)
                        .padding()

                    TextField("Card Number", text: $cardNumber)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .keyboardType(.numberPad)
                    
                    HStack {
                        TextField("Expiration Date", text: $expirationDate)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .keyboardType(.numberPad)
                        TextField("CVV", text: $cvv)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .keyboardType(.numberPad)
                    }
            
                    NavigationLink {
                        OrderConfirmationView()
                    } label: {
                        Text("Confirm Payment")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }

                }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                }
                
                
            }
        }
        .padding()
    }
    
}


struct ApplePayView_Previews: PreviewProvider {
    static var previews: some View {
        ApplePayView()
    }
}
