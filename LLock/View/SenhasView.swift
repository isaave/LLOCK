//
//  SenhasView.swift
//  LLock
//
//  Created by Isabella Avelina on 21/07/26.
//

import SwiftUI

struct SenhasView: View {
    @EnvironmentObject var appManager: AppManager
    @EnvironmentObject var gerenciador: GerenciadorDeSenhas
    
    @State private var filtroSelecionado: Int = 0 // 0 = Todas, 1 = Wi-Fi
    
    var tipoFiltro: TipoSenha? {
        filtroSelecionado == 0 ? nil : .wifi
    }
    
    var secoes: [String] {
        gerenciador.agrupadasPorLetra(tipo: tipoFiltro).keys.sorted()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Cabeçalho
            HStack {
                Text("Senhas")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("H1"))
                
                Spacer()
                
                HStack(spacing: 8) {
                    BtnMais()
                    BtnFiltrar { print("Opções de filtro") }
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 8)
            
            // MARK: - Segmented Control (Picker)
            Picker("Filtro", selection: $filtroSelecionado) {
                Text("Todas").tag(0)
                Text("Wi-Fi").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.bottom, 8)
            
            // MARK: - Lista / Conteúdo Principal
            if gerenciador.agrupadasPorLetra(tipo: tipoFiltro).isEmpty {
                
                // MARK: - Layout Estado Vazio Padronizado
                VStack {
                    Spacer()
                    
                    VStack(spacing: 16) {
                        // MARK: Círculo e Ícone Padronizados
                        ZStack {
                            if tipoFiltro == .wifi {
                                // Estilo para Wi-Fi (Azul suave)
                                Circle()
                                    .fill(Color.purple.opacity(0.12))
                                    .frame(width: 64, height: 64)
                                
                                Image(systemName: "wifi")
                                    .font(.system(size: 28, weight: .semibold))
                                    .foregroundColor(Color("H1"))
                            } else {
                                // Estilo para Senhas Gerais (AccentColor/Roxo suave)
                                Circle()
                                    .fill(Color.purple.opacity(0.15))
                                    .frame(width: 64, height: 64)
                                
                                Image(systemName: "key.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(Color("H1"))
                            }
                        }
                        .padding(.bottom, 8)
                        
                        // MARK: Textos Padronizados
                        Text(tipoFiltro == .wifi ? "Nenhuma Rede Wi-Fi" : "Nenhuma Senha")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("H1"))
                        
                        Text("Toque no botão + no topo para\nadicionar sua primeira credencial.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .lineSpacing(2)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                    Spacer() // Spacer extra para empurrar levemente para cima
                }
                
            } else {
                // MARK: - Lista Com Dados
                List {
                    ForEach(secoes, id: \.self) { inicial in
                        Section(header: Text(inicial)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        ) {
                            ForEach(gerenciador.agrupadasPorLetra(tipo: tipoFiltro)[inicial] ?? []) { item in
                                SenhaRowView(item: item) {
                                    gerenciador.alternarFavorito(item)
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.visible, edges: .bottom)
                            }
                        }
                        .sectionIndexLabel(inicial)
                    }
                }
                .listStyle(.plain)
                // Mantendo o estilo do índice lateral da lista original
                .listSectionIndexVisibility(.visible)
            }
        }
    }
}

#Preview {
    SenhasView()
        .environmentObject(AppManager())
        .environmentObject(GerenciadorDeSenhas())
}
