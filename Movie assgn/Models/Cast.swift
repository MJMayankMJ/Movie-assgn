//
//  Cast.swift
//  Movie assgn
//
//  Created by Mayank Jangid on 6/7/25.
//

import Foundation

struct Cast: Codable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}
