//
//  ContentView.swift
//  Recipes
//
//  Created by Leon on 2024/3/13.
//

import SwiftUI
import Dependencies
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    Section(category.name) {
                        ForEach(category.recipes) { recipe in
                            HStack {
                                Text(recipe.name)
                                    .font(.title2)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                modelContext.delete(category.recipes[index])
                            }
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .headerProminence(.increased)
        }
    }
}

#Preview {
    @Dependency(\.database) var database
    
    return ContentView()
        .modelContainer(database.modelContainer())
}
