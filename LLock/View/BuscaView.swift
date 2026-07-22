//
//  BuscaView.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct BuscaView: View {
    @State private var textoBusca = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if textoBusca.isEmpty {
                    ContentUnavailableView(
                        "Buscar no LLock",
                        systemImage: "magnifyingglass",
                        description: Text("Digite o nome do serviço, e-mail ou usuário para localizar sua credencial.")
                    )
                } else {
                    // Lista vazia simulando o filtro
                    List {
                        Text("Nenhum resultado para '\(textoBusca)'")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Procurar")
            // Deixa a barra de busca sempre visível e ativa nesta tela
            .searchable(text: $textoBusca, placement: .navigationBarDrawer(displayMode: .always), prompt: "O que você procura?")
        }
    }
}
