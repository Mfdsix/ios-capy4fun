//
//  Injection.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation
import RealmSwift

final class Injection: NSObject {

  private func provideRepository() -> CapybaraRepositoryProtocol {
      let realm = try? Realm()
      let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return CapybaraRepository.sharedInstance(locale, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

    func provideDetail(capybara: CapybaraModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, capybara: capybara)
      }

    func provideFavorite() -> FavoriteUseCase {
      let repository = provideRepository()
      return FavoriteInteractor(repository: repository)
    }

}
