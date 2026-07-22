//
//  ApagadasView.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct ApagadasView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // Conteúdo Central
                VStack(spacing: 16) {
                    // Ícone da Lixeira com Círculo ao fundo
                    ZStack {
                        Circle()
                            .fill(Color.red.opacity(0.15))
                            .frame(width: 56, height: 56)
                        
                        Image(systemName: "trash.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.red)
                    }
                    
                    // Texto do Título
                    Text("Apagadas")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("H1"))

                    
                    // Descrição
                    Text("As senhas apagadas ficam disponíveis aqui\npor 30 dias até serem apagadas\nautomaticamente.")
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
    ApagadasView()
        .environmentObject(AppManager())
}
