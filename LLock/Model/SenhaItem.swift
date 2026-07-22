//
//  SenhaItem.swift
//  LLock
//
//  Created by Isabella Avelina on 21/07/26.
//

import Foundation

struct SenhaItem: Identifiable {
    let id = UUID()
    var nome: String
    var usuario: String
    var senha: String
    var site: String
    var iconeSistema: String = "lock.fill"
    var isFavorito: Bool = false
    var isApagada: Bool = false
}

