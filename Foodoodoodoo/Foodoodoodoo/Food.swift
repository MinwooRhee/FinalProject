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
    var detailDescription: String
    var type: String
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let saveURL = documentDirectory.appendingPathExtension("food").appendingPathExtension("plist")
    
    static func loadSampleRecipe() -> [Food] {
        let foods = [Food(name: "Kimchi", detailDescription: "Rich in probiotics.", type: "appetizer"), Food(name: "Kimchi pancake", detailDescription: "Rich in probiotics.", type: "entree"), Food(name: "Kimchi Udon", detailDescription: "Rich in probiotics.", type: "entree"), Food(name: "Kimchi Sorbet", detailDescription: "Rich in probiotics.", type: "dessert")]
        return foods
    }
}
