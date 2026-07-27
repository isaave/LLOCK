//
//  DetalheSenhaView.swift
//  LLock
//
//  Created by Isabella Avelina on 22/07/26.
//

import SwiftUI

struct DetalheSenhaView: View {
    @EnvironmentObject var gerenciador: GerenciadorDeSenhas
    @Environment(\.dismiss) var dismiss
    
    let itemID: UUID
    @State private var mostrarSenha: Bool = false
    @State private var mostrarConfirmacaoApagar: Bool = false
    @State private var mostrarEdicao: Bool = false
    @State private var gatilhoFeedback: Bool = false // Gatilho SwiftUI nativo
    
    init(item: SenhaItem) {
        self.itemID = item.id
    }
    
    private var item: SenhaItem? {
        gerenciador.senhas.first(where: { $0.id == itemID })
    }
    
    var body: some View {
        Group {
            if let item {
                conteudo(item)
            } else {
                Color.clear
                    .onAppear { dismiss() }
            }
        }
        // Feedback tátil SwiftUI puramente nativo
        .sensoryFeedback(.success, trigger: gatilhoFeedback)
    }
    
    @ViewBuilder
    private func conteudo(_ item: SenhaItem) -> some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    
                    VStack(spacing: 20) {
                        
                        VStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 22, style: .continuous)
                                    .fill(Color("H1").opacity(0.15))
                                    .frame(width: 88, height: 88)
                                
                                Image(systemName: item.iconeSistema.isEmpty ? "lock.fill" : item.iconeSistema)
                                    .font(.system(size: 44))
                                    .foregroundColor(Color("H1"))
                            }
                            
                            Text(item.nome)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                        .padding(.top, 16)
                        
                        VStack(spacing: 0) {
                            if item.tipo == .senha {
                                linhaInfo(titulo: "Nome de Usuário", valor: item.usuario)
                                Divider().padding(.leading, 16)
                            }
                            
                            HStack {
                                Text("Senha")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(mostrarSenha ? item.senha : String(repeating: "•", count: max(item.senha.count, 8)))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Button {
                                    mostrarSenha.toggle()
                                } label: {
                                    Image(systemName: mostrarSenha ? "eye.slash" : "eye")
                                        .font(.subheadline)
                                        .foregroundColor(Color("H1"))
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .contentShape(Rectangle())
                            .contextMenu {
                                Button {
                                    copiar(item.senha)
                                } label: {
                                    Label("Copiar Senha", systemImage: "doc.on.doc")
                                }
                            }
                            
                            Divider().padding(.leading, 16)
                            
                            linhaInfo(titulo: item.tipo == .wifi ? "Segurança" : "Site", valor: item.site)
                            
                            Divider().padding(.leading, 16)
                            
                            linhaInfo(titulo: "Modificação", valor: item.dataEdicao.formatted(date: .abbreviated, time: .omitted), copiavel: false)
                        }
                        .padding(.bottom, 8)
                    }
                    .background(Color("BackgroudCard"))
                    .cornerRadius(24)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    
                    if gerenciador.isFraca(item.senha) || gerenciador.isReutilizada(item) {
                        VStack(spacing: 12) {
                            HStack(spacing: 10) {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .symbolRenderingMode(.multicolor)
                                    .font(.system(size: 22))
                                
                                Text(gerenciador.isReutilizada(item) ? "Senha reutilizada" : "Senha simples")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                Spacer()
                            }
                            
                            Divider()
                                .padding(.leading, 32)
                            
                            Button {
                                mostrarEdicao = true
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Alterar senha")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.indigo)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(16)
                        .background(Color("BackgroudCard"))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.vertical, 12)
            }
            
            Spacer(minLength: 16)
            
            BtnApagar {
                mostrarConfirmacaoApagar = true
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                BtnEditar {
                    mostrarEdicao = true
                }
            }
        }
        .sheet(isPresented: $mostrarEdicao) {
            EditarSenhaView(item: item)
        }
        .confirmationDialog(
            "Apagar esta senha?",
            isPresented: $mostrarConfirmacaoApagar,
            titleVisibility: .visible
        ) {
            Button("Apagar", role: .destructive) {
                gerenciador.moverParaLixeira(item)
                dismiss()
            }
            Button("Cancelar", role: .cancel) {}
        }
    }
    
    private func linhaInfo(titulo: String, valor: String, copiavel: Bool = true) -> some View {
        HStack {
            Text(titulo)
                .font(.subheadline)
                .foregroundColor(.primary)
            Spacer()
            Text(valor)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
        .contextMenu {
            if copiavel {
                Button {
                    copiar(valor)
                } label: {
                    Label("Copiar", systemImage: "doc.on.doc")
                }
            }
        }
    }
    
    private func copiar(_ texto: String) {
        UIPasteboard.general.string = texto
        gatilhoFeedback.toggle() 
    }
}

#Preview {
    NavigationStack {
        DetalheSenhaView(
            item: SenhaItem(
                nome: "Instagram",
                usuario: "talita.silva98",
                senha: "123456",
                site: "instagram.com"
            )
        )
        .environmentObject(GerenciadorDeSenhas())
    }
}
