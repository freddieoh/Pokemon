//
//  PokemonMapsViewController.swift
//  Pokemon
//
//  Created by Fredrick Ohen on 11/1/16.
//  Copyright © 2016 geeoku. All rights reserved.
//

import UIKit
import MapKit
import CloudKit

class PokemonMapsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, AddNewPokemonViewControllerDelegate  {

    @IBOutlet weak var pokemonMapView: MKMapView!
    var pokemons: [Pokemon]!
    var locationManager: CLLocationManager!
    var container :CKContainer!
    var publicDB :CKDatabase!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    self.container = CKContainer.default()
    self.publicDB = self.container.publicCloudDatabase
        
        // Find your location
    
        self.locationManager = CLLocationManager()
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        
        self.locationManager.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        
        self.pokemonMapView.showsUserLocation = true
        self.pokemonMapView.delegate = self
        
        self.locationManager.startUpdatingLocation()
        
    //Sets the zoom
//        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.050, 0.050)
//        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(29.735101, -95.390524)
//        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//        self.pokemonMapView.setRegion(region, animated: true)
        
        
        self.pokemons = [Pokemon]()
        
        populatePokemons()
}
    
    func populatePokemons() {
        
        let pokemonQuery = CKQuery(recordType: "Pokemon", predicate: NSPredicate(value: true))
        
        self.publicDB.perform(pokemonQuery, inZoneWith: nil) { (records: [CKRecord]?, error: Error?) in
            
            for record in records! {
                
                let pokemon = Pokemon()
                pokemon.record = record
                pokemon.name = record.value(forKey: "Name") as! String
                pokemon.longitude = record.value(forKey: "Longitude") as! Double
                pokemon.latitude = record.value(forKey: "Latitude") as! Double
                
                self.pokemons.append(pokemon)
                
                let pokemonAnnotation = PokemonAnnotation()
                pokemonAnnotation.title = pokemon.name
                pokemonAnnotation.coordinate = CLLocationCoordinate2DMake(pokemon.latitude, pokemon.longitude)
                pokemonAnnotation.pokemonPinImage = pokemon.imageURL
                
                DispatchQueue.main.async {
                    self.pokemonMapView.addAnnotation(pokemonAnnotation)
                }
                
                
            }
            
            
        }

    }

    func addNewPokemonViewControllerDelegateDidAddPokemon(pokemon: Pokemon) {
       
        let pokemonAnnotation = PokemonAnnotation()
        pokemonAnnotation.title = pokemon.name
        pokemonAnnotation.coordinate = CLLocationCoordinate2DMake(pokemon.latitude, pokemon.longitude)
      //  pokemonAnnotation.pokemonPinImage = pokemon.imageURL
        
        DispatchQueue.main.async {
            self.pokemonMapView.addAnnotation(pokemonAnnotation)
        }
        
        
   }
    

    // Delegate method of MapViewControl
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        
//       if annotation is MKUserLocation {
//           return nil
//       }
//        var pokemonAnnotationView = pokemonMapView.dequeueReusableAnnotationView(withIdentifier: "Pokemon-Image")
//        
//        if pokemonAnnotationView == nil {
//            pokemonAnnotationView = PokemonAnnotationView(annotation: annotation, reuseIdentifier: "Pokemon-Image")
//            pokemonAnnotationView?.canShowCallout = true
//        }
//        return pokemonAnnotationView
//   
//    }

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let addNewPokemonVC = segue.destination as! AddNewPokemonViewController
        addNewPokemonVC.delegate = self
       // addNewPokemonVC.pokemon = pokemons
    }
    

}
