//
//  Recipe.swift
//  Recipes
//
//  Created by Leon on 2024/3/13.
//

import Foundation
import SwiftData
import UIKit

@Model
class Recipe {
    var name: String
    var image: Data?
    
    var minutesToCook: Int = 0
    var servingSize: Int = 1
    
    var category: Category?
    @Relationship(deleteRule: .cascade, inverse: \Ingredient.recipes) var ingredients: [Ingredient] = []
    @Relationship(deleteRule: .cascade, inverse: \Step.recipe) var steps: [Step] = []
    
    init(name: String, image: Data? = nil, minutesToCook: Int = 0, servingSize: Int = 1, category: Category? = nil, ingredients: [Ingredient] = [], steps: [Step] = []) {
        self.name = name
        self.image = image
        self.minutesToCook = minutesToCook
        self.servingSize = servingSize
        self.category = category
        self.ingredients = ingredients
        self.steps = steps
    }
}

extension Recipe {
    var viewImage: UIImage? {
        guard let image else { return nil }
        return UIImage(data: image)
    }
    var viewImageWithDefault: UIImage {
        guard let image else { return UIImage(systemName: "fork.knife.circle")! }
        return UIImage(data: image) ?? UIImage(systemName: "fork.knife.circle")!
    }
    var viewCategory: String {
        category?.name ?? ""
    }
}
