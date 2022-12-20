//
//  PokemonImage.swift
//  PokemonApp
//
//  Created by HanYuan on 2022/12/17.
//

import Foundation

struct PokemonImage : Codable {
    let image : [Images]
}
struct Images : Codable {
    let url : String
}
