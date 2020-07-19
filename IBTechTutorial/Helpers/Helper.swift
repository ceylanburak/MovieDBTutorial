//
//  Helper.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import UIKit
import Foundation

class Helper {
    class func roundScreenWidth(with width: CGFloat, _ rule: FloatingPointRoundingRule = .up) -> Int {
        let value = width / 100
        let multipler = value.rounded(rule)
        return Int(multipler *  100)
    }
    
    class func addToFavorites(with id: Int) {
        var favorites = UserDefaults.standard.favorites
        favorites.append(id)
        UserDefaults.standard.favorites = favorites
    }
    
    class func removeFromFavorites(with id: Int) {
        var favorites: [Int] = UserDefaults.standard.favorites

        if let index = favorites.firstIndex(where: { (value) -> Bool in
            value == id
        }) {
            favorites.remove(at: index)
            UserDefaults.standard.favorites = favorites
        }
    }
    
    class func isFavorite(with id: Int) -> Bool {
        let favorites = UserDefaults.standard.favorites
        return favorites.contains(id)
    }
}
