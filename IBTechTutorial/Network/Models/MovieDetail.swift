//
//  MovieDetail.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import Foundation

class MovieDetail: Codable {
    var isAdult: Bool!
    var backdropPath : String!
    var budget: Int!
    var genres: [Genre]!
    var homepage: String!
    var id: Int!
    var imdbId: String!
    var originalLanguage: String!
    var originalTitle: String!
    var overview: String!
    var popularity: Double!
    var posterPath: String!
//    var productionCompanies: [ProductionCompany]!
//    var productionCountries: [ProductionCountry]!
    var releaseDate: String!
    var revenue: Int!
    var runtime: Int!
    var spokenLanguages: [SpokenLanguage]
    var status: String!
    var tagline: String!
    var title: String!
    var isVideo: Bool!
    var voteAverage: Double!
    var voteCount: Int!
    
    enum CodingKeys: String, CodingKey {
        case isAdult = "adult"
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
//        case productionCompanies = "production_companies"
//        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case isVideo = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
