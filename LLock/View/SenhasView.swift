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
    
    var secoes: [String] {
        gerenciador.agrupadasPorLetra.keys.sorted()
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
            
            // MARK: - Lista
            if gerenciador.ativas.isEmpty {
                ContentUnavailableView(
                    "Nenhuma Senha",
                    systemImage: "key.fill",
                    description: Text("Toque no + para adicionar sua primeira senha.")
                )
                Spacer()
            } else {
                List {
                    ForEach(secoes, id: \.self) { inicial in
                        Section(header: Text(inicial)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        ) {
                            ForEach(gerenciador.agrupadasPorLetra[inicial] ?? []) { item in
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
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
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
