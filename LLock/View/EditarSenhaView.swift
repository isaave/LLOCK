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
    
    let item: SenhaItem
    
    @State private var titulo: String
    @State private var usuario: String
    @State private var senha: String
    @State private var site: String
    @State private var tipoSelecionado: TipoSenha
    @State private var mostrarConfirmacaoApagar: Bool = false
    
    init(item: SenhaItem) {
        self.item = item
        _titulo = State(initialValue: item.nome)
        _usuario = State(initialValue: item.usuario)
        _senha = State(initialValue: item.senha)
        _site = State(initialValue: item.site)
        _tipoSelecionado = State(initialValue: item.tipo)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                BtnCancelar {
                    dismiss()
                }
                
                Spacer()
                
                BtnCheck {
                    var atualizado = item
                    atualizado.nome = titulo
                    atualizado.usuario = usuario
                    atualizado.senha = senha
                    atualizado.site = site
                    atualizado.tipo = tipoSelecionado
                    gerenciador.atualizar(atualizado)
                    dismiss()
                }
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
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                    
                    VStack(spacing: 14) {
                        if tipoSelecionado == .senha {
                            HStack {
                                Text("Nome de Usuário")
                                    .font(.system(size: 15))
                                    .foregroundColor(.primary)
                                Spacer()
                                TextField("usuário", text: $usuario)
                                    .multilineTextAlignment(.trailing)
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                                    .textInputAutocapitalization(.never)
                            }
                            Divider()
                        }
                        
                        HStack {
                            Text(tipoSelecionado == .wifi ? "Senha da Rede" : "Senha")
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                            Spacer()
                            SecureField("senha", text: $senha)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                        }
                        Divider()
                        
                        HStack {
                            Text(tipoSelecionado == .wifi ? "Segurança" : "Site")
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                            Spacer()
                            TextField(tipoSelecionado == .wifi ? "WPA2 Pessoal" : "example.com", text: $site)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                                .textInputAutocapitalization(.never)
                        }
                        Divider()
                        
                        HStack {
                            Text("Modificação")
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                            Spacer()
                            Text("19 de fev. de 2026")
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
    EditarSenhaView(item: SenhaItem(nome: "", usuario: "", senha: "", site: ""))
        .environmentObject(GerenciadorDeSenhas())
}
