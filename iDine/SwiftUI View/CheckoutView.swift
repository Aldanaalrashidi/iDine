//
//  CheckoutView.swift
//  iDine
//
//  Created by Aldana Al-Rashidi on 8/5/20.
//  Copyright © 2020 Aldana Al-Rashidi. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    static let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    static let tipAmounts = [10, 15, 20, 25, 0]
    
    // zero and one default value
    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 1
    @State private var showingPaymentAlert = false
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    var body: some View {
        Form {
            Section{
                // defaulf selection whats written beside is CASH
                Picker("How do you want to pay?", selection: $paymentType){
                    ForEach(0 ..< Self.paymentTypes.count){
                        Text(Self.paymentTypes[$0])
                    }
                }
                // if toggle is on change the value to true and show the text with animation
                Toggle(isOn: $addLoyaltyDetails.animation()){
                    Text("Add iDine loyalty card number")
                }
                // if toggle is on do
                if addLoyaltyDetails{
                    TextField("Enter you iDine ID", text: $loyaltyNumber)
                }
            }
            Section(header: Text("Add a tip?")){
                Picker("Tip?", selection: $tipAmount) {
                    ForEach(0 ..< Self.tipAmounts.count){
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            //specifier for just .00 two zero's after the number
            Section(header:
                Text("TOTAL: \(totalPrice, specifier:  "%.2f") KD")
                    .font(.largeTitle)
            ) {
                Button("Confirm order"){
                    self.showingPaymentAlert.toggle()
                }
            }
        }.navigationBarTitle(Text("Payment"), displayMode: .inline)
            .alert(isPresented: $showingPaymentAlert){
                Alert(title: Text("Order confirmed"), message: Text("Your total was \(totalPrice, specifier: "%.2f") KD - thank you!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}
