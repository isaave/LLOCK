//
//  SenhaItem.swift
//  LLock
//
//  Created by Isabella Avelina on 21/07/26.
//

// SenhaItem.swift
import Foundation

enum TipoSenha: String {
    case senha
    case wifi
}

struct SenhaItem: Identifiable {
    let id = UUID()
    var nome: String
    var usuario: String
    var senha: String
    var site: String
    var iconeSistema: String = "lock.fill"
    var isFavorito: Bool = false
    var isApagada: Bool = false
    var tipo: TipoSenha = .senha // 👈 novo campo
}
