//
//  ContentView.swift
//  Recipes
//
//  Created by Leon on 2024/3/13.
//

import SwiftUI
import Dependencies

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    @Dependency(\.database) var database
    
    return ContentView()
        .modelContainer(database.modelContainer())
}
