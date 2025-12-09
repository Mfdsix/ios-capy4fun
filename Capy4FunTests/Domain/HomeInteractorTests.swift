//
//  HomeInteractor.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import XCTest
import RxBlocking
import RxSwift

@testable import Capy4Fun
class HomeInteractorTests: XCTestCase {

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

    func testGetDataFromRepository() throws {
        let mockRepository = CapybaraRepositoryMock(
            capybarasToReturn: HomeInteractorTests.mockCapybaras
        )
        let interactor = HomeInteractor(repository: mockRepository)
        let resultObservable = interactor.getCapybaras()

        XCTAssert(mockRepository.verify())

        do {
            guard let result = try resultObservable.toBlocking().first() else {
                XCTFail("Observable should emit at least one element.")
                return
            }

            print("oke", result)
            XCTAssertEqual(result.count, HomeInteractorTests.mockCapybaras.count)

            XCTAssertEqual(result.first?.title, "Capy #1")

        } catch {
            XCTFail("Blocking failed with error: \(error)")
        }
    }
}

extension HomeInteractorTests {

    class CapybaraRepositoryMock: CapybaraRepositoryProtocol {

        var functionWasCalled = false
        let capybarasToReturn: [CapybaraModel]

        init(capybarasToReturn: [CapybaraModel]) {
            self.capybarasToReturn = capybarasToReturn
        }

        func getCapybaras() -> Observable<[CapybaraModel]> {
            functionWasCalled = true
            return Observable.just(capybarasToReturn)
        }

        func getFavoriteCapybaras() -> Observable<[CapybaraModel]> {
            let favorites = capybarasToReturn.filter { $0.isFavorite }
            return Observable.just(favorites)
        }

        func addToFavorite(from capybara: CapybaraModel) -> Observable<Bool> {
            return Observable.just(true)
        }

        func removeFromFavorite(from capybara: CapybaraModel) -> Observable<Bool> {
            return Observable.just(true)
        }

        func verify() -> Bool {
            return functionWasCalled
        }
    }
}
