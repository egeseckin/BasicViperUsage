//
//  Router.swift
//  BasicViperUsage
//
//  Created by Ege Seçkin on 4.06.2022.
//

import Foundation
import UIKit

// Talks to -> Presenter

// Routes inside app, navigation, entryPoint etc.

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? {get set}
    static func startExecution() -> AnyRouter
}

class BasicRouter : AnyRouter {
    var entry: EntryPoint?
    static func startExecution() -> AnyRouter {
        
        let router = BasicRouter()
        
        var view: AnyView = BasicViewController()
        var presenter: AnyPresenter = BasicPresenter()
        var interactor: AnyInteractor = BasicInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
        
    }
    
    
}
