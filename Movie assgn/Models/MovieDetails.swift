//
//  MovieDetails.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import Foundation

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double
    let runtime: Int?
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, genres
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
