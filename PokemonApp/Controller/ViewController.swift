//
//  ViewController.swift
//  PokemonApp
//
//  Created by HanYuan on 2022/12/19.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    var detailUrl = String()
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var specialDefence: UILabel!
    @IBOutlet weak var specialAttack: UILabel!
    @IBOutlet weak var defence: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var hp: UILabel!
    
    @IBOutlet weak var type2: UILabel!
    @IBOutlet weak var type1: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    func backgroundColor(type: String) -> UIColor {
        switch type {
        case "fire": return .systemRed
        case "water": return .systemBlue
        case "grass": return .systemGreen
        case "electric": return .systemYellow
        case "psychic": return UIColor(red: 220/255, green: 80/255, blue: 121/255, alpha: 1)
        case "poison": return UIColor(red: 135/255, green: 70/255, blue: 196/255, alpha: 1)
        case "normal": return UIColor(red: 159/255, green: 161/255, blue: 159/255, alpha: 1)
        case "ground": return UIColor(red: 136/255, green: 84/255, blue: 43/255, alpha: 1)
        case "flying": return UIColor(red: 141/255, green: 183/255, blue: 234/255, alpha: 1)
        case "fairy": return UIColor(red: 223/255, green: 119/255, blue: 233/255, alpha: 1)
        case "rock": return UIColor(red: 174/255, green: 169/255, blue: 133/255, alpha: 1)
        case "fighting": return UIColor(red: 239/255, green: 135/255, blue: 51/255, alpha: 1)
        case "ghost": return UIColor(red: 105/255, green: 67/255, blue: 109/255, alpha: 1)
        case "dragon": return UIColor(red: 83/255, green: 96/255, blue: 217/255, alpha: 1)
        case "ice": return UIColor(red: 112/255, green: 213/255, blue: 251/255, alpha: 1)
        case "bug": return UIColor(red: 148/255, green: 161/255, blue: 56/255, alpha: 1)
        case "steel": return UIColor(red: 111/255, green: 159/255, blue: 181/255, alpha: 1)
        case "dark": return UIColor(red: 78/255, green: 66/255, blue: 63/255, alpha: 1)
        default: return .systemIndigo
        }
    }
    
    func fetchData() {
        let urlString = detailUrl
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                let decoder = JSONDecoder()
                if let data {
                    do {
                        let pokemonData = try decoder.decode(PokemonDetail.self,from: data)
                        DispatchQueue.main.async {
                            self.updateUI(pokemonData: pokemonData)
                        }
                    } catch {
                        print(error)
                    }
                } else {
                    print(error!)
                }
            }.resume()
        }
    }
    
    func updateUI(pokemonData: PokemonDetail) {
        let imageUrl = URL(string: pokemonData.sprites.other.officialArtwork.frontDefault)
        self.image.kf.setImage(with:imageUrl)
        self.name.text = pokemonData.name
        self.id.text = "#\(pokemonData.id)"
        
        if pokemonData.types.count == 2 {
            self.type1.text = pokemonData.types[0].type.name
            self.type2.text = pokemonData.types[1].type.name
            type1.backgroundColor = backgroundColor(type: type1.text!)
            type2.backgroundColor = backgroundColor(type: type2.text!)
        } else {
            self.type1.text = pokemonData.types[0].type.name
            self.type2.isHidden = true
            type1.frame.origin = CGPoint(x: 119, y: 131)
            type1.backgroundColor = backgroundColor(type: type1.text!)
            
        }
        self.hp.text = "\(pokemonData.stats[0].baseStat)"
        self.attack.text = "\(pokemonData.stats[1].baseStat)"
        self.defence.text = "\(pokemonData.stats[2].baseStat)"
        self.specialAttack.text = "\(pokemonData.stats[3].baseStat)"
        self.specialDefence.text = "\(pokemonData.stats[4].baseStat)"
        self.speed.text = "\(pokemonData.stats[5].baseStat)"
    }
}
