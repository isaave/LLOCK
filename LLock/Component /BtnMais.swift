//
//  BtnMais.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct BtnMais: View {
    @EnvironmentObject var gerenciador: GerenciadorDeSenhas
    
    @State private var mostrarSheet: Bool = false
    
    @State private var titulo: String = ""
    @State private var usuario: String = ""
    @State private var senha: String = ""
    @State private var site: String = ""
    @State private var tipoSelecionado: TipoSenha = .senha
    
    let nomeDoAssetMascote: String = "Icone"
    
    // MARK: - Validação
    private var formularioValido: Bool {
        let tituloValido = !titulo.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let senhaValida = !senha.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let siteValido = !site.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let usuarioValido = tipoSelecionado == .wifi || !usuario.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        return tituloValido && senhaValida && siteValido && usuarioValido
    }
    
    var body: some View {
        Button(action: {
            mostrarSheet = true
        }) {
            Image(systemName: "plus")
                .font(Font.custom("SF Pro Text", size: 20).weight(.medium))
                .foregroundColor(Color("BtnColor liquid glass"))
                .frame(width: 36, height: 36)
                .glassEffect()
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $mostrarSheet) {
            VStack(spacing: 0) {
                
                HStack {
                    BtnCancelar {
                        limparCampos()
                        mostrarSheet = false
                    }
                    
                    Spacer()
                    
                    BtnCheck {
                        gerenciador.adicionar(
                            nome: titulo.trimmingCharacters(in: .whitespacesAndNewlines),
                            usuario: usuario.trimmingCharacters(in: .whitespacesAndNewlines),
                            senha: senha,
                            site: site.trimmingCharacters(in: .whitespacesAndNewlines),
                            tipo: tipoSelecionado
                        )
                        limparCampos()
                        mostrarSheet = false
                    }
                    .disabled(!formularioValido)
                    .opacity(formularioValido ? 1 : 0.4)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 16)
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        Picker("Tipo", selection: $tipoSelecionado) {
                            Text("Senha").tag(TipoSenha.senha)
                            Text("Wi-Fi").tag(TipoSenha.wifi)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 16)
                        
                        VStack(spacing: 0) {
                            
                            VStack(spacing: 0) {
                                Image(nomeDoAssetMascote)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .padding(.bottom, 4)
                                
                                TextField(tipoSelecionado == .wifi ? "Nome da Rede" : "Título", text: $titulo)
                                    .font(.system(size: 28, weight: .medium))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                            .padding(.top, 16)
                            .padding(.bottom, 10)
                            
                            if tipoSelecionado == .senha {
                                HStack {
                                    Text("Nome de Usuário")
                                        .foregroundColor(.primary)
                                        .fixedSize(horizontal: true, vertical: false)
                                    Spacer()
                                    TextField("usuário", text: $usuario)
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.gray)
                                        .textInputAutocapitalization(.never)
                                        .textContentType(.username)
                                        .lineLimit(1)
                                }
                                .padding(.vertical, 5)
                                Divider()
                            }
                            
                            HStack {
                                Text(tipoSelecionado == .wifi ? "Senha da Rede" : "Senha")
                                    .foregroundColor(.primary)
                                    .fixedSize(horizontal: true, vertical: false)
                                Spacer()
                                SecureField("Senha necessária", text: $senha)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                                    .textContentType(.newPassword)
                                    .lineLimit(1)
                            }
                            .padding(.vertical, 12)
                            Divider()
                            
                            HStack {
                                Text(tipoSelecionado == .wifi ? "Segurança" : "Site")
                                    .foregroundColor(.primary)
                                    .fixedSize(horizontal: true, vertical: false)
                                Spacer()
                                TextField(tipoSelecionado == .wifi ? "WPA2 Pessoal" : "example.com", text: $site)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                                    .keyboardType(tipoSelecionado == .wifi ? .default : .URL)
                                    .textInputAutocapitalization(.never)
                                    .textContentType(tipoSelecionado == .wifi ? nil : .URL)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            .padding(.vertical, 12)
                        }
                        .padding(.horizontal, 16)
                        .background(Color("BackgroudCard"))
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                    }
                    .padding(.top, 8)
                }
                
                Spacer(minLength: 16)
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.hidden)
        }
    }
    
    private func limparCampos() {
        titulo = ""
        usuario = ""
        senha = ""
        site = ""
        tipoSelecionado = .senha
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground)
            .ignoresSafeArea()
        
        BtnMais()
            .environmentObject(GerenciadorDeSenhas())
    }
}
