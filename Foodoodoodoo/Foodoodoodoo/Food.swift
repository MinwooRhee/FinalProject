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
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let saveURL = documentDirectory.appendingPathExtension("food").appendingPathExtension("plist")
    
    static func loadSampleRecipe() -> [Food] {
        let Foods = [Food(name: "Kimchi", detailDescription: "Rich in probiotics.")]
        return Foods
    }
}
