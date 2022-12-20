//
//  PokemonDetail.swift
//  PokemonApp
//
//  Created by HanYuan on 2022/12/19.
//

import Foundation
struct PokemonDetail : Codable {
    let name : String
    let id : Int
    let sprites : Sprites
    let stats : [Stats]
    let types : [Types]
}
struct Sprites : Codable {
    let other : Other
}
struct Other : Codable {
    let officialArtwork : OfficialArtwork
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}
struct OfficialArtwork : Codable {
    let frontDefault : String
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
struct Stats : Codable {
    let baseStat : Int
    let stat : Stat
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}
struct Stat : Codable {
    let name : String
}
struct Types : Codable {
    let type : Type
}
struct Type : Codable {
    let name : String
}
