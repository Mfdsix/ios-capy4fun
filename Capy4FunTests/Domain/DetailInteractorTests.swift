//
//  DetailInteractorTests.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Capy4Fun

class DetailInteractorTests: XCTestCase {

    static var mockCapybara: CapybaraModel = CapybaraModel(
        id: "D1",
        title: "Detail Capy",
        image: "url",
        description: "Detail Deskripsi",
        isFavorite: false
    )

    let mockRepository = HomeInteractorTests.CapybaraRepositoryMock(
        capybarasToReturn: [mockCapybara]
    )

    func testGetCapybaraReturnsInjectedData() throws {
        let interactor = DetailInteractor(
            repository: mockRepository,
            capybara: DetailInteractorTests.mockCapybara
        )
        let result = interactor.getCapybara()

        XCTAssertEqual(result.id, "D1")
        XCTAssertEqual(result.title, "Detail Capy")
        XCTAssertEqual(result.isFavorite, false)
    }

    func testAddToFavoriteCallsRepositoryAndReturnsSuccess() throws {
        let interactor = DetailInteractor(
            repository: mockRepository,
            capybara: DetailInteractorTests.mockCapybara
        )

        let resultObservable = interactor.addToFavorite()

        do {
            let result = try resultObservable.toBlocking().first()
            XCTAssertEqual(result, true, "Observable should return true upon success.")
        } catch {
            XCTFail("Blocking failed with error: \(error)")
        }
    }

    func testRemoveFromFavoriteCallsRepositoryAndReturnsSuccess() throws {
        let interactor = DetailInteractor(
            repository: mockRepository,
            capybara: DetailInteractorTests.mockCapybara
        )
        let resultObservable = interactor.removeFromFavorite()

        do {
            let result = try resultObservable.toBlocking().first()
            XCTAssertEqual(result, true, "Observable should return true upon success.")
        } catch {
            XCTFail("Blocking failed with error: \(error)")
        }
    }
}
