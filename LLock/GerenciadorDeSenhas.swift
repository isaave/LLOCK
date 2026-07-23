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
    
    func adicionar(nome: String, usuario: String, senha: String, site: String, tipo: TipoSenha = .senha) {
        let nova = SenhaItem(nome: nome, usuario: usuario, senha: senha, site: site, tipo: tipo)
        senhas.append(nova)
    }
    
    func atualizar(_ item: SenhaItem) {
        guard let index = senhas.firstIndex(where: { $0.id == item.id }) else { return }
        var atualizado = item
        atualizado.dataEdicao = Date() // 👈 registra quando foi editado
        senhas[index] = atualizado
    }
    
    func alternarFavorito(_ item: SenhaItem) {
        guard let index = senhas.firstIndex(where: { $0.id == item.id }) else { return }
        senhas[index].isFavorito.toggle()
    }
    
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
    
    func agrupadasPorLetra(tipo: TipoSenha? = nil) -> [String: [SenhaItem]] {
        let filtradas = tipo == nil ? ativas : ativas.filter { $0.tipo == tipo }
        return Dictionary(grouping: filtradas) { String($0.nome.prefix(1)).uppercased() }
    }
    
    var ativas: [SenhaItem] { senhas.filter { !$0.isApagada } }
    var favoritas: [SenhaItem] { senhas.filter { $0.isFavorito && !$0.isApagada } }
    var apagadas: [SenhaItem] { senhas.filter { $0.isApagada } }
    
    func isFraca(_ senha: String) -> Bool {
        senha.count < 8
    }
    
    func isReutilizada(_ item: SenhaItem) -> Bool {
        ativas.filter { $0.senha == item.senha }.count > 1
    }
    
    var senhasFracas: [SenhaItem] {
        ativas.filter { isFraca($0.senha) }
    }
    
    var senhasReutilizadas: [SenhaItem] {
        ativas.filter { isReutilizada($0) }
    }
    
    var senhasComProblema: [SenhaItem] {
        let idsComProblema = Set(senhasFracas.map { $0.id }).union(Set(senhasReutilizadas.map { $0.id }))
        return ativas.filter { idsComProblema.contains($0.id) }
    }
    
    func gerarSenhaForte(tamanho: Int = 16) -> String {
        let minusculas = "abcdefghijklmnopqrstuvwxyz"
        let maiusculas = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numeros = "0123456789"
        let simbolos = "!@#$%&*?-_"
        let todos = minusculas + maiusculas + numeros + simbolos
        
        var senha = [
            minusculas.randomElement()!,
            maiusculas.randomElement()!,
            numeros.randomElement()!,
            simbolos.randomElement()!
        ]
        
        for _ in senha.count..<tamanho {
            senha.append(todos.randomElement()!)
        }
        
        return String(senha.shuffled())
    }
}
