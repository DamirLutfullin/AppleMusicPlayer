//
//  SearchModels.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 24.03.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

enum Search {
   
  enum Model {
    struct Request {
      enum RequestType {
        case some
        case getTracks (searchText: String)
      }
    }
    struct Response {
      enum ResponseType {
        case some
        case presentTraks (searchResponse: SearchResponse?)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case some
        case displayTraks (searchViewModel: SearchViewModel)
      }
    }
  }
}

struct SearchViewModel {
    struct Cell {
        var iconUrlString: String?
        var trackName: String
        var collectionName: String?
        var artistName: String
    }
    
    let cells: [Cell]
}
