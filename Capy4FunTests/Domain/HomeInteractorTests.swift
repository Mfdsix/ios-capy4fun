//
//  FavoriteInteractorTests.swift
//  Capy4Fun
//
//  Created by Mputh on 13/12/25.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Capy4Fun

final class HomeInteractorTests: XCTestCase {

    private var interactor: HomeInteractor!
    private var repository: MockCapybaraRepository!

    override func setUp() {
        super.setUp()
        repository = MockCapybaraRepository()
        interactor = HomeInteractor(repository: repository)
    }

    override func tearDown() {
        interactor = nil
        repository = nil
        super.tearDown()
    }
    
    static var mockCapybaras: [Capy4Fun.CapybaraModel] = [
        Capy4Fun.CapybaraModel(
                id: "1",
                title: "Capy #1",
                image: "",
                description: "Deskripsi 1",
                isFavorite: false
            ),
        Capy4Fun.CapybaraModel(
                id: "2",
                title: "Capy #2",
                image: "",
                description: "Deskripsi 2",
                isFavorite: true
            )
        ]

    func test_getCapybaras_whenSuccess_returnsCapybaraList() throws {

        repository.stubbedResult = Observable.just(HomeInteractorTests.mockCapybaras)

        // When
        let result = try interactor
            .getCapybaras()
            .toBlocking()
            .single()

        // Then
        XCTAssertTrue(repository.isCalled)
        XCTAssertEqual(result.count, HomeInteractorTests.mockCapybaras.count)
        XCTAssertEqual(result.first?.id, HomeInteractorTests.mockCapybaras.first?.id)
    }
}

extension HomeInteractorTests {
    final class MockCapybaraRepository: CapybaraRepositoryProtocol {
        
        private(set) var isCalled = false
        var stubbedResult: Observable<[Capy4Fun.CapybaraModel]>!
        
        func getCapybaras() -> Observable<[Capy4Fun.CapybaraModel]> {
            isCalled = true
            return stubbedResult
        }
        
        func getFavoriteCapybaras() -> Observable<[Capy4Fun.CapybaraModel]> {
            let favorites = HomeInteractorTests.mockCapybaras.filter { $0.isFavorite }
            return Observable.just(favorites)
        }
        
        func addToFavorite(from capybara: Capy4Fun.CapybaraModel) -> Observable<Bool> {
            return Observable.just(true)
        }
        
        func removeFromFavorite(from capybara: Capy4Fun.CapybaraModel) -> Observable<Bool> {
            return Observable.just(true)
        }
    }

}
