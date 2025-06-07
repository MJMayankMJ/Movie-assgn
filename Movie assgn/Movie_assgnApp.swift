//
//  Movie_assgnApp.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import SwiftUI

@main
struct MovieExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: SavedMovie.self)
    }
}
