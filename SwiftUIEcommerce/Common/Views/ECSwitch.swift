//
//  ECToggle.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 25.07.2025.
//


import SwiftUI

struct ECSwitch<Label> : View where Label : View  {
    @Binding var isOn: Bool
    var label: () -> Label
 
    var body: some View {
        Toggle(isOn: $isOn) {
            label()
        }
        .toggleStyle(.switch)
        .tint(.ecAccent)
        
    }
    
    
}
   

   
        

