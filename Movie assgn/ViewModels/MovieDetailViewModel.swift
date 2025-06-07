//
//  MovieDetailViewModel.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import SwiftUI

// Handles: Movie details, credits, similar movies, cast/crew data

@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    @Published var credits: Credits?
    @Published var similarMovies: [Movie] = []
    @Published var isLoading = false
    
    private let tmdbService = TMDBService()
    
    func loadMovieDetails(movieId: Int) async {
        isLoading = true
        
        async let details = tmdbService.fetchMovieDetails(id: movieId)
        async let movieCredits = tmdbService.fetchCredits(movieId: movieId)
        async let similar = tmdbService.fetchSimilarMovies(movieId: movieId)
        
        let results = await (details, movieCredits, similar)
        
        movieDetails = results.0
        credits = results.1
        similarMovies = results.2
        
        isLoading = false
    }
    
    func getDirector() -> String? {
        credits?.crew.first(where: { $0.job == "Director" })?.name
    }
    
    func getMainCast() -> [Cast] {
        Array(credits?.cast.prefix(5) ?? [])
    }
}
