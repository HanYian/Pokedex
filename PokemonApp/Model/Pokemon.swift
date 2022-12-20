//
//  Pokemon.swift
//  PokemonApp
//
//  Created by HanYuan on 2022/12/17.
//

import Foundation

struct Pokemon : Codable {
    let results : [Results]
}
struct Results : Codable {
    let name : String
    let url : String
}
