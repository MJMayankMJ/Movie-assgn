//
//  ContentView.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import SwiftUI
import SwiftData

// Root View -> HomeView & MyListView

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            MyListView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("My List")
                }
        }
        .modelContainer(for: SavedMovie.self)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SavedMovie.self, inMemory: true)
}
