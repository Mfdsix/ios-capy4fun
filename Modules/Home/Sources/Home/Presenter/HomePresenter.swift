//
//  HomePresenter.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Core
import SwiftUI
import RxSwift
import Combine

public class HomePresenter: ObservableObject {
    
    private let homeRouter: HomeRouting
    private let homeUseCase: HomeUseCase
    private let disposeBag = DisposeBag()
    
    @Published var capybaras: [CapybaraModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    public init(
        homeUseCase: HomeUseCase,
        homeRouter: HomeRouting
    ) {
        self.homeUseCase = homeUseCase
        self.homeRouter = homeRouter
    }
    
    public func getCapybaras() {
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
            destination: homeRouter.makeDetailView(for: capybara)) { content() }
    }
    
}
