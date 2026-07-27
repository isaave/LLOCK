//
//  BtnCheck.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct BtnCheck: View {
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            Image(systemName: "checkmark")
                .font(.system(size: 16, weight: .medium))                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .frame(height: 40)
                .background(Color("BtnColor"))
                .clipShape(Circle())


        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    BtnCheck {
        print("Check clicado!")
    }
}
