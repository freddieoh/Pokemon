//
//  PokemonAnnotationView.swift
//  Pokemon
//
//  Created by Fredrick Ohen on 11/1/16.
//  Copyright © 2016 geeoku. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier:String?)
    {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let pokemonAnnotation = annotation as! PokemonAnnotation
        
        let imageData = try! Data(contentsOf: URL(string: pokemonAnnotation.pokemonPinImage)!)
        
        let image = UIImage(data: imageData)
        let imageView = UIImageView(image:image)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        self.addSubview(imageView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
