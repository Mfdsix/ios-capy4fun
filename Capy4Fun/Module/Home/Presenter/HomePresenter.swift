//
//  HomePresenter.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import SwiftUI
import RxSwift
import Combine

class HomePresenter: ObservableObject {
    
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    private let disposeBag = DisposeBag()
    
    @Published var capybaras: [CapybaraModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getCapybaras() {
        capybaras = []
        loadingState = true
        errorMessage = ""
        
        homeUseCase.getCapybaras()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.capybaras = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.loadingState = false
            } onCompleted: {
                self.loadingState = false
            }
            .disposed(by: disposeBag)
    }
    
    func linkBuilder<Content: View>(
        for capybara: CapybaraModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: capybara)) { content() }
    }
    
}
