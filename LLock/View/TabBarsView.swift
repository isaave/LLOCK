//
//  TabBars.swift
//  LLock
//
//  Created by Isabella Avelina on 16/07/26.
//

import SwiftUI

struct TabBarsView: View {
    @State private var selectedTab: Tabs = .key
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            Tab.init("Senhas", systemImage: "key", value: .key) {
                SenhasView() // Chama a view que já contém o título "Senhas"
            }
            
            Tab.init("Favoritas", systemImage: "star", value: .favorites) {
                FavoritasView()
            }
            
            Tab.init("Segurança", systemImage: "exclamationmark.circle", value: .security) {
                SegurancaView()
            }
            
            Tab.init("Apagadas", systemImage: "trash", value: .extinguished) {
                ApagadasView()
            }
            
            Tab.init(value: .search, role: .search) {
                BuscaView()
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
