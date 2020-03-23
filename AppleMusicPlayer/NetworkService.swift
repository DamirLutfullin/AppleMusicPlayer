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
    
    static func getResponse(url: String, parameters: [String: String], completionHandler: @escaping  ([Result]?)  -> ()) {
        
        AF.request(url, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default , headers: nil).response { (response) in
            if let error = response.error {
                print(error.localizedDescription)
                completionHandler(nil)
                return
            }
            guard let data = response.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let result  = try decoder.decode(Response.self, from: data).results
                completionHandler(result)
            } catch let error {
                print(error)
                completionHandler(nil)
            }
        }
    }
}

