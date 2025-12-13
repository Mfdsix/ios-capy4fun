//
//  Injection.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import RealmSwift
import Swinject

final class Injection {
    
    static let shared = Injection()
    let container: Container
    
    private init() {
        container = Container()
        registerDependencies()
        registerPresenters()
    }
    
    private func registerDependencies() {
        
        container.register(Realm.self) { _ in
            try! Realm()
        }.inObjectScope(.container)
        
        container.register(LocaleDataSource.self) { resolver in
            let realm = resolver.resolve(Realm.self)!
            return LocaleDataSource.sharedInstance(realm)
        }.inObjectScope(.container)
        
        container.register(RemoteDataSource.self) { _ in
            RemoteDataSource.sharedInstance
        }.inObjectScope(.container)
        
        container.register(CapybaraRepositoryProtocol.self) { resolver in
            let locale = resolver.resolve(LocaleDataSource.self)!
            let remote = resolver.resolve(RemoteDataSource.self)!
            return CapybaraRepository.sharedInstance(locale, remote)
        }.inObjectScope(.container)
        
        container.register(HomeUseCase.self) { resolver in
            HomeInteractor(
                repository: resolver.resolve(CapybaraRepositoryProtocol.self)!
            )
        }
        
        container.register(FavoriteUseCase.self) { resolver in
            FavoriteInteractor(
                repository: resolver.resolve(CapybaraRepositoryProtocol.self)!
            )
        }
        
        container.register(DetailUseCase.self) { resolver, capybara in
            DetailInteractor(
                repository: resolver.resolve(CapybaraRepositoryProtocol.self)!,
                capybara: capybara
            )
        }
    }
}

extension Injection {
    func registerPresenters() {
        container.register(HomePresenter.self) { resolver in
            HomePresenter(
                homeUseCase: resolver.resolve(HomeUseCase.self)!
            )
        }
        container.register(FavoritePresenter.self) { resolver in
            FavoritePresenter(
                favoriteUseCase: resolver.resolve(FavoriteUseCase.self)!
            )
        }
        container.register(DetailPresenter.self) { (resolver: Resolver, capybara: CapybaraModel) in
            DetailPresenter(
                detailUseCase: resolver.resolve(
                    DetailUseCase.self,
                    argument: capybara
                )!
            )
        }
    }
}
