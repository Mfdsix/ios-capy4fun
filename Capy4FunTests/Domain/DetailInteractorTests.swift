//
//  DetailInteractorTests.swift
//  Capy4Fun
//
//  Created by Mputh on 13/12/25.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Capy4Fun

final class DetailInteractorTests: XCTestCase {
    
    private var interactor: DetailInteractor!
    private var repository: MockCapybaraRepository!
    private var capybara: Capy4Fun.CapybaraModel!
    
    override func setUp() {
        super.setUp()
        
        capybara = Capy4Fun.CapybaraModel(
            id: "1",
            title: "Capy #1",
            image: "",
            description: "Deskripsi",
            isFavorite: false
        )
        
        repository = MockCapybaraRepository()
        interactor = DetailInteractor(
            repository: repository,
            capybara: capybara
        )
    }
    
    override func tearDown() {
        interactor = nil
        repository = nil
        capybara = nil
        super.tearDown()
    }
    
    // MARK: - getCapybara
    
    func test_getCapybara_returnsInjectedCapybara() {
        // When
        let result = interactor.getCapybara()
        
        // Then
        XCTAssertEqual(result.id, capybara.id)
        XCTAssertEqual(result.title, capybara.title)
        XCTAssertEqual(result.isFavorite, capybara.isFavorite)
    }
    
    // MARK: - addToFavorite
    
    func test_addToFavorite_returnsTrue() throws {
        // When
        let result = try interactor
            .addToFavorite()
            .toBlocking()
            .single()
        
        // Then
        XCTAssertTrue(repository.addToFavoriteCalled)
        XCTAssertTrue(result)
    }
    
    // MARK: - removeFromFavorite
    
    func test_removeFromFavorite_returnsTrue() throws {
        // When
        let result = try interactor
            .removeFromFavorite()
            .toBlocking()
            .single()
        
        // Then
        XCTAssertTrue(repository.removeFromFavoriteCalled)
        XCTAssertTrue(result)
    }
}

final class MockCapybaraRepository: CapybaraRepositoryProtocol {
    
    private(set) var addToFavoriteCalled = false
    private(set) var removeFromFavoriteCalled = false
    
    func getCapybaras() -> Observable<[Capy4Fun.CapybaraModel]> {
        Observable.just([])
    }
    
    func getFavoriteCapybaras() -> Observable<[Capy4Fun.CapybaraModel]> {
        Observable.just([])
    }
    
    func addToFavorite(from capybara: Capy4Fun.CapybaraModel) -> Observable<Bool> {
        addToFavoriteCalled = true
        return Observable.just(true)
    }
    
    func removeFromFavorite(from capybara: Capy4Fun.CapybaraModel) -> Observable<Bool> {
        removeFromFavoriteCalled = true
        return Observable.just(true)
    }
}
