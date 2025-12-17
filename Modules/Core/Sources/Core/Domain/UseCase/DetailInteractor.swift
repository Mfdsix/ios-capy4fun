//
//  DetailInteractor.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation
import RxSwift

public protocol DetailUseCase {
    
    func getCapybara() -> CapybaraModel
    func addToFavorite() -> Observable<Bool>
    func removeFromFavorite() -> Observable<Bool>
    
}

public class DetailInteractor: DetailUseCase {
    
    private let repository: CapybaraRepositoryProtocol
    private let capybara: CapybaraModel
    
    public required init(
        repository: CapybaraRepositoryProtocol,
        capybara: CapybaraModel
    ) {
        self.repository = repository
        self.capybara = capybara
    }
    
    public func getCapybara() -> CapybaraModel {
        return capybara
    }
    
    public func addToFavorite() -> Observable<Bool> {
        return self.repository.addToFavorite(from: self.capybara)
    }
    
    public func removeFromFavorite() -> Observable<Bool> {
        return self.repository.removeFromFavorite(from: self.capybara)
    }
    
}
