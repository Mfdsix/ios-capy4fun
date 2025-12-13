//
//  DetailInteractor.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    
    func getCapybara() -> CapybaraModel
    func addToFavorite() -> Observable<Bool>
    func removeFromFavorite() -> Observable<Bool>
    
}

class DetailInteractor: DetailUseCase {
    
    private let repository: CapybaraRepositoryProtocol
    private let capybara: CapybaraModel
    
    required init(
        repository: CapybaraRepositoryProtocol,
        capybara: CapybaraModel
    ) {
        self.repository = repository
        self.capybara = capybara
    }
    
    func getCapybara() -> CapybaraModel {
        return capybara
    }
    
    func addToFavorite() -> Observable<Bool> {
        return self.repository.addToFavorite(from: self.capybara)
    }
    
    func removeFromFavorite() -> Observable<Bool> {
        return self.repository.removeFromFavorite(from: self.capybara)
    }
    
}
