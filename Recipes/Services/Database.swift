//
//  Database.swift
//  Recipes
//
//  Created by Leon on 2024/3/13.
//

import Foundation
import Dependencies
import SwiftData

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
        return container
    } catch {
        fatalError("Failed to create container.")
    }
}()
