//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Leon on 2024/3/15.
//

import SwiftUI
import SwiftData
import Dependencies

struct RecipeDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let recipe: Recipe
    
    var body: some View {
        List {
            Section {
                if let image = recipe.viewImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .hidden()
                        .listRowBackground(
                            Image(uiImage: image)
                                .resizable())
                }
                LabeledContent("Category", value: "\(recipe.viewCategory)")
                LabeledContent("Minutes to Cook", value: "\(recipe.minutesToCook)")
                LabeledContent("Serving Size", value: "\(recipe.servingSize)")
                
                NavigationLink("Ingredients") {
                    IngredientDetailView(recipe: recipe)
                }
                NavigationLink("Instructions") {
                    StepDetailView(recipe: recipe)
                }
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
        .navigationTitle(recipe.name)
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
        RecipeDetailView(recipe: recipes[0])
    }
}
