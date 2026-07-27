//
//  EditarSenhaView.swift
//  LLock
//
//  Created by Isabella Avelina on 22/07/26.
//

import SwiftUI

struct EditarSenhaView: View {
    @EnvironmentObject var gerenciador: GerenciadorDeSenhas
    @Environment(\.dismiss) var dismiss
    
    let itemID: UUID
    
    @State private var titulo: String
    @State private var usuario: String
    @State private var senha: String
    @State private var site: String
    @State private var tipoSelecionado: TipoSenha
    @State private var mostrarConfirmacaoApagar: Bool = false
    
    init(item: SenhaItem) {
        self.itemID = item.id
        _titulo = State(initialValue: item.nome)
        _usuario = State(initialValue: item.usuario)
        _senha = State(initialValue: item.senha)
        _site = State(initialValue: item.site)
        _tipoSelecionado = State(initialValue: item.tipo)
    }
    
    /// Sempre busca a versão mais atual do item no gerenciador,
    /// em vez de depender de uma cópia congelada no momento da abertura do sheet.
    private var item: SenhaItem? {
        gerenciador.senhas.first(where: { $0.id == itemID })
    }
    
    private var formularioValido: Bool {
        let tituloValido = !titulo.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let senhaValida = !senha.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let siteValido = !site.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let usuarioValido = tipoSelecionado == .wifi || !usuario.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        return tituloValido && senhaValida && siteValido && usuarioValido
    }
    
    var body: some View {
        Group {
            if let item {
                conteudo(item)
            } else {
                // O item não existe mais (foi excluído em outro lugar enquanto o sheet estava aberto).
                Color.clear
                    .onAppear { dismiss() }
            }
        }
    }
    
    @ViewBuilder
    private func conteudo(_ item: SenhaItem) -> some View {
        VStack(spacing: 0) {
            HStack {
                BtnCancelar {
                    dismiss()
                }
                
                Spacer()
                
                BtnCheck {
                    var atualizado = item
                    atualizado.nome = titulo.trimmingCharacters(in: .whitespacesAndNewlines)
                    atualizado.usuario = usuario.trimmingCharacters(in: .whitespacesAndNewlines)
                    atualizado.senha = senha
                    atualizado.site = site.trimmingCharacters(in: .whitespacesAndNewlines)
                    atualizado.tipo = tipoSelecionado
                    gerenciador.atualizar(atualizado)
                    dismiss()
                }
                .disabled(!formularioValido)
                .opacity(formularioValido ? 1 : 0.4)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            ScrollView {
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
                        
                        TextField("Título", text: $titulo)
                            .font(.system(size: 24, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                    
                    VStack(spacing: 14) {
                        if tipoSelecionado == .senha {
                            HStack {
                                Text("Nome de Usuário")
                                    .font(.system(size: 15))
                                    .foregroundColor(.primary)
                                    .fixedSize(horizontal: true, vertical: false)
                                Spacer()
                                TextField("usuário", text: $usuario)
                                    .multilineTextAlignment(.trailing)
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                                    .textInputAutocapitalization(.never)
                                    .lineLimit(1)
                            }
                            Divider()
                        }
                        
                        HStack {
                            Text(tipoSelecionado == .wifi ? "Senha da Rede" : "Senha")
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                                .fixedSize(horizontal: true, vertical: false)
                            Spacer()
                            SecureField("senha", text: $senha)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        }
                        Divider()
                        
                        HStack {
                            Text(tipoSelecionado == .wifi ? "Segurança" : "Site")
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                                .fixedSize(horizontal: true, vertical: false)
                            Spacer()
                            TextField(tipoSelecionado == .wifi ? "WPA2 Pessoal" : "example.com", text: $site)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                                .textInputAutocapitalization(.never)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        Divider()
                        
                        HStack {
                            Text("Modificação")
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                            Spacer()
                            Text(item.dataEdicao.formatted(date: .abbreviated, time: .omitted))
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(20)
                .background(Color("BackgroudCard"))
                .cornerRadius(24)
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
            
            Spacer(minLength: 16)
            
            BtnApagar(titulo: "Apagar") {
                mostrarConfirmacaoApagar = true
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
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
}

#Preview {
    let gerenciador = GerenciadorDeSenhas()
    let itemExemplo = SenhaItem(nome: "Netflix", usuario: "usuario", senha: "12345678", site: "netflix.com")
    gerenciador.senhas = [itemExemplo]
    
    return EditarSenhaView(item: itemExemplo)
        .environmentObject(gerenciador)
}
