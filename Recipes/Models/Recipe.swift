//
//  Recipe.swift
//  Recipes
//
//  Created by Leon on 2024/3/13.
//

import Foundation
import SwiftData

@Model
class Recipe {
    var name: String
    var image: Data?
    
    init(name: String, image: Data? = nil) {
        self.name = name
        self.image = image
    }
}
