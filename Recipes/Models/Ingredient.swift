//
//  Ingredient.swift
//  Recipes
//
//  Created by Leon on 2024/3/13.
//

import Foundation
import SwiftData

@Model
class Ingredient {
    var name: String
    var recipes: [Recipe] = []
    
    init(name: String, recipes: [Recipe] = []) {
        self.name = name
        self.recipes = recipes
    }
}
