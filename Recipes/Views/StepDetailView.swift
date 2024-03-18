//
//  StepDetailView.swift
//  Recipes
//
//  Created by Leon on 2024/3/18.
//

import SwiftUI
import SwiftData
import Dependencies

struct StepDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let recipe: Recipe
    
    var body: some View {
        List {
            ForEach(recipe.viewSortedSteps) { step in
                @Bindable var step = step
                Label(step.instruction, systemImage: "\(step.stepNumber).square")
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
        .navigationTitle("Steps")
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
        StepDetailView(recipe: recipes[0])
    }
}