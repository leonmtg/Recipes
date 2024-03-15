//
//  Category.swift
//  Recipes
//
//  Created by Leon on 2024/3/15.
//

import Foundation
import SwiftData

@Model
class Category {
    var name: String
    @Relationship(inverse: \Recipe.category)
    var recipes: [Recipe] = []
    
    init(name: String, recipes: [Recipe] = []) {
        self.name = name
        self.recipes = recipes
    }
}
