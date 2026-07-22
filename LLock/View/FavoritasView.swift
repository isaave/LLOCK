//
//  FavoritasView.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct FavoritasView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // Conteúdo Central
                VStack(spacing: 16) {
                    // ZStack corrigido com círculo de fundo
                    ZStack {
                        Circle()
                            .fill(Color.yellow.opacity(0.15))
                            .frame(width: 56, height: 56)
                        
                        Image(systemName: "star.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.yellow)
                    }
                    
                    Text("Favoritas")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("H1"))
                    
                    Text("Toque na estrela em qualquer senha\npara favoritar.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .lineSpacing(2)
                }
                .padding(.horizontal, 32)
                
                Spacer()
            }
        }
    }
}

#Preview {
    FavoritasView()
        .environmentObject(AppManager())
}
