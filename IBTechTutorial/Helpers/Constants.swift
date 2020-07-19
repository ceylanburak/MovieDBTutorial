//
//  Constants.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let imageCache = NSCache<NSString, UIImage>()

    static let apiKey = "11459cff1c1ce00e3202addab99f3a91"
    static var favoritesUserDefaultsKey = "favoritesUserDefaultsKey"
    
    struct URLs {
        static let baseUrl = "https://api.themoviedb.org/3/movie/"
        static let moviesUrl = baseUrl + "top_rated?api_key=" + apiKey + "&language=en-us&page="
        static let posterImageBaseUrl = "https://image.tmdb.org/t/p/w"

    }
}
