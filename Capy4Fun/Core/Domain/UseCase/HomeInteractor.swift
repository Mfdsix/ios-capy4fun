//
//  HomeInteractor.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    
    func getCapybaras() -> Observable<[CapybaraModel]>
    
}

class HomeInteractor: HomeUseCase {
    
    private let repository: CapybaraRepositoryProtocol
    
    required init(repository: CapybaraRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCapybaras() -> Observable<[CapybaraModel]> {
        repository.getCapybaras()
    }
    
}
