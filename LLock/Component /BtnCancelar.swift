//
//  BtnCancelar.swift
//  LLock
//
//  Created by Isabella Avelina on 22/07/26.
//

import SwiftUI

struct BtnCancelar: View {
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            Image(systemName: "xmark")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color("BtnColor liquid glass"))
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .glassEffect()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    BtnCancelar {
        print("Cancelar clicado!")
    }
}
