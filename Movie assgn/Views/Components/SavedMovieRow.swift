//
//  SavedMovieRow.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import SwiftUI

struct SavedMovieRow: View {
    let savedMovie: SavedMovie
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: TMDBService().getImageURL(path: savedMovie.posterPath)) { image in
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
            .frame(width: 60, height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(savedMovie.title)
                    .font(.headline)
                    .lineLimit(2)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    Text(String(format: "%.1f", savedMovie.voteAverage))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(savedMovie.releaseDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

//MARK: - fix preview

#Preview {
    SavedMovieRow(savedMovie: SavedMovie(
        id: 278,
        title: "The Shawshank Redemption",
        posterPath: "/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
        voteAverage: 9.3,
        releaseDate: "1994-09-23",
        overview: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency."
    ))
    .padding()
}
