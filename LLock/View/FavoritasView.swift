//
//  FavoritasView.swift
//  LLock
//
//  Created by Isabella Avelina on 19/07/26.
//

import SwiftUI

struct FavoritasView: View {
    var body: some View {
        NavigationStack {
            VStack {
                // Visual nativo da Apple para telas sem conteúdo ainda
                ContentUnavailableView(
                    "Nenhuma Favorita",
                    systemImage: "star.bubble",
                    description: Text("Toque na estrela ao visualizar uma senha para que ela apareça rapidamente nesta aba.")
                )
            }
            // O título da navegação deve ficar colado na view que está DENTRO da NavigationStack
            .navigationTitle("Favoritas")
        }
    }
}

#Preview {
    FavoritasView()
        .environmentObject(AppManager())
}
