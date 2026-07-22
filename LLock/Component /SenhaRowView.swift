//
//  SenhaRowView.swift
//  LLock
//
//  Created by Isabella Avelina on 21/07/26.
//

import SwiftUI

struct SenhaRowView: View {
    let item: SenhaItem
    var onFavoritoTap: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            // Ícone com cantos arredondados
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.orange.opacity(0.8))
                    .frame(width: 44, height: 44)
                
                Image(systemName: item.iconeSistema)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
            
            // Textos (Nome + Usuário)
            VStack(alignment: .leading, spacing: 2) {
                Text(item.nome)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(item.usuario)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Botão Estrela + Setinha
            HStack(spacing: 12) {
                Button(action: {
                    onFavoritoTap?()
                }) {
                    Image(systemName: item.isFavorito ? "star.fill" : "star")
                        .font(.system(size: 18))
                        .foregroundColor(item.isFavorito ? .yellow : Color.blue)
                }
                .buttonStyle(.plain)
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color.gray.opacity(0.5))
            }
        }
        .padding(.vertical, 4)
    }
}
