//
//  EditRecipeView.swift
//  Recipes
//
//  Created by Leon on 2024/3/18.
//

import SwiftUI
import Dependencies
import SwiftData

struct EditRecipeView: View {
    @Bindable var recipe: Recipe
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
