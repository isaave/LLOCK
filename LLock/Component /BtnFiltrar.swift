//
//  BtnFiltrar.swift
//  LLock
//
//  Created by Isabella Avelina on 21/07/26.
//
import SwiftUI

struct BtnFiltrar: View {
    var onDecrescente: () -> Void = {}
    var onCrescente: () -> Void = {}
    var onDataEdicao: () -> Void = {}
    var onDataCriacao: () -> Void = {}
    var onTitulo: () -> Void = {}
    
    var body: some View {
        Menu {
            Button(action: onDecrescente) {
                Label("Decrescente", systemImage: "arrow.up")
            }
            
            Button(action: onCrescente) {
                Label("Crescente", systemImage: "arrow.down")
            }
            
            Divider()
            Button(action: onDataEdicao) {
                Label("Data de Edição", systemImage: "pencil")
            }
            
            Button(action: onDataCriacao) {
                Label("Data de Criação", systemImage: "plus.circle")
            }
            
            Button(action: onTitulo) {
                Label("Título", systemImage: "textformat")
            }
        } label: {
            Image(systemName: "ellipsis")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(Color("BtnColor liquid glass"))
                .frame(width: 64, height: 64)
                .glassEffect()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground)
            .ignoresSafeArea()
        
        BtnFiltrar(
            onDecrescente: { print("Selecionou Decrescente") },
            onCrescente: { print("Selecionou Crescente") },
            onDataEdicao: { print("Ordenar por Data de Edição") },
            onDataCriacao: { print("Ordenar por Data de Criação") },
            onTitulo: { print("Ordenar por Título") }
        )
    }
}
