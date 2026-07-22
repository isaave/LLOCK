//
//  SegurancaView.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct SegurancaView: View {
    @EnvironmentObject var gerenciador: GerenciadorDeSenhas
    
    var body: some View {
        NavigationStack {
            Group {
                if gerenciador.ativas.isEmpty {
                    // MARK: - Layout Estado Vazio
                    VStack {
                        Spacer()
                        
                        VStack(spacing: 16) {
                            // Ícone do Escudo com Círculo ao fundo
                            ZStack {
                                Circle()
                                    .fill(Color.blue.opacity(0.15))
                                    .frame(width: 56, height: 56)
                                
                                Image(systemName: "exclamationmark.shield.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.blue)
                            }
                            
                            // Título
                            Text("Segurança")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color("H1"))
                            
                            // Descrição
                            Text("Cadastre suas senhas para que a gente\npossa avaliar a segurança delas.")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .lineSpacing(2)
                        }
                        .padding(.horizontal, 32)
                        
                        Spacer()
                    }
                } else {
                    // MARK: - Layout Com Dados
                    List {
                        Section(header: Text("Análise de Vulnerabilidade")) {
                            HStack {
                                Image(systemName: "checkmark.shield.fill")
                                    .foregroundColor(.green)
                                Text("Nenhuma senha vazada")
                            }
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.yellow)
                                Text("2 senhas repetidas ou fracas")
                            }
                        }
                        
                        Section(header: Text("Configurações Gerais")) {
                            Toggle("Autenticação Biométrica", isOn: .constant(true))
                                .disabled(true)
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    SegurancaView()
        .environmentObject(AppManager())
        .environmentObject(GerenciadorDeSenhas())
}
