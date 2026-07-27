//
//  BtnEditar.swift
//  LLock
//
//  Created by Isabella Avelina on 22/07/26.
//

import SwiftUI

struct BtnEditar: View {
    var titulo: String = "Editar"
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            Text(titulo)
                .font(.system(size: 16, weight: .medium))                .foregroundColor(Color("BtnColor liquid glass"))
                .padding(.horizontal, 16)
                .frame(height: 40)
                .clipShape(Capsule())
                .glassEffect()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    BtnEditar(titulo: "Editar")
}
