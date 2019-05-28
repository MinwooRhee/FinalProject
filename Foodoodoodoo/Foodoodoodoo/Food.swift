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
        let foods = [Food(name: "Kimchi", ingredients: "veggie", steps: "Rich in probiotics.", type: "appetizer"), Food(name: "Kimchi pancake", ingredients: "veggie", steps: "Rich in probiotics.", type: "entree"), Food(name: "Kimchi Udon", ingredients: "veggie", steps: "Rich in probiotics.", type: "entree"), Food(name: "Kimchi Sorbet", ingredients: "veggie", steps: "Rich in probiotics.", type: "dessert")]
        return foods
    }
}
