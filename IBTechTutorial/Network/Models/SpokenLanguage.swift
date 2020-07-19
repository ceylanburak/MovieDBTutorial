//
//  SpokenLanguage.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import Foundation

class SpokenLanguage: Codable {
    var iso6391: String!
    var name: String!
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case name
    }
}
