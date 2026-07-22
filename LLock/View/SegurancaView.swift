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
            if gerenciador.ativas.isEmpty {
                ContentUnavailableView(
                    "Nada para Analisar",
                    systemImage: "checkmark.shield",
                    description: Text("Cadastre suas senhas para que a gente possa avaliar a segurança delas.")
                )
                .navigationTitle("Segurança")
            } else {
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
                            .disabled(true) // Apenas visual por enquanto
                    }
                }
                .navigationTitle("Segurança")
            }
        }
    }
}

#Preview {
    SegurancaView()
        .environmentObject(AppManager())
        .environmentObject(GerenciadorDeSenhas())
}
