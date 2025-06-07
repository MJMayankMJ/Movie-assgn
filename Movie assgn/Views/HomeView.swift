//
//  HomeView.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import SwiftUI

//to display Now Playing, Popular, Top Rated, Upcoming
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    if viewModel.isLoading {
                        ProgressView("Loading Movies...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        MovieSection(title: "🎬 Now Playing", movies: viewModel.nowPlayingMovies)
                        MovieSection(title: "🌟 Popular", movies: viewModel.popularMovies)
                        MovieSection(title: "🏆 Top Rated", movies: viewModel.topRatedMovies)
                        MovieSection(title: "⏳ Upcoming", movies: viewModel.upcomingMovies)
                    }
                }
                .padding()
            }
            .navigationTitle("Movies")
            .task {
                await viewModel.loadAllMovies()
            }
        }
    }
}

#Preview {
    HomeView()
}
