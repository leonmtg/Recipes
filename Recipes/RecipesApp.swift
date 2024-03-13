//
//  RecipesApp.swift
//  Recipes
//
//  Created by Leon on 2024/3/13.
//

import SwiftUI
import Dependencies

@main
struct RecipesApp: App {
    @Dependency(\.database) var database
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
