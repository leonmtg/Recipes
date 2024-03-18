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
    var quantity: String = ""
    var recipes: [Recipe] = []
    
    init(name: String, quantity: String = "", recipes: [Recipe] = []) {
        self.name = name
        self.quantity = quantity
        self.recipes = recipes
    }
}

extension Ingredient {
    var viewIngredient: String {
        if quantity.isEmpty {
            return name
        } else {
            return "\(quantity) \(name)"
        }
    }
}
