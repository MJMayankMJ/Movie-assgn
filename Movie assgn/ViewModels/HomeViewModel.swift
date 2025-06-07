//
//  HomeViewModel.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import SwiftUI

// Handles: Loading all 4 movie categories, loading states
@MainActor
class HomeViewModel: ObservableObject {
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var isLoading = false
    
    private let tmdbService = TMDBService()
    
    func loadAllMovies() async {
        isLoading = true
        
        async let nowPlaying = tmdbService.fetchMovies(endpoint: "/movie/now_playing")
        async let popular = tmdbService.fetchMovies(endpoint: "/movie/popular")
        async let topRated = tmdbService.fetchMovies(endpoint: "/movie/top_rated")
        async let upcoming = tmdbService.fetchMovies(endpoint: "/movie/upcoming")
        
        let results = await (nowPlaying, popular, topRated, upcoming)
        
        nowPlayingMovies = results.0
        popularMovies = results.1
        topRatedMovies = results.2
        upcomingMovies = results.3
        
        isLoading = false
    }
}

