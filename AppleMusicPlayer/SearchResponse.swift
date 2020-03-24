//
//  Track.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 20.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

// MARK: - Response
struct SearchResponse: Decodable {
    let resultCount: Int?
    let results: [Tracks]
}

// MARK: - Result
struct Tracks: Decodable {
    let artistName: String
    let trackName: String
    let collectionName: String
    let artworkUrl100: String?
}


