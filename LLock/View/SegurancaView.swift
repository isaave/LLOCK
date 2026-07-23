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
                        
                        BtnFiltrar(onTitulo: { print("Opções") })                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    
                    List {
                        ForEach(gerenciador.senhasComProblema) { item in
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
