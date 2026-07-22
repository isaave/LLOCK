//
//  GerenciadorDeSenhas.swift
//  LLock
//
//  Created by Isabella Avelina on 21/07/26.
//

import SwiftUI
import Combine  

class GerenciadorDeSenhas: ObservableObject {
    @Published var senhas: [SenhaItem] = []

    // MARK: - Criar
    func adicionar(nome: String, usuario: String, senha: String, site: String) {
        let nova = SenhaItem(nome: nome, usuario: usuario, senha: senha, site: site)
        senhas.append(nova)
    }

    // MARK: - Editar
    func atualizar(_ item: SenhaItem) {
        guard let index = senhas.firstIndex(where: { $0.id == item.id }) else { return }
        senhas[index] = item
    }

    func alternarFavorito(_ item: SenhaItem) {
        guard let index = senhas.firstIndex(where: { $0.id == item.id }) else { return }
        senhas[index].isFavorito.toggle()
    }

    // MARK: - Apagar (lixeira)
    func moverParaLixeira(_ item: SenhaItem) {
        guard let index = senhas.firstIndex(where: { $0.id == item.id }) else { return }
        senhas[index].isApagada = true
    }

    func restaurar(_ item: SenhaItem) {
        guard let index = senhas.firstIndex(where: { $0.id == item.id }) else { return }
        senhas[index].isApagada = false
    }

    func excluirDefinitivamente(_ item: SenhaItem) {
        senhas.removeAll { $0.id == item.id }
    }

    func adicionar(nome: String, usuario: String, senha: String, site: String, tipo: TipoSenha = .senha) {
        let nova = SenhaItem(nome: nome, usuario: usuario, senha: senha, site: site, tipo: tipo)
        senhas.append(nova)
    }

    func agrupadasPorLetra(tipo: TipoSenha? = nil) -> [String: [SenhaItem]] {
        let filtradas = tipo == nil ? ativas : ativas.filter { $0.tipo == tipo }
        return Dictionary(grouping: filtradas) { String($0.nome.prefix(1)).uppercased() }
    }
    
    var ativas: [SenhaItem] { senhas.filter { !$0.isApagada } }
    var favoritas: [SenhaItem] { senhas.filter { $0.isFavorito && !$0.isApagada } }
    var apagadas: [SenhaItem] { senhas.filter { $0.isApagada } }

    var agrupadasPorLetra: [String: [SenhaItem]] {
        Dictionary(grouping: ativas) { String($0.nome.prefix(1)).uppercased() }
    }
}
