//
//  StepsView.swift
//  Recipes
//
//  Created by Leon on 2024/3/18.
//

import SwiftUI
import SwiftData
import Dependencies

struct StepsView: View {
    @Environment(\.modelContext) private var modelContext
    let recipe: Recipe
    var editMode = false
    
    var body: some View {
        List {
            ForEach(recipe.viewSortedSteps) { step in
                @Bindable var step = step
                if editMode {
                    VStack {
                        Stepper(value: $step.stepNumber) {
                            Image(systemName: "\(step.stepNumber).square")
                                .font(.title)
                        }
                        
                        TextField("instruction", text: $step.instruction, axis: .vertical)
                            .lineLimit(10)
                    }
                    .id(step.stepNumber)
                } else {
                    Label(step.instruction, systemImage: "\(step.stepNumber).square")
                }
            }
            .onDelete(perform: editMode ? delete : nil)
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
        .toolbar {
            if editMode {
                Button("", systemImage: "plus") {
                    let stepNumber = recipe.steps.count+1
                    recipe.steps.append(
                        Step(
                            stepNumber: stepNumber,
                            instruction: ""
                        )
                    )
                }
            }
        }
    }
    
    func delete(indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(recipe.viewSortedSteps[index])
        }
    }
}

#Preview("Normal Mode") {
    @Dependency(\.database) var database
    let container = database.modelContainer()
    
    let recipes = try! container.mainContext.fetch(
        FetchDescriptor<Recipe>(predicate: #Predicate { recipe in
            recipe.name == "Lobster Bisque"
        }))
    
    return NavigationStack {
        StepsView(recipe: recipes[0])
    }
}

#Preview("Edit Mode") {
    @Dependency(\.database) var database
    let container = database.modelContainer()
    
    let recipes = try! container.mainContext.fetch(
        FetchDescriptor<Recipe>(predicate: #Predicate { recipe in
            recipe.name == "Lobster Bisque"
        }))
    
    return NavigationStack {
        StepsView(recipe: recipes[0], editMode: true)
    }
}
