//
//  AddNewPokemonViewController.swift
//  Pokemon
//
//  Created by Fredrick Ohen on 11/7/16.
//  Copyright © 2016 geeoku. All rights reserved.
//

import UIKit

class AddNewPokemonViewController: UIViewController {

   
    @IBOutlet weak var newPokemonTextField: UITextField!
    
    @IBOutlet weak var longitudeTextField: UITextField!
    
    
    @IBOutlet weak var latitudeTextField: UITextField!
    
    
    
    @IBAction func saveNewPokemonButtonPressed() {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
