//
//  MovieSection.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import SwiftUI

struct MovieSection: View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            MovieCard(movie: movie)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    MovieSection(title: "🎬 Now Playing", movies: [
            Movie(id: 1, title: "Sample Movie", overview: "A great movie", posterPath: nil, backdropPath: nil, releaseDate: "2024-01-01", voteAverage: 8.5, voteCount: 1000, popularity: 100.0)
        ])
}
