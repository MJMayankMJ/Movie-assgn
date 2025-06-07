//
//  SavedMovie.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import Foundation
import SwiftData

@Model
class SavedMovie {
    var id: Int
    var title: String
    var posterPath: String?
    var voteAverage: Double
    var releaseDate: String
    var overview: String
    
    init(id: Int, title: String, posterPath: String?, voteAverage: Double, releaseDate: String, overview: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.overview = overview
    }
}
