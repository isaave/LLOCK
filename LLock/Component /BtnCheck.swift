//
//  BtnCheck.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct BtnCheck: View {
    var acao: () -> Void
    
    var body: some View {
        Button(action: acao) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.42, green: 0.44, blue: 0.95),
                                Color(red: 0.32, green: 0.34, blue: 0.85)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [
                                .white.opacity(0.6),
                                .white.opacity(0.1)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 1.5
                    )
                
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(width: 38, height: 38)
            .shadow(color: Color(red: 0.35, green: 0.37, blue: 0.90).opacity(0.35), radius: 6, x: 0, y: 3)
        }
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.05).ignoresSafeArea()
        BtnCheck {
            print("Check clicado!")
        }
    }
}
