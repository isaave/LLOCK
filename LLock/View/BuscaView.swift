//
//  BuscaView.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct BuscaView: View {
    @Binding var textoBusca: String
    
    // Lista simulada de senhas cadastradas para teste de busca
    @State private var senhasExemplo: [String] = [
        "Google", "Github", "Apple ID", "Netflix", "Spotify", "Amazon"
    ]
    
    var resultados: [String] {
        if textoBusca.isEmpty {
            return []
        } else {
            return senhasExemplo.filter { $0.localizedCaseInsensitiveContains(textoBusca) }
        }
    }
    
    var body: some View {
        Group {
            if textoBusca.isEmpty {
                // MARK: - Estado Inicial (Vazio)
                VStack {
                    Spacer()
                    
                    VStack(spacing: 16) {
                        // Ícone da Lupa com Círculo
                        ZStack {
                            Circle()
                                .fill(Color.orange.opacity(0.08))
                                .frame(width: 56, height: 56)
                            
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.orange)
                        }
                        
                        // Título
                        Text("Procurar")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("H1"))
                        
                        // Descrição
                        Text("Digite o nome do serviço, e-mail ou usuário\npara localizar sua credencial.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .lineSpacing(2)
                    }
                    .padding(.horizontal, 32)
                    
                    Spacer()
                }
            } else if resultados.isEmpty {
                // MARK: - Estado Sem Resultados Nativo
                ContentUnavailableView.search(text: textoBusca)
            } else {
                // MARK: - Lista de Resultados
                List(resultados, id: \.self) { item in
                    Text(item)
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    BuscaView(textoBusca: .constant(""))
        .environmentObject(AppManager())
}
