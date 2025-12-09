//
//  CapyRepository.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation
import RxSwift

protocol CapybaraRepositoryProtocol {

    func getCapybaras() -> Observable<[CapybaraModel]>
    func getFavoriteCapybaras() -> Observable<[CapybaraModel]>
    func addToFavorite(from capybara: CapybaraModel) -> Observable<Bool>
    func removeFromFavorite(from capybara: CapybaraModel) -> Observable<Bool>

}

final class CapybaraRepository: NSObject {

    typealias CapybaraInstance = (LocaleDataSource, RemoteDataSource) -> CapybaraRepository

    fileprivate let locale: LocaleDataSource
    fileprivate let remote: RemoteDataSource

    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }

    static let sharedInstance: CapybaraInstance = { localeRepo, remoteRepo in
        return CapybaraRepository(locale: localeRepo, remote: remoteRepo)
    }

}

extension CapybaraRepository: CapybaraRepositoryProtocol {

    func getCapybaras() -> Observable<[CapybaraModel]> {
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

    func getFavoriteCapybaras() -> Observable<[CapybaraModel]> {
        return self.locale.getFavoriteCapybaras()
            .map { CapybaraMapper.mapEntitiesToDomains(input: $0) }
    }

    func addToFavorite(from capybara: CapybaraModel) -> Observable<Bool> {
        return self.locale.addCapybaraToFavorite(
            from: CapybaraMapper.convertModelToEntity(input: capybara)
        )
    }

    func removeFromFavorite(from capybara: CapybaraModel) -> Observable<Bool> {
        return self.locale.removeCapybaraFromFavorite(from: capybara.id)
    }
}
