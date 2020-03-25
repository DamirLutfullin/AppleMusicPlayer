//
//  NetworkService.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 23.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    static func fetchTracks(searchText: String, completionHandler: @escaping  (SearchResponse?)  -> ()) {
        
        let url = "https://itunes.apple.com/search?"
        let parameters = ["term" : searchText,
                          "limit" : "30",
                          "media" : "music"]
        
        AF.request(url, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default , headers: nil).response { (response) in
            if let error = response.error {
                print(error.localizedDescription)
                completionHandler(nil)
                return
            }
            guard let data = response.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let response  = try decoder.decode(SearchResponse.self, from: data)
                completionHandler(response)
            } catch let error {
                print(error)
                completionHandler(nil)
            }
        }
    }
}

