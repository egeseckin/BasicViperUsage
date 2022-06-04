//
//  Interactor.swift
//  BasicViperUsage
//
//  Created by Ege Seçkin on 4.06.2022.
//

import Foundation

// Talks to -> presenter

protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}
    
    func downloadData()
}

class BasicInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    func downloadData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownload(result: .failure((NetworkError.NetworkFailed)))
                return
            }
            do {
                let datas = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownload(result: .success(datas))
            } catch {
                self?.presenter?.interactorDidDownload(result: .failure(NetworkError.ParsingFailed))
            }
        }
        task.resume()
    }
    
}
