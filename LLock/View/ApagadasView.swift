//
//  ApagadasView.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI


struct ApagadasView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ContentUnavailableView(
                    "Lixeira Vazia",
                    systemImage: "trash",
                    description: Text("As senhas que você apagar ficarão salvas aqui por até 30 dias antes da exclusão definitiva.")
                )
            }
            .navigationTitle("Apagadas")
            
            
        }
    }
}

#Preview {
    ApagadasView()
        .environmentObject(AppManager())
}

