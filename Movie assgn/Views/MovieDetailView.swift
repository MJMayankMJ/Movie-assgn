//
//  MovieDetailView.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import SwiftUI
import SwiftData

// Shows full movie information, cast, crew, similar movies, and save functionality
struct MovieDetailView: View {
    let movie: Movie
    @StateObject private var viewModel = MovieDetailViewModel()
    @Query private var savedMovies: [SavedMovie]
    @Environment(\.modelContext) private var modelContext
    
    var isMovieSaved: Bool {
        savedMovies.contains { $0.id == movie.id }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header with poster and basic info
                HStack(alignment: .top, spacing: 16) {
                    AsyncImage(url: TMDBService().getImageURL(path: movie.posterPath)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            )
                    }
                    .frame(width: 120, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", movie.voteAverage))
                                .fontWeight(.medium)
                        }
                        
                        Text(movie.releaseDate)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Button(action: toggleSavedStatus) {
                            HStack {
                                Image(systemName: isMovieSaved ? "heart.fill" : "heart")
                                Text(isMovieSaved ? "Remove from My List" : "Add to My List")
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(isMovieSaved ? Color.red : Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                // Overview
                VStack(alignment: .leading, spacing: 8) {
                    Text("Overview")
                        .font(.headline)
                    Text(movie.overview)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)
                
                // Cast and Director
                if let credits = viewModel.credits {
                    VStack(alignment: .leading, spacing: 12) {
                        if let director = viewModel.getDirector() {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Director")
                                    .font(.headline)
                                Text(director)
                                    .font(.body)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Cast")
                                .font(.headline)
                            ForEach(viewModel.getMainCast(), id: \.id) { actor in
                                Text("\(actor.name) as \(actor.character)")
                                    .font(.body)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Similar Movies
                if !viewModel.similarMovies.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Similar Movies")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 12) {
                                ForEach(viewModel.similarMovies) { similarMovie in
                                    NavigationLink(destination: MovieDetailView(movie: similarMovie)) {
                                        MovieCard(movie: similarMovie)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadMovieDetails(movieId: movie.id)
        }
    }
    
    private func toggleSavedStatus() {
        if isMovieSaved {
            if let savedMovie = savedMovies.first(where: { $0.id == movie.id }) {
                modelContext.delete(savedMovie)
            }
        } else {
            let newSavedMovie = SavedMovie(
                id: movie.id,
                title: movie.title,
                posterPath: movie.posterPath,
                voteAverage: movie.voteAverage,
                releaseDate: movie.releaseDate,
                overview: movie.overview
            )
            modelContext.insert(newSavedMovie)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

#Preview {
    NavigationView {
        MovieDetailView(movie: Movie(
            id: 1,
            title: "Sample Movie",
            overview: "A great movie with an amazing storyline that will keep you engaged throughout.",
            posterPath: nil,
            backdropPath: nil,
            releaseDate: "2024-01-01",
            voteAverage: 8.5,
            voteCount: 1000,
            popularity: 100.0
        ))
    }
    .modelContainer(for: SavedMovie.self, inMemory: true)
}
