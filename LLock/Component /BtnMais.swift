//
//  BtnMais.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct BtnMais: View {
    @State private var mostrarSheet: Bool = false
  
    @State private var titulo: String = ""
    @State private var usuario: String = ""
    @State private var senha: String = ""
    @State private var site: String = ""
    
    
    let nomeDoAssetMascote: String = "Icone"
    
    var body: some View {
        Button(action: {
            mostrarSheet = true
        }) {
            Image(systemName: "plus")
                .font(Font.custom("SF Pro Text", size: 30).weight(.medium))
                .foregroundColor(Color("BtnColor liquid glass"))
                .frame(width: 64, height: 64)
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
                    
                    Text("Nova Senha")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        print("Salvando senha...")
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
                        
                        VStack(spacing: 16) {
                            
                            VStack(spacing: 8) {
                                Image(nomeDoAssetMascote)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .padding(.bottom, 4)
                                
                                TextField("Título", text: $titulo)
                                    .font(.system(size: 28, weight: .bold))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 8)
                            .padding(.bottom, 12)
                            
                            // Campo: Nome de Usuário
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
                            
                            // Campo: Senha
                            HStack {
                                Text("Senha")
                                    .foregroundColor(.primary)
                                Spacer()
                                SecureField("", text: $senha)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                            }
                            Divider()
                            
                            // Campo: Site
                            HStack {
                                Text("Site")
                                    .foregroundColor(.primary)
                                Spacer()
                                TextField("example.com", text: $site)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                                    .keyboardType(.URL)
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
    }
}
