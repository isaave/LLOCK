//
//  SenhasView.swift
//  LLock
//
//  Created by Isabella Avelina on 21/07/26.
//

import SwiftUI

enum CriterioOrdenacao {
    case titulo
    case dataEdicao
    case dataCriacao
}

struct SenhasView: View {
    @EnvironmentObject var appManager: AppManager
    @EnvironmentObject var gerenciador: GerenciadorDeSenhas
    
    @State private var filtroSelecionado: Int = 0 
    @State private var criterioOrdenacao: CriterioOrdenacao = .titulo
    @State private var ordemCrescente: Bool = true
    
    var tipoFiltro: TipoSenha? {
        filtroSelecionado == 0 ? nil : .wifi
    }
    
    var listaOrdenada: [SenhaItem] {
        let base = tipoFiltro == nil ? gerenciador.ativas : gerenciador.ativas.filter { $0.tipo == tipoFiltro }
        
        switch criterioOrdenacao {
        case .titulo:
            return base.sorted {
                let comparacao = $0.nome.localizedCaseInsensitiveCompare($1.nome)
                return ordemCrescente ? comparacao == .orderedAscending : comparacao == .orderedDescending
            }
        case .dataEdicao:
            return base.sorted { ordemCrescente ? $0.dataEdicao < $1.dataEdicao : $0.dataEdicao > $1.dataEdicao }
        case .dataCriacao:
            return base.sorted { ordemCrescente ? $0.dataCriacao < $1.dataCriacao : $0.dataCriacao > $1.dataCriacao }
        }
    }
    
    var agrupadas: [String: [SenhaItem]] {
        Dictionary(grouping: listaOrdenada) { String($0.nome.prefix(1)).uppercased() }
    }
    
    var secoes: [String] {
        let chaves = agrupadas.keys.sorted()
        return ordemCrescente ? chaves : chaves.reversed()
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Senhas")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("H1"))
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        BtnMais()
                        
                        BtnFiltrar(
                            onDecrescente: { ordemCrescente = false },
                            onCrescente: { ordemCrescente = true },
                            onDataEdicao: { criterioOrdenacao = .dataEdicao },
                            onDataCriacao: { criterioOrdenacao = .dataCriacao },
                            onTitulo: { criterioOrdenacao = .titulo }
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 8)
                
                Picker("Filtro", selection: $filtroSelecionado) {
                    Text("Todas").tag(0)
                    Text("Wi-Fi").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                if listaOrdenada.isEmpty {
                    VStack {
                        Spacer()
                        
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.purple.opacity(tipoFiltro == .wifi ? 0.12 : 0.15))
                                    .frame(width: 64, height: 64)
                                
                                Image(systemName: tipoFiltro == .wifi ? "wifi" : "key.fill")
                                    .font(.system(size: 28, weight: tipoFiltro == .wifi ? .semibold : .regular))
                                    .foregroundColor(Color("H1"))
                            }
                            .padding(.bottom, 8)
                            
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
                        Spacer()
                    }
                    
                } else if criterioOrdenacao == .titulo {
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
                    
                } else {
                    List {
                        ForEach(listaOrdenada) { item in
                            NavigationLink(destination: DetalheSenhaView(item: item)) {
                                SenhaRowView(item: item) {
                                    gerenciador.alternarFavorito(item)
                                }
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.visible, edges: .bottom)
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    SenhasView()
        .environmentObject(AppManager())
        .environmentObject(GerenciadorDeSenhas())
}
