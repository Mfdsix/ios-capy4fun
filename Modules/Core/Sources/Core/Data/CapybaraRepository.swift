//
//  CapyRepository.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation
import RxSwift

public protocol CapybaraRepositoryProtocol {
    
    func getCapybaras() -> Observable<[CapybaraModel]>
    func getFavoriteCapybaras() -> Observable<[CapybaraModel]>
    func addToFavorite(from capybara: CapybaraModel) -> Observable<Bool>
    func removeFromFavorite(from capybara: CapybaraModel) -> Observable<Bool>
    
}

public final class CapybaraRepository: NSObject, CapybaraRepositoryProtocol {

    let locale: LocaleDataSource
    let remote: RemoteDataSource

    public init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
}

extension CapybaraRepository {
    
    public func getCapybaras() -> Observable<[CapybaraModel]> {
        return self.remote.getCapybaras()
            .map { CapybaraMapper.mapResponsesToDomains(input: $0) }
            .flatMap { datas in
                let capybaras = datas.map { data in
                    self.locale.findCapybara(id: data.id)
                        .map { isFav in
                            var capybara = data
                            capybara.isFavorite = isFav
                            return capybara
                        }
                }
                
                return Observable.zip(capybaras)
            }
    }
    
    public func getFavoriteCapybaras() -> Observable<[CapybaraModel]> {
        return self.locale.getFavoriteCapybaras()
            .map { CapybaraMapper.mapEntitiesToDomains(input: $0) }
    }
    
    public func addToFavorite(from capybara: CapybaraModel) -> Observable<Bool> {
        return self.locale.addCapybaraToFavorite(
            from: CapybaraMapper.convertModelToEntity(input: capybara)
        )
    }
    
    public func removeFromFavorite(from capybara: CapybaraModel) -> Observable<Bool> {
        return self.locale.removeCapybaraFromFavorite(from: capybara.id)
    }
}
