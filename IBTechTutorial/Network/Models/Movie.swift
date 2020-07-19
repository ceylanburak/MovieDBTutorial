//
//  Movie.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import Foundation

class Movie: Codable {
    var popularity: Double!
    var voteCount: Int!
    var isVideo: Bool!
    var posterPath: String!
    var id: Int!
    var isAdult: Bool!
    var backdropPath: String!
    var originalLanguage: String!
    var originalTitle: String!
    var genreIds: [Int]!
    var title: String!
    var voteAverage: Double!
    var overview: String!
    var releaseDate: String!
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case isVideo = "video"
        case posterPath = "poster_path"
        case id
        case isAdult = "adult"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
