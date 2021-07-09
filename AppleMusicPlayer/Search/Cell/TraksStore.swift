//
//  TraksStore.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 13.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

class TraksStore {
    static var tracksForList: [SearchViewModel.Cell] {
        get {
            let defaults = UserDefaults.standard
            if let savedTracks = defaults.object(forKey: "tracks") as? Data  {
                guard let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTracks) as? [SearchViewModel.Cell] else { return [] }
                return decodedTracks
            } else {
                return []
            }
        }
        
        set {
            let defaults = UserDefaults.standard
            if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false) {
                print("трек \(String(describing: newValue.last?.trackName)) добавлен")
                defaults.set(saveData, forKey: "tracks")
            }
        }
    }
}
