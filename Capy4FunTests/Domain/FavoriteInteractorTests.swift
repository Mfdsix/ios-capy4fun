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

final class FavoriteInteractorTests: XCTestCase {
    
    private var interactor: FavoriteInteractor!
    private var repository: MockCapybaraRepository!
    
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
    
    override func setUp() {
        super.setUp()
        repository = MockCapybaraRepository()
        interactor = FavoriteInteractor(repository: repository)
    }
    
    override func tearDown() {
        interactor = nil
        repository = nil
        super.tearDown()
    }
    
    func test_getCapybaras_returnsOnlyFavoriteCapybaras() throws {
        // When
        let result = try interactor
            .getCapybaras()
            .toBlocking()
            .single()
        
        // Then
        XCTAssertTrue(repository.isCalled)
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result.first?.isFavorite == true)
    }
}

extension FavoriteInteractorTests {
    final class MockCapybaraRepository: CapybaraRepositoryProtocol {
        
        private(set) var isCalled = false
        var stubbedResult: Observable<[Capy4Fun.CapybaraModel]>!
        
        func getCapybaras() -> Observable<[Capy4Fun.CapybaraModel]> {
            return stubbedResult
        }
        
        func getFavoriteCapybaras() -> Observable<[Capy4Fun.CapybaraModel]> {
            isCalled = true
            let favorites = FavoriteInteractorTests.mockCapybaras.filter { $0.isFavorite }
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
