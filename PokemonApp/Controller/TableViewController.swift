//
//  TableViewController.swift
//  PokemonApp
//
//  Created by HanYuan on 2022/12/17.
//

import UIKit
import Kingfisher

class TableViewController: UITableViewController {
    var pokemon = [Results]()
    var pokemonImages = [Images]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        fetchImage()
    }
    
    func fetchImage() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "generated",ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(PokemonImage.self,from: jsonData)
                self.pokemonImages = decodedData.image
            }
        } catch {
            print(error)
        }
        
    }
    
    func fetchData() {
        let urlString = "https://pokeapi.co/api/v2/pokemon/?limit=905"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                let decoder = JSONDecoder()
                if let data {
                    do {
                        let pokemondata = try decoder.decode(Pokemon.self,from: data)
                        self.pokemon = pokemondata.results
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
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
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PokemonCell.self)", for: indexPath) as! PokemonCell
        cell.pokemonName.text = pokemon[indexPath.row].name
        let url = URL(string: pokemonImages[indexPath.row].url)
        cell.pokemonImage.kf.setImage(with:url)
        
        return cell
    }
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> ViewController? {
        let controller = ViewController(coder: coder)
        controller?.detailUrl = pokemon[tableView.indexPathForSelectedRow!.row].url
        return controller
    }
}
