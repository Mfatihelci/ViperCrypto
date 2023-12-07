//
//  Presenter.swift
//  CryptoViper
//
//  Created by Muhammed fatih Elçi on 7.12.2023.
//

import Foundation

//Class,protocol
//talks to -> interactor,router,view

enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    var router : AnyRouter? { get set }
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDowloadCrypto(result: Result<[Crypto],Error>)
}

class CryptoPresenter : AnyPresenter {
    var interactor: AnyInteractor? {
        didSet {
            interactor?.dowloadCryptos()
        }
    }
    var view: AnyView?
    var router: AnyRouter?
    
    func interactorDidDowloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "Try again later...")
        }
    }
}
