//
//  RecipesApp.swift
//  Recipes
//
//  Created by Leon on 2024/3/13.
//

import SwiftUI
import Dependencies
import SwiftData

@main
struct RecipesApp: App {
    @Dependency(\.database) var database
    
    var body: some Scene {
        WindowGroup {
            RecipesView()
                .modelContainer(database.modelContainer())
        }
    }
}
