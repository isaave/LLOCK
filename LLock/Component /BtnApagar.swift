//
//  BtnApagar.swift
//  LLock
//
//  Created by Isabella Avelina on 22/07/26.
//

import SwiftUI

struct BtnApagar: View {
    var titulo: String = "Apagar"
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            Text(titulo)
                .font(.system(size: 16, weight: .medium))                .foregroundColor(.red)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .clipShape(Capsule())
                .glassEffect()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        
        BtnApagar(titulo: "Apagar")
            .padding(.horizontal, 24)
    }
}
