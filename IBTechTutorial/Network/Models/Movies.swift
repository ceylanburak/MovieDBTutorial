//
//  Movies.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import Foundation

class Movies: Codable {
    var page: Int!
    var totalResults: Int!
    var totalPages: Int!
    var results: [Movie]!
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
