//
//  TMDBService.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import Foundation
import SwiftUI

// Contains: API calls, image URL generation, fallback data

class TMDBService: ObservableObject {
    private let apiKey = "MY API KEY"
    private let baseURL = "https://api.themoviedb.org/3"
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    func fetchMovies(endpoint: String) async -> [Movie] {
        guard let url = URL(string: "\(baseURL)\(endpoint)?api_key=\(apiKey)") else {
            return getFallbackMovies(for: endpoint)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(MovieResponse.self, from: data)
            return response.results
        } catch {
            print("Error fetching movies: \(error)")
            return getFallbackMovies(for: endpoint)
        }
    }
    
    func fetchMovieDetails(id: Int) async -> MovieDetails? {
        guard let url = URL(string: "\(baseURL)/movie/\(id)?api_key=\(apiKey)") else {
            return getFallbackMovieDetails()
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let details = try JSONDecoder().decode(MovieDetails.self, from: data)
            return details
        } catch {
            print("Error fetching movie details: \(error)")
            return getFallbackMovieDetails()
        }
    }
    
    func fetchCredits(movieId: Int) async -> Credits? {
        guard let url = URL(string: "\(baseURL)/movie/\(movieId)/credits?api_key=\(apiKey)") else {
            return getFallbackCredits()
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let credits = try JSONDecoder().decode(Credits.self, from: data)
            return credits
        } catch {
            print("Error fetching credits: \(error)")
            return getFallbackCredits()
        }
    }
    
    func fetchSimilarMovies(movieId: Int) async -> [Movie] {
        guard let url = URL(string: "\(baseURL)/movie/\(movieId)/similar?api_key=\(apiKey)") else {
            return getFallbackSimilarMovies()
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(MovieResponse.self, from: data)
            return response.results
        } catch {
            print("Error fetching similar movies: \(error)")
            return getFallbackSimilarMovies()
        }
    }
    
    func getImageURL(path: String?) -> URL? {
        guard let path = path else { return nil }
        return URL(string: "\(imageBaseURL)\(path)")
    }
    
    // MARK: - Fallback Data
    private func getFallbackMovies(for endpoint: String) -> [Movie] {
        switch endpoint {
        case "/movie/now_playing":
            return [
                Movie(id: 950387, title: "A Minecraft Movie", overview: "Four misfits find themselves struggling with ordinary problems when they are suddenly pulled through a mysterious portal into the Overworld: a bizarre, cubic wonderland that thrives on imagination.", posterPath: "/iPPTGh2OXuIv6d7cwuoPkw8govp.jpg", backdropPath: "/2Nti3gYAX513wvhp8IiLL6ZDyOm.jpg", releaseDate: "2025-03-31", voteAverage: 6.1, voteCount: 482, popularity: 824.7134),
                Movie(id: 324544, title: "In the Lost Lands", overview: "A queen sends the powerful and feared sorceress Gray Alys to the ghostly wilderness of the Lost Lands in search of a magical power.", posterPath: "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg", backdropPath: "/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg", releaseDate: "2025-02-27", voteAverage: 5.926, voteCount: 101, popularity: 873.5678)
            ]
        case "/movie/popular":
            return [
                Movie(id: 324544, title: "In the Lost Lands", overview: "A queen sends the powerful and feared sorceress Gray Alys to the ghostly wilderness of the Lost Lands in search of a magical power.", posterPath: "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg", backdropPath: "/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg", releaseDate: "2025-02-27", voteAverage: 6.388, voteCount: 156, popularity: 789.8905),
                Movie(id: 1045938, title: "G20", overview: "After the G20 Summit is overtaken by terrorists, President Danielle Sutton must bring all her statecraft and military experience to defend her family and her fellow leaders.", posterPath: "/tSee9gbGLfqwvjoWoCQgRZ4Sfky.jpg", backdropPath: "/k32XKMjmXMGeydykD32jfER3BVI.jpg", releaseDate: "2025-04-09", voteAverage: 6.449, voteCount: 186, popularity: 687.7088)
            ]
        case "/movie/top_rated":
            return [
                Movie(id: 278, title: "The Shawshank Redemption", overview: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison.", posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", backdropPath: "/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg", releaseDate: "1994-09-23", voteAverage: 8.7, voteCount: 28127, popularity: 45.3817),
                Movie(id: 238, title: "The Godfather", overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family.", posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg", backdropPath: "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg", releaseDate: "1972-03-14", voteAverage: 8.7, voteCount: 21329, popularity: 41.4734)
            ]
        case "/movie/upcoming":
            return [
                Movie(id: 324544, title: "In the Lost Lands", overview: "A queen sends the powerful and feared sorceress Gray Alys to the ghostly wilderness of the Lost Lands in search of a magical power.", posterPath: "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg", backdropPath: "/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg", releaseDate: "2025-02-27", voteAverage: 6.364, voteCount: 147, popularity: 837.1695),
                Movie(id: 950387, title: "A Minecraft Movie", overview: "Four misfits find themselves struggling with ordinary problems when they are suddenly pulled through a mysterious portal into the Overworld.", posterPath: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", backdropPath: "/2Nti3gYAX513wvhp8IiLL6ZDyOm.jpg", releaseDate: "2025-03-31", voteAverage: 6.077, voteCount: 523, popularity: 695.7057)
            ]
        default:
            return []
        }
    }
    
    private func getFallbackMovieDetails() -> MovieDetails {
        return MovieDetails(
            id: 950387,
            title: "A Minecraft Movie",
            overview: "Four misfits find themselves struggling with ordinary problems when they are suddenly pulled through a mysterious portal into the Overworld: a bizarre, cubic wonderland that thrives on imagination.",
            posterPath: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg",
            backdropPath: "/2Nti3gYAX513wvhp8IiLL6ZDyOm.jpg",
            releaseDate: "2025-03-31",
            voteAverage: 6.08,
            runtime: 101,
            genres: [
                Genre(id: 10751, name: "Family"),
                Genre(id: 35, name: "Comedy"),
                Genre(id: 12, name: "Adventure"),
                Genre(id: 14, name: "Fantasy")
            ]
        )
    }
    
    private func getFallbackCredits() -> Credits {
        return Credits(
            cast: [
                Cast(id: 117642, name: "Jason Momoa", character: "Garrett", profilePath: "/6dEFBpZH8C8OijsynkSajQT99Pb.jpg"),
                Cast(id: 70851, name: "Jack Black", character: "Steve", profilePath: "/9QKdFKfc3Zi5XwnQHrFukFMpo5o.jpg"),
                Cast(id: 2680307, name: "Sebastian Eugene Hansen", character: "Henry", profilePath: "/40HNkoB3RKPMPgLhTyKQU6kG0sc.jpg")
            ],
            crew: [
                Crew(id: 1, name: "Sample Director", job: "Director", department: "Directing")
            ]
        )
    }
    
    private func getFallbackSimilarMovies() -> [Movie] {
        return [
            Movie(id: 446893, title: "Trolls World Tour", overview: "Queen Poppy and Branch make a surprising discovery -- there are other Troll worlds beyond their own.", posterPath: "/7W0G3YECgDAfnuiHG91r8WqgIOe.jpg", backdropPath: "/qsxhnirlp7y4Ae9bd11oYJSX59j.jpg", releaseDate: "2020-03-11", voteAverage: 7.285, voteCount: 2165, popularity: 8.1483)
        ]
    }
}
