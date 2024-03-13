//
//  Step.swift
//  Recipes
//
//  Created by Leon on 2024/3/13.
//

import Foundation
import SwiftData

@Model
class Step {
    var stepNumber: Int
    var instruction: String
    var recipe: Recipe?
    
    init(stepNumber: Int, instruction: String, recipe: Recipe? = nil) {
        self.stepNumber = stepNumber
        self.instruction = instruction
        self.recipe = recipe
    }
}
