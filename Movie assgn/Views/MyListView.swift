//
//  MyListView.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import SwiftUI
import SwiftData

// Shows saved movies in a list format with delete functionality

struct MyListView: View {
    @Query private var savedMovies: [SavedMovie]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            if savedMovies.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "heart")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("No movies in your list")
                        .font(.title2)
                        .foregroundColor(.gray)
                    Text("Add movies from the Home tab")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            } else {
                List {
                    ForEach(savedMovies, id: \.id) { savedMovie in
                        SavedMovieRow(savedMovie: savedMovie)
                    }
                    .onDelete(perform: deleteMovies)
                }
            }
        }
        .navigationTitle("My List")
    }
    
    private func deleteMovies(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(savedMovies[index])
            }
            
            do {
                try modelContext.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}

#Preview {
    MyListView()
        .modelContainer(for: SavedMovie.self, inMemory: true)
}
