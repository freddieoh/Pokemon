//
//  AddNewPokemonViewController.swift
//  Pokemon
//
//  Created by Fredrick Ohen on 11/7/16.
//  Copyright © 2016 geeoku. All rights reserved.
//

import UIKit
import CloudKit

protocol AddNewPokemonViewControllerDelegate {
    
    func addNewPokemonViewControllerDelegateDidAddPokemon(pokemon: Pokemon)

}


class AddNewPokemonViewController: UIViewController {

    var pokemon: [Pokemon]!
    
    @IBOutlet weak var newPokemonTextField: UITextField!
    
    @IBOutlet weak var longitudeTextField: UITextField!
 
    @IBOutlet weak var latitudeTextField: UITextField!
    
    var delegate: AddNewPokemonViewControllerDelegate! 

    var container: CKContainer!
    var publicDB: CKDatabase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pokemon = [Pokemon]()
        
        self.container = CKContainer.default()
        self.publicDB = self.container.publicCloudDatabase
        
        
    }
    
    @IBAction func cancelNewPokemonButtonPressed() {
        self.dismiss(animated: true, completion: nil)
        }
   
    
    @IBAction func addNewPokemonButtonPressed() {
        
        savePokemon()
        self.dismiss(animated: true, completion: nil)
    }
    
    //Populate pokemon using CloudKit
        
    func savePokemon() {
    
            let pokemonLongitude = Double(self.longitudeTextField.text!)
            let pokemonLatitude = Double(self.latitudeTextField.text!)
       
           let record = CKRecord(recordType: "Pokemon")
            record.setValue("Pickachu", forKey: "Name")
            record.setValue(pokemonLongitude, forKey: "Longitude")
            record.setValue(pokemonLatitude, forKey: "Latitude")
        
            self.publicDB.save(record, completionHandler: { (record :CKRecord?, error :Error?) in
          
            let pokemon = Pokemon()
            pokemon.name = record?.value(forKey: "Name") as! String
            pokemon.latitude = record?.value(forKey: "Latitude") as! Double
            pokemon.longitude = record?.value(forKey: "Longitude") as! Double
            
            self.delegate.addNewPokemonViewControllerDelegateDidAddPokemon(pokemon: pokemon)
            
        })

}

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
