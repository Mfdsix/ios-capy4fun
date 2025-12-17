//
//  HomeInteractor.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation
import RxSwift

public protocol FavoriteUseCase {
    
    func getCapybaras() -> Observable<[CapybaraModel]>
    
}

public class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: CapybaraRepositoryProtocol
    
    public required init(repository: CapybaraRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getCapybaras() -> Observable<[CapybaraModel]> {
        repository.getFavoriteCapybaras()
    }
    
}
