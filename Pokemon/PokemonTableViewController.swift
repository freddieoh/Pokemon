//
//  PokemonTableViewController.swift
//  Pokemon
//
//  Created by Fredrick Ohen on 10/31/16.
//  Copyright © 2016 geeoku. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    //Creates an array that holds objects of type Pokemon
    var pokemons: [Pokemon]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initalizes array
        self.pokemons = [Pokemon]()

        // Create JSON URL
        let pokemonURL = "https://still-wave-26435.herokuapp.com/pokemon/all"
        
        //Create URL from JSON URL
        let url = URL(string: pokemonURL)
        URLSession.shared.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error? ) in
            
        let result = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
        // Loop JSON Result
        for item in result {
                
        let pokemon = Pokemon()
            pokemon.id = item["id"] as! Int!
            pokemon.name = item["name"] as! String!
            pokemon.imageURL = item["imageURL"] as! String!
                
            self.pokemons.append(pokemon)
           
            }
            //Main is the UI Thread
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }.resume()
    }
    
   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return self.pokemons.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = self.pokemons[indexPath.row]
            cell.textLabel?.text = pokemon.name
            cell.detailTextLabel?.text = "\(pokemon.id!)"
        
        cell.imageView?.image = UIImage(named: "PH")
        
        //Info.plist -> App Transport Security Settings
        // Allow arbitary loads
        //Need to download image in the background thread
        
        DispatchQueue.global().async {
            let imageData = try! Data(contentsOf: URL(string: pokemon.imageURL)!)
            
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: imageData)

            }
        }

        
        return cell
    }

}
