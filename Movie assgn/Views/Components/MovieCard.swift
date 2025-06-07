//
//  MovieCard.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
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
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .frame(width: 120)
    }
}

#Preview {
    MovieCard(movie: Movie(
        id: 1,
        title: "Sample Movie",
        overview: "A great movie",
        posterPath: nil,
        backdropPath: nil,
        releaseDate: "2024-01-01",
        voteAverage: 8.5,
        voteCount: 1000,
        popularity: 100.0
    ))
}
