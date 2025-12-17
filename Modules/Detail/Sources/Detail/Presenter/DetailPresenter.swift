//
//  DetailPresenter.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Core
import SwiftUI
import Combine
import RxSwift

public class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    private let disposeBag = DisposeBag()
    
    @Published var capybara: CapybaraModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    public init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        capybara = detailUseCase.getCapybara()
    }
    
    func toggleFavorite() {
        if !capybara.isFavorite {
            detailUseCase.addToFavorite()
                .observe(on: MainScheduler.instance)
                .subscribe()
                .disposed(by: disposeBag)
        } else {
            detailUseCase.removeFromFavorite()
                .observe(on: MainScheduler.instance)
                .subscribe()
                .disposed(by: disposeBag)
        }
    }
    
}
