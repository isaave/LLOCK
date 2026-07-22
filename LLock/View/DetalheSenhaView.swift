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
    
    let item: SenhaItem
    @State private var mostrarSenha: Bool = false
    @State private var mostrarConfirmacaoApagar: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.orange.opacity(0.8))
                            .frame(width: 72, height: 72)
                        Image(systemName: item.iconeSistema)
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                    }
                    Text(item.nome)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.top, 16)
                
                VStack(spacing: 0) {
                    if item.tipo == .senha {
                        linha(titulo: "Nome de Usuário", valor: item.usuario)
                        Divider().padding(.leading, 16)
                    }
                    
                    HStack {
                        Text("Senha").foregroundColor(.primary)
                        Spacer()
                        Text(mostrarSenha ? item.senha : String(repeating: "•", count: max(item.senha.count, 6)))
                            .foregroundColor(.secondary)
                        Button {
                            mostrarSenha.toggle()
                        } label: {
                            Image(systemName: mostrarSenha ? "eye.slash" : "eye")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    Divider().padding(.leading, 16)
                    
                    linha(titulo: item.tipo == .wifi ? "Segurança" : "Site", valor: item.site)
                }
                .background(Color("BackgroudCard"))
                .cornerRadius(16)
                .padding(.horizontal, 16)
                
                Button(role: .destructive) {
                    mostrarConfirmacaoApagar = true
                } label: {
                    Text("Apagar")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Editar") {
                    // próximo passo: abrir sheet de edição reaproveitando o form do BtnMais
                }
            }
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
    
    private func linha(titulo: String, valor: String) -> some View {
        HStack {
            Text(titulo).foregroundColor(.primary)
            Spacer()
            Text(valor).foregroundColor(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    NavigationStack {
        DetalheSenhaView(item: SenhaItem(nome: "Instagram", usuario: "talita.silva98", senha: "123456", site: "instagram.com"))
            .environmentObject(GerenciadorDeSenhas())
    }
}
