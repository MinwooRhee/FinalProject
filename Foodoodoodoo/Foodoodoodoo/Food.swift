//
//  Food.swift
//  Foodoodoodoo
//
//  Created by Min Woo on 5/13/19.
//  Copyright © 2019 Min Woo. All rights reserved.
//

import Foundation



struct Food: Codable {
    
    var name: String
    var ingredients: String
    var steps: String
    var type: String
    // appetizer or entree or dessert
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let saveURL = documentDirectory.appendingPathExtension("foods").appendingPathExtension("plist")
    
    static func saveFoods(foods: [Food]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedFoods = try? propertyListEncoder.encode(foods)
        try? encodedFoods?.write(to: saveURL, options: .noFileProtection)
        
    }
    static func loadFoods() -> [Food]? {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedFoods = try? Data(contentsOf: saveURL){
            if let decodedFoods = try? propertyListDecoder.decode(Array<Food>?.self, from: retrievedFoods) {
                return decodedFoods
            }
        }
        return nil
    }
    
    static func loadSampleRecipe() -> [Food] {
        let foods = [Food(name: "Kimchi", ingredients: "veggies, hot pepper, salt", steps: "1. put veggies in salt water 2. put pepper and leave it for long time", type: "appetizer"), Food(name: "Kimchi pancake", ingredients: "kimchi, wheat flour", steps: "1. put kimchi in flour 2. cook on a pan", type: "entree"), Food(name: "Kimchi Udon", ingredients: "kimchi, udon noodles", steps: "1. put kimchi and udon noodles in water 2. boil", type: "entree"), Food(name: "Kimchi Sorbet", ingredients: "frozen kimchi", steps: "1. put frozen kimchi in sorbet machine", type: "dessert")]
        return foods
        // load sample recipes
    }
}
