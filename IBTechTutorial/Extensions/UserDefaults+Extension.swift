//
//  UserDefaults+Extension.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import Foundation

extension UserDefaults {
    @objc dynamic var favorites: [Int] {
        get {
            return UserDefaults.standard.array(forKey: Constants.favoritesUserDefaultsKey) as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.favoritesUserDefaultsKey)
        }
    }
}
