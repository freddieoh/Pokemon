//
//  PokemonMapsViewController.swift
//  Pokemon
//
//  Created by Fredrick Ohen on 11/1/16.
//  Copyright © 2016 geeoku. All rights reserved.
//

import UIKit
import MapKit

class PokemonMapsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {

@IBOutlet weak var pokemonMapView: MKMapView!
var pokemons: [Pokemon]!
var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.050, 0.050)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(29.735101, -95.390524)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.pokemonMapView.setRegion(region, animated: true)
        
        self.pokemons = [Pokemon]()
        
        //Creates the JSON URL
        let pokemonURL = "https://still-wave-26435.herokuapp.com/pokemon/all"
        
        let url = URL(string: pokemonURL)
        URLSession.shared.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error? ) in
            
        let result = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
        for item in result {
                
        let pokemon = Pokemon()
            pokemon.latitude = item["latitude"] as! Double!
            pokemon.longitude = item["longitude"] as! Double!
            pokemon.imageURL = item ["imageURL"] as! String!
            
    //Populate Pokemon on Map
        let annotation = PokemonAnnotation()
            annotation.title = pokemon.name
            annotation.coordinate = CLLocationCoordinate2DMake(pokemon.latitude, pokemon.longitude)
            annotation.pokemonPinImage = pokemon.imageURL
            
        self.pokemons.append(pokemon)
            
        DispatchQueue.main.async {
            self.pokemonMapView.addAnnotation(annotation)
                
            }
            }
        }.resume()
    }
    
//    // Delegate method of MapViewControl
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
       if annotation is MKUserLocation {
           return nil
       }
        var pokemonAnnotationView = self.pokemonMapView.dequeueReusableAnnotationView(withIdentifier: "Pokemon-Image")
        
        if pokemonAnnotationView == nil {
            pokemonAnnotationView = PokemonAnnotationView(annotation: annotation, reuseIdentifier: "Pokemon-Image")
            pokemonAnnotationView?.canShowCallout = true
        }
        return pokemonAnnotationView
   
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
