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
    
    var category: Category?
    
    init(name: String, image: Data? = nil, category: Category? = nil) {
        self.name = name
        self.image = image
        self.category = category
    }
}
