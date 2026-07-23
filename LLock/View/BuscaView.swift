//
//  BuscaView.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct BuscaView: View {
    @EnvironmentObject var gerenciador: GerenciadorDeSenhas
    @Binding var textoBusca: String
    
    var resultados: [SenhaItem] {
        if textoBusca.isEmpty {
            return []
        } else {
            return gerenciador.ativas.filter {
                $0.nome.localizedCaseInsensitiveContains(textoBusca) ||
                $0.usuario.localizedCaseInsensitiveContains(textoBusca) ||
                $0.site.localizedCaseInsensitiveContains(textoBusca)
            }
        }
    }
    
    var body: some View {
        Group {
            if textoBusca.isEmpty {
                VStack {
                    Spacer()
                    
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.orange.opacity(0.08))
                                .frame(width: 56, height: 56)
                            
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.orange)
                        }
                        
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
                ContentUnavailableView.search(text: textoBusca)
            } else {
                VStack(spacing: 0) {
                    HStack {
                        Text("Buscar")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color("H1"))
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    
                    List(resultados) { item in
                        NavigationLink(destination: DetalheSenhaView(item: item)) {
                            SenhaRowView(item: item) {
                                gerenciador.alternarFavorito(item)
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BuscaView(textoBusca: .constant(""))
            .environmentObject(AppManager())
            .environmentObject(GerenciadorDeSenhas())
    }
}
