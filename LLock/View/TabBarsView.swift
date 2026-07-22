//
//  TabBars.swift
//  LLock
//
//  Created by Isabella Avelina on 16/07/26.
//

import SwiftUI

struct TabBarsView: View {
    @State private var selectedTab: Tabs = .key
    @State private var searchString = ""

    var body: some View {
        TabView(selection: $selectedTab) {
            
            Tab("Senhas", systemImage: "key", value: .key) {
                SenhasView()
            }
            
            Tab("Favoritas", systemImage: "star", value: .favorites) {
                FavoritasView()
            }
            
            Tab("Segurança", systemImage: "exclamationmark.circle", value: .security) {
                SegurancaView()
            }
            
            Tab("Apagadas", systemImage: "trash", value: .extinguished) {
                ApagadasView()
            }
            
            // Tab de busca inline sem precisar de outra View
            Tab(value: .search, role: .search) {
                NavigationStack {
                    List {
                        Text("Search screen")
                    }
                    .navigationTitle("Search")
                    .searchable(text: $searchString)
                }
            }
        }
        .tint(Color("H1"))
    }
}

#Preview {
    TabBarsView()
        .environmentObject(AppManager())
        .environmentObject(GerenciadorDeSenhas())
}
