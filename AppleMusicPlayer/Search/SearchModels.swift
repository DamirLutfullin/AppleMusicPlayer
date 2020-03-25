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
        case getTracks (searchText: String)
      }
    }
    struct Response {
      enum ResponseType {
        case presentTraks (searchResponse: SearchResponse?)
        case presentFooterView
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayTraks (searchViewModel: SearchViewModel)
        case displayFooterView
      }
    }
  }
}

struct SearchViewModel {
    struct Cell: TrackCellViewModel {
        var iconUrlString: String?
        var trackName: String
        var artistName: String
        var collectionName: String?
        var previewUrl: String?
    }
    
    var cells: [Cell]
}
