//
//  EditRecipeView.swift
//  Recipes
//
//  Created by Leon on 2024/3/18.
//

import SwiftUI
import Dependencies
import SwiftData
import PhotosUI

struct EditRecipeView: View {
    @Bindable var recipe: Recipe
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        Form {
            Section("Details") {
                TextField("Recipe Name", text: $recipe.name)
                TextField("Minutes to Cook", value: $recipe.minutesToCook, formatter: NumberFormatter())
                TextField("Serving Size", value: $recipe.servingSize, formatter: NumberFormatter())
                HStack {
                    if let image = recipe.viewImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(.rect(cornerRadius: 8))
                            .shadow(radius: 2)
                    } else {
                        Image(systemName: "image")
                    }
                    PhotosPicker(
                        "Select Image",
                        selection: $selectedPhoto,
                        matching: .images,
                        photoLibrary: .shared()
                    )
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.bordered)
                }
            }
            .listRowBackground(Color.primary.opacity(0.05))

            Section {
                NavigationLink("Edit Ingredients") {
                    IngredientsView(recipe: recipe, editMode: true)
                }
                NavigationLink("Edit Steps") {
                    StepsView(recipe: recipe, editMode: true)
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
        .navigationTitle("Edit Recipe")
        .headerProminence(.increased)
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                recipe.image = data
            }
        }
    }
}

#Preview {
    @Dependency(\.database) var database
    let container = database.modelContainer()
    
    let recipes = try! container.mainContext.fetch(FetchDescriptor<Recipe>())
    
    return NavigationStack {
        EditRecipeView(recipe: recipes[0])
    }
}
