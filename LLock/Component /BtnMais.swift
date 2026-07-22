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
                    Button(action: {
                        mostrarSheet = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color("BtnColor liquid glass"))
                            .frame(width: 36, height: 36)
                            .background(Color(.systemGray6))
                            .glassEffect()
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text(tipoSelecionado == .wifi ? "Nova Rede Wi-Fi" : "Nova Senha")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        gerenciador.adicionar(
                            nome: titulo,
                            usuario: usuario,
                            senha: senha,
                            site: site,
                            tipo: tipoSelecionado
                        )
                        titulo = ""
                        usuario = ""
                        senha = ""
                        site = ""
                        tipoSelecionado = .senha
                        mostrarSheet = false
                    }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                            .background(Color("BtnColor"))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 16)
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // MARK: - Seletor de Tipo
                        Picker("Tipo", selection: $tipoSelecionado) {
                            Text("Senha").tag(TipoSenha.senha)
                            Text("Wi-Fi").tag(TipoSenha.wifi)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 16)
                        
                        VStack(spacing: 16) {
                            
                            VStack(spacing: 8) {
                                Image(nomeDoAssetMascote)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .padding(.bottom, 4)
                                
                                TextField(tipoSelecionado == .wifi ? "Nome da Rede" : "Título", text: $titulo)
                                    .font(.system(size: 28, weight: .bold))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 8)
                            .padding(.bottom, 12)
                            
                            // Campo: Nome de Usuário (só faz sentido pra login normal)
                            if tipoSelecionado == .senha {
                                HStack {
                                    Text("Nome de Usuário")
                                        .foregroundColor(.primary)
                                    Spacer()
                                    TextField("usuário", text: $usuario)
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.gray)
                                        .textInputAutocapitalization(.never)
                                }
                                Divider()
                            }
                            
                            // Campo: Senha
                            HStack {
                                Text(tipoSelecionado == .wifi ? "Senha da Rede" : "Senha")
                                    .foregroundColor(.primary)
                                Spacer()
                                SecureField("", text: $senha)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                            }
                            Divider()
                            
                            // Campo: Site / Segurança
                            HStack {
                                Text(tipoSelecionado == .wifi ? "Segurança" : "Site")
                                    .foregroundColor(.primary)
                                Spacer()
                                TextField(tipoSelecionado == .wifi ? "WPA2 Pessoal" : "example.com", text: $site)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                                    .keyboardType(tipoSelecionado == .wifi ? .default : .URL)
                                    .textInputAutocapitalization(.never)
                            }
                        }
                        .padding(20)
                        .background(Color("BackgroudCard"))
                        .cornerRadius(24)
                        .padding(.horizontal, 16)
                    }
                    .padding(.top, 8)
                }
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.hidden)
        }
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
