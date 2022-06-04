//
//  Presenter.swift
//  BasicViperUsage
//
//  Created by Ege Seçkin on 4.06.2022.
//

import Foundation

// Talks to -> View, Interactor, Router

enum NetworkError: Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidDownload(result: Result<[Crypto], Error>)
}

class BasicPresenter : AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadData()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownload(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "Failed to download")
        }
    }
    
}
