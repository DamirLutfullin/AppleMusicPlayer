//
//  SearchPresenter.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 24.03.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentData(response: Search.Model.Response.ResponseType) {
        switch response {
        case .some:
            print("some")
        case .presentTraks(let searchResults):
          let cells = searchResults?.results.map({ (track)  in
                cellViewModel(from: track)
            }) ?? []
          
        let searchViewModel = SearchViewModel(cells: cells)
            viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTraks(searchViewModel: searchViewModel))
            
        }
    }
    
    private func cellViewModel(from traks: Tracks) -> SearchViewModel.Cell {
        
        
        return SearchViewModel.Cell.init(iconUrlString: traks.artworkUrl100,
                                         trackName: traks.trackName,
                                         collectionName: traks.collectionName ,
                                         artistName: traks.artistName)
    }
}
