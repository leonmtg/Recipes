//
//  Database.swift
//  Recipes
//
//  Created by Leon on 2024/3/13.
//

import Foundation
import Dependencies
import SwiftData
import UIKit

struct Database {
    var modelContainer: @MainActor () -> ModelContainer
}

extension Database: DependencyKey {
    static let liveValue = Self(
        modelContainer: { onlyMemoryModelContainer }
    )
    
    static let previewValue = Self(
        modelContainer: { onlyMemoryModelContainer }
    )
    
    static let testValue = Self(
        modelContainer: { onlyMemoryModelContainer }
    )
}

extension DependencyValues {
    var database: Database {
        get { self[Database.self] }
        set { self[Database.self] = newValue }
    }
}

private let schema: Schema = {
    Schema([Recipe.self])
}()

@MainActor
fileprivate let directoryModelContainer: ModelContainer = {
    do {
        let url = URL.applicationSupportDirectory.appending(path: "Model.sqlite")
        let config = ModelConfiguration(url: url)
        let container = try ModelContainer(for: schema, configurations: config)
        return container
    } catch {
        fatalError("Failed to create container!")
    }
}()

@MainActor
let onlyMemoryModelContainer: ModelContainer = {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: config)
        
        // MARK: - Categories
        let soups = Category(name: "Soups")
        let desserts = Category(name: "Desserts")
        let mainDishes = Category(name: "Main Dishes")
        container.mainContext.insert(soups)
        container.mainContext.insert(desserts)
        container.mainContext.insert(mainDishes)
        try? container.mainContext.save()
        
        // MARK: - Recipes
        // Soups
        let lobsterBisque = Recipe(name: "Lobster Bisque", image: UIImage(resource: .lobsterBisque).pngData()!, minutesToCook: 90, servingSize: 6, category: soups)
        container.mainContext.insert(lobsterBisque)
        let chickenNoodleSoup = Recipe(name: "Chicken Noodle Soup", image: UIImage(resource: .chickenNoodleSoup).pngData()!, minutesToCook: 50, servingSize: 6, category: soups)
        container.mainContext.insert(chickenNoodleSoup)
        let tomatoBasilSoup = Recipe(name: "Tomato Basil Soup", image: UIImage(resource: .tomatoBasilSoup).pngData()!, minutesToCook: 30, servingSize: 6, category: soups)
        container.mainContext.insert(tomatoBasilSoup)
        let vegetableMinestrone = Recipe(name: "Vegetable Minestrone", image: UIImage(resource: .vegetableMinestrone).pngData()!, minutesToCook: 40, servingSize: 6, category: soups)
        container.mainContext.insert(vegetableMinestrone)
        
        // Desserts
        let applePie = Recipe(name: "Apple Pie", image: UIImage(resource: .applePie).pngData()!, minutesToCook: 75, servingSize: 8, category: desserts)
        container.mainContext.insert(applePie)
        let chocolateCake = Recipe(name: "Chocolate Cake", image: UIImage(resource: .chocolateCake).pngData()!, minutesToCook: 60, servingSize: 8, category: desserts)
        container.mainContext.insert(chocolateCake)
        let strawberryCheesecake = Recipe(name: "Strawberry Cheesecake", image: UIImage(resource: .strawberryCheesecake).pngData()!, minutesToCook: 70, servingSize: 8, category: desserts)
        container.mainContext.insert(strawberryCheesecake)
        
        // Main Dishes
        let grilledSalmon = Recipe(name: "Grilled Salmon", image: UIImage(resource: .grilledSalmon).pngData()!, minutesToCook: 40, servingSize: 3, category: mainDishes)
        container.mainContext.insert(grilledSalmon)
        let spaghettiBolognese = Recipe(name: "Spaghetti Bolognese", image: UIImage(resource: .spaghettiBolognese).pngData()!, minutesToCook: 80, servingSize: 4, category: mainDishes)
        container.mainContext.insert(spaghettiBolognese)
        let chickenParmesan = Recipe(name: "Chicken Parmesan", image: UIImage(resource: .chickenParmesan).pngData()!, minutesToCook: 120, servingSize: 2, category: mainDishes)
        container.mainContext.insert(chickenParmesan)
        try? container.mainContext.save()

        // MARK: - Ingredients
        let lobster = Ingredient(name: "Lobster", quantity: "2")
        let butter = Ingredient(name: "Butter", quantity: "3 tablespoons")
        let onion = Ingredient(name: "Onion", quantity: "1")
        let carrots = Ingredient(name: "Carrots", quantity: "2")
        let tomatoPaste = Ingredient(name: "Tomato Paste", quantity: "2 tablespoons")
        let chickenBroth = Ingredient(name: "Chicken Broth", quantity: "1 (14.5 ounce) can")
        let salt = Ingredient(name: "Salt", quantity: "⅛ teaspoon")
        let cayennePepper = Ingredient(name: "Cayenne Pepper", quantity: "⅛ teaspoon")
        let halfAndHalf = Ingredient(name: "Half-and-Half", quantity: "1 ½ cups")
        let whiteWine = Ingredient(name: "Dry White Wine", quantity: "½ cup")
        let mushrooms = Ingredient(name: "Mushrooms", quantity: "¼ cup")
        let celery = Ingredient(name: "Celery", quantity: "½ cup")
        let chicken = Ingredient(name: "Chicken")
        let noodles = Ingredient(name: "Noodles")
        let tomato = Ingredient(name: "Tomato")
        let basil = Ingredient(name: "Basil")
        let vegetables = Ingredient(name: "Vegetables")
        let apple = Ingredient(name: "Apple")
        let chocolate = Ingredient(name: "Chocolate")
        let strawberry = Ingredient(name: "Strawberry")
        let salmon = Ingredient(name: "Salmon")
        let spaghetti = Ingredient(name: "Spaghetti")
        let parmesan = Ingredient(name: "Parmesan")
        
        // Adding ingredients to the recipes
        lobsterBisque.ingredients = [lobster, butter, onion, carrots, tomatoPaste, chickenBroth, salt, cayennePepper, halfAndHalf, whiteWine, mushrooms, celery]
        chickenNoodleSoup.ingredients = [chicken, noodles]
        tomatoBasilSoup.ingredients = [tomato, basil]
        vegetableMinestrone.ingredients = [vegetables]
        applePie.ingredients = [apple]
        chocolateCake.ingredients = [chocolate]
        strawberryCheesecake.ingredients = [strawberry]
        grilledSalmon.ingredients = [salmon]
        spaghettiBolognese.ingredients = [spaghetti]
        chickenParmesan.ingredients = [chicken, parmesan]
        
        try? container.mainContext.save()
        
        // MARK: - Steps
        let step1 = Step(stepNumber: 1, instruction: "Bring a large pot of water to boil. Add lobster tails to water, and boil until cooked through and bright red.")
        let step2 = Step(stepNumber: 2, instruction: "Using tongs, transfer lobsters to a large bowl. Reserve 2 cups of cooking liquid, saving as much loose lobster meat with it.")
        let step3 = Step(stepNumber: 3, instruction: "Cool lobster tails by running under cool water. Crack the shells and remove the meat.")
        let step4 = Step(stepNumber: 4, instruction: "Melt the butter in a large saucepan. Gently fry the onion, garlic, celery, and carrot and cook until softened, which takes about 5 minutes.")
        let step5 = Step(stepNumber: 5, instruction: "Turn up the heat, tip in the lobster shells and stir vigorously for 2 minutes. Pour in the wine, giving it a stir then let it bubble until the liquid has halved.")
        let step6 = Step(stepNumber: 6, instruction: "Pour vegetable and broth mixture into the container of a blender, and add 1/4 cup of the lobster meat. Cover, and process until smooth.")
        let step7 = Step(stepNumber: 7, instruction: "Return to the saucepan, and stir in half-and-half, white wine, and remaining lobster meat. Cook over low heat, stirring frequently until thickened, about 30 minutes.")
        let step8 = Step(stepNumber: 8, instruction: "Just before serving, add the reserved lobster tail meat and chopped claw/leg meat to the pot. Heat through until the lobster is warmed but not overcooked.")
        let step9 = Step(stepNumber: 9, instruction: "Stir in 2 tablespoons of brandy or cognac and a pinch of cayenne pepper for a hint of spice. Taste and adjust seasoning as desired. Ladle the bisque into bowls and garnish with fresh chives.")
        
        lobsterBisque.steps = [step1, step2, step3, step4, step5, step6, step7, step8, step9]
        
        try? container.mainContext.save()
        
        return container
    } catch {
        fatalError("Failed to create container.")
    }
}()
