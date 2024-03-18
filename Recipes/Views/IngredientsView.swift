//
//  IngredientsView.swift
//  Recipes
//
//  Created by Leon on 2024/3/18.
//

import SwiftUI
import SwiftData
import Dependencies

struct IngredientsView: View {
    @Environment(\.modelContext) private var modelContext
    let recipe: Recipe
    
    var body: some View {
        List {
            ForEach(recipe.viewSortedIngredients) { ingredient in
                @Bindable var ingredient = ingredient
                Text(ingredient.viewIngredient)
            }
            .listRowBackground(Color.primary.opacity(0.05))
        }
        .scrollContentBackground(.hidden)
        .background(.regularMaterial)
        .background {
            if let image = recipe.viewImage {
                Image(uiImage: image)
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.5)
            } else {
                Image("RecipeApp")
                    .opacity(0.5)
            }
        }
        .navigationTitle("Ingredients")
    }
}

#Preview {
    @Dependency(\.database) var database
    let container = database.modelContainer()
    
    let recipes = try! container.mainContext.fetch(
        FetchDescriptor<Recipe>(predicate: #Predicate { recipe in
            recipe.name == "Lobster Bisque"
        }))
    
    return NavigationStack {
        IngredientsView(recipe: recipes[0])
    }
}
