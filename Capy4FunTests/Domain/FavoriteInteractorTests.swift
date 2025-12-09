//
//  FavoriteInteractorTests.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Capy4Fun

class FavoriteInteractorTests: XCTestCase {

    static var mockCapybaras: [CapybaraModel] = [
        CapybaraModel(
            id: "1",
            title: "Capy #1",
            image: "",
            description: "Deskripsi 1",
            isFavorite: false
        ),
        CapybaraModel(
            id: "2",
            title: "Capy #2",
            image: "",
            description: "Deskripsi 2",
            isFavorite: true
        )
    ]

    func testGetFavoritesFromRepository() throws {
        let mockRepository = HomeInteractorTests.CapybaraRepositoryMock(
            capybarasToReturn: FavoriteInteractorTests.mockCapybaras
        )
        let interactor = FavoriteInteractor(repository: mockRepository)
        let resultObservable = interactor.getCapybaras()

        do {
            guard let result = try resultObservable.toBlocking().first() else {
                XCTFail("Observable should emit at least one element.")
                return
            }

            XCTAssertEqual(result.count, 1, "Should only return one favorite item.")

            XCTAssertEqual(result.first?.id, "2")
            XCTAssertEqual(result.first?.title, "Capy #2")

        } catch {
            XCTFail("Blocking failed with error: \(error)")
        }
    }
}
