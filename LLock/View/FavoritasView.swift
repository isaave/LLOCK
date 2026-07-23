//
//  FavoritasView.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct FavoritasView: View {
    @EnvironmentObject var gerenciador: GerenciadorDeSenhas
    
    var secoes: [String] {
        Dictionary(grouping: gerenciador.favoritas) { String($0.nome.prefix(1)).uppercased() }
            .keys
            .sorted()
    }
    
    var agrupadas: [String: [SenhaItem]] {
        Dictionary(grouping: gerenciador.favoritas) { String($0.nome.prefix(1)).uppercased() }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if gerenciador.favoritas.isEmpty {
                    VStack {
                        Spacer()
                        
                        VStack(spacing: 16) {
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
                } else {
                    HStack {
                        Text("Favoritas")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color("H1"))
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                    
                    List {
                        ForEach(secoes, id: \.self) { inicial in
                            Section(header: Text(inicial)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            ) {
                                ForEach(agrupadas[inicial] ?? []) { item in
                                    NavigationLink(destination: DetalheSenhaView(item: item)) {
                                        SenhaRowView(item: item) {
                                            gerenciador.alternarFavorito(item)
                                        }
                                    }
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.visible, edges: .bottom)
                                }
                            }
                            .sectionIndexLabel(inicial)
                        }
                    }
                    .listStyle(.plain)
                    .listSectionIndexVisibility(.visible)
                }
            }
        }
    }
}

#Preview {
    FavoritasView()
        .environmentObject(AppManager())
        .environmentObject(GerenciadorDeSenhas())
}
