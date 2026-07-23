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
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color("H1"))
                    .frame(width: 44, height: 44)
                
                Image(systemName: item.iconeSistema)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(item.nome)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("H3"))
                
                Text(item.usuario)
                    .font(.system(size: 14))
                    .foregroundColor(Color("H3"))
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                Button(action: {
                    onFavoritoTap?()
                }) {
                    Image(systemName: item.isFavorito ? "star.fill" : "star")
                        .font(.system(size: 18))
                        .foregroundColor(Color("H1"))
                }
                .buttonStyle(.plain)
                
                
            }
        }
        .padding(.vertical, 4)
    }
}
