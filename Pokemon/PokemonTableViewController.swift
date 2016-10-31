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
        
        //Info.plist -> App Transport Security Settings
        // Allow arbitary loads
        let imageData = try! Data(contentsOf: URL(string: pokemon.imageURL)!)
          cell.imageView?.image = UIImage(data: imageData)
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
