//
//  ApagadasView.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct ApagadasView: View {
    @EnvironmentObject var gerenciador: GerenciadorDeSenhas
    
    @State private var modoSelecao: Bool = false
    @State private var selecionados: Set<UUID> = []
    @State private var mostrarConfirmacaoApagarSelecionadas: Bool = false
    
    var secoes: [String] {
        agrupadas.keys.sorted()
    }
    
    var agrupadas: [String: [SenhaItem]] {
        Dictionary(grouping: gerenciador.apagadas) { String($0.nome.prefix(1)).uppercased() }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if gerenciador.apagadas.isEmpty {
                    VStack {
                        Spacer()
                        
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.red.opacity(0.15))
                                    .frame(width: 56, height: 56)
                                
                                Image(systemName: "trash.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.red)
                            }
                            
                            Text("Apagadas")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color("H1"))
                            
                            Text("As senhas apagadas ficam disponíveis aqui\npor 30 dias até serem apagadas\nautomaticamente.")
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
                        Text("Apagadas")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color("H1"))
                        
                        Spacer()
                        
                        BtnSelecionar(titulo: modoSelecao ? "Cancelar" : "Selecionar") {
                            modoSelecao.toggle()
                            selecionados.removeAll()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    
                    List {
                        ForEach(secoes, id: \.self) { inicial in
                            Section(header: Text(inicial)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            ) {
                                ForEach(agrupadas[inicial] ?? []) { item in
                                    HStack(spacing: 12) {
                                        if modoSelecao {
                                            Button {
                                                toggleSelecao(item)
                                            } label: {
                                                Image(systemName: selecionados.contains(item.id) ? "checkmark.circle.fill" : "circle")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(selecionados.contains(item.id) ? Color("H1") : .gray)
                                            }
                                        }
                                        
                                        SenhaRowView(item: item) {
                                            gerenciador.alternarFavorito(item)
                                        }
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if modoSelecao {
                                            toggleSelecao(item)
                                        }
                                    }
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.visible, edges: .bottom)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        if !modoSelecao {
                                            Button(role: .destructive) {
                                                gerenciador.excluirDefinitivamente(item)
                                            } label: {
                                                Label("Apagar", systemImage: "trash")
                                            }
                                        }
                                    }
                                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                        if !modoSelecao {
                                            Button {
                                                gerenciador.restaurar(item)
                                            } label: {
                                                Label("Restaurar", systemImage: "arrow.uturn.backward")
                                            }
                                            .tint(.green)
                                        }
                                    }
                                }
                            }
                            .sectionIndexLabel(inicial)
                        }
                    }
                    .listStyle(.plain)
                    .listSectionIndexVisibility(.visible)
                    
                    // MARK: - Barra Inferior (modo seleção)
                    if modoSelecao {
                        HStack {
                            Text("\(selecionados.count) selecionada(s)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Button {
                                restaurarSelecionadas()
                            } label: {
                                Text("Restaurar")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.green)
                            }
                            .disabled(selecionados.isEmpty)
                            
                            Button(role: .destructive) {
                                mostrarConfirmacaoApagarSelecionadas = true
                            } label: {
                                Text("Apagar")
                                    .fontWeight(.semibold)
                            }
                            .disabled(selecionados.isEmpty)
                            .padding(.leading, 16)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(.ultraThinMaterial)
                    }
                }
            }
        }
        .confirmationDialog(
            "Apagar \(selecionados.count) senha(s) definitivamente?",
            isPresented: $mostrarConfirmacaoApagarSelecionadas,
            titleVisibility: .visible
        ) {
            Button("Apagar", role: .destructive) {
                for item in gerenciador.apagadas where selecionados.contains(item.id) {
                    gerenciador.excluirDefinitivamente(item)
                }
                selecionados.removeAll()
                modoSelecao = false
            }
            Button("Cancelar", role: .cancel) {}
        }
    }
    
    private func toggleSelecao(_ item: SenhaItem) {
        if selecionados.contains(item.id) {
            selecionados.remove(item.id)
        } else {
            selecionados.insert(item.id)
        }
    }
    
    private func restaurarSelecionadas() {
        for item in gerenciador.apagadas where selecionados.contains(item.id) {
            gerenciador.restaurar(item)
        }
        selecionados.removeAll()
        modoSelecao = false
    }
}

#Preview {
    ApagadasView()
        .environmentObject(AppManager())
        .environmentObject(GerenciadorDeSenhas())
}
