# Movie Explorer App 🎬

A SwiftUI-based iOS application that allows users to browse movies from The Movie Database (TMDB) API and manage their personal watchlist.

## 📱 Features

### Home Tab
- **🎬 Now Playing**: Current movies in theaters
- **🌟 Popular**: Most popular movies
- **🏆 Top Rated**: Highest rated movies
- **⏳ Upcoming**: Soon-to-be-released movies

### Movie Details
- Complete movie information including poster, title, rating, and overview
- Cast and crew information
- Director details
- Similar movies recommendations
- Add/Remove from personal list functionality

### My List Tab
- Personal collection of saved movies
- Swipe-to-delete functionality
- Persistent local storage using SwiftData

## 🏗 Architecture

The app follows the **MVVM (Model-View-ViewModel)** pattern with clear separation of concerns:

### Models (M)
- `Movie`: Main movie data model from TMDB API
- `SavedMovie`: SwiftData model for local persistence
- `MovieDetails`: Detailed movie information
- `Credits`, `Cast`, `Crew`: Cast and crew data models
- `Genre`: Movie genre information

### ViewModels (VM)
- `HomeViewModel`: Manages state for the Home tab
- `MovieDetailViewModel`: Handles movie details, credits, and similar movies

### Views (V)
- `ContentView`: Main app container with TabView
- `HomeView`: Home screen with movie sections
- `MovieDetailView`: Detailed movie information screen
- `MyListView`: Personal movie collection
- `MovieCard`: Reusable movie card component
- `MovieSection`: Horizontal scrolling movie sections

### Service Layer
- `TMDBService`: Handles all TMDB API communication and fallback data

### Prerequisites
- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

### API Configuration
Replace the `apiKey` in `TMDBService.swift`

## 🎯 Project Structure

```
MovieExplorerApp/
├── Models/
│   ├── Movie.swift
│   ├── SavedMovie.swift
│   ├── MovieDetails.swift
│   ├── Credits.swift
│   └── Genre.swift
├── ViewModels/
│   ├── HomeViewModel.swift
│   └── MovieDetailViewModel.swift
├── Views/
│   ├── ContentView.swift
│   ├── HomeView.swift
│   ├── MovieDetailView.swift
│   ├── MyListView.swift
│   ├── MovieCard.swift
│   ├── MovieSection.swift
│   └── SavedMovieRow.swift
├── Services/
│   └── TMDBService.swift
└── MovieExplorerApp.swift
```

## 🔄 Data Flow

1. **App Launch**: `ContentView` initializes with SwiftData model container
2. **Home Tab**: `HomeViewModel` fetches movies from TMDB API
3. **Movie Selection**: Navigation to `MovieDetailView` with selected movie
4. **Movie Details**: `MovieDetailViewModel` loads detailed information
5. **Save Movie**: User can add/remove movies from personal list
6. **My List**: `MyListView` displays saved movies from SwiftData

## ⚡ Performance Optimizations

- **Lazy Loading**: `LazyVStack` and `LazyHStack` for efficient scrolling
- **Async Image Loading**: Non-blocking image downloads with placeholders
- **Concurrent API Calls**: Multiple endpoints fetched simultaneously
- **Memory Management**: Proper use of `@StateObject` and `@ObservedObject`


## 📱 Screenshots
<img width="363" alt="Screenshot 2025-06-07 at 13 52 34" src="https://github.com/user-attachments/assets/8879812c-0c40-4411-a079-ebe75ba7455c" />
<img width="358" alt="Screenshot 2025-06-07 at 13 53 04" src="https://github.com/user-attachments/assets/ce1fa743-3f0a-475e-aad9-96f28fc0472c" />
<img width="352" alt="Screenshot 2025-06-07 at 13 53 31" src="https://github.com/user-attachments/assets/c4d8fa47-7750-458c-a105-31a6605121e5" />
<img width="369" alt="Screenshot 2025-06-07 at 13 53 46" src="https://github.com/user-attachments/assets/7c8aa160-09f2-4e16-909d-4b828dbda23e" />
