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
    @Relationship(deleteRule: .cascade, inverse: \Ingredient.recipes) var ingredients: [Ingredient] = []
    @Relationship(deleteRule: .cascade, inverse: \Step.recipe) var steps: [Step] = []
    
    init(name: String, image: Data? = nil, category: Category? = nil, ingredients: [Ingredient] = [], steps: [Step] = []) {
        self.name = name
        self.image = image
        self.category = category
        self.ingredients = ingredients
        self.steps = steps
    }
}
