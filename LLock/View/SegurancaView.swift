//
//  SegurancaView.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct SegurancaView: View {
    @EnvironmentObject var gerenciador: GerenciadorDeSenhas
    
    @State private var criterioOrdenacao: CriterioOrdenacao = .titulo
    @State private var ordemCrescente: Bool = true
    
    var problemasOrdenados: [SenhaItem] {
        let base = gerenciador.senhasComProblema
        
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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if gerenciador.ativas.isEmpty {
                    VStack {
                        Spacer()
                        
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.blue.opacity(0.15))
                                    .frame(width: 56, height: 56)
                                
                                Image(systemName: "exclamationmark.shield.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.blue)
                            }
                            
                            Text("Segurança")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color("H1"))
                            
                            Text("Cadastre suas senhas para que a gente\npossa avaliar a segurança delas.")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .lineSpacing(2)
                        }
                        .padding(.horizontal, 32)
                        
                        Spacer()
                    }
                } else if gerenciador.senhasComProblema.isEmpty {
                    VStack {
                        Spacer()
                        
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.green.opacity(0.15))
                                    .frame(width: 56, height: 56)
                                
                                Image(systemName: "checkmark.shield.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.green)
                            }
                            
                            Text("Tudo em ordem")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color("H1"))
                            
                            Text("Nenhuma senha fraca ou reutilizada\nfoi encontrada.")
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
                        Text("Segurança")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color("H1"))
                        
                        Spacer()
                        
                        BtnFiltrar(
                            onDecrescente: { ordemCrescente = false },
                            onCrescente: { ordemCrescente = true },
                            onDataEdicao: { criterioOrdenacao = .dataEdicao },
                            onDataCriacao: { criterioOrdenacao = .dataCriacao },
                            onTitulo: { criterioOrdenacao = .titulo }
                        )
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    
                    List {
                        ForEach(problemasOrdenados) { item in
                            NavigationLink(destination: DetalheSenhaView(item: item)) {
                                LinhaProblemaSeguranca(item: item, gerenciador: gerenciador)
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

struct LinhaProblemaSeguranca: View {
    let item: SenhaItem
    let gerenciador: GerenciadorDeSenhas
    
    var eComprometida: Bool {
        gerenciador.isFraca(item.senha)
    }
    
    var corStatus: Color {
        eComprometida ? .red : .orange
    }
    
    var textoStatus: String {
        eComprometida ? "Senha Comprometida" : "Senha reutilizada"
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.gray.opacity(0.15))
                    .frame(width: 40, height: 40)
                
                Image(systemName: item.iconeSistema)
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(item.nome)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Text(textoStatus)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "exclamationmark.circle.fill")
                .font(.system(size: 20))
                .foregroundColor(corStatus)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SegurancaView()
        .environmentObject(AppManager())
        .environmentObject(GerenciadorDeSenhas())
}
