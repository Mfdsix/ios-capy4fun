//
//  HomeRouter.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Core
import Home
import Detail
import SwiftUI
import Swinject

final class HomeRouter: HomeRouting {
    
    func makeDetailView(for capybara: CapybaraModel) -> AnyView {
        let presenter = Injection.shared.container.resolve(
            DetailPresenter.self,
            argument: capybara
        )!
        return AnyView(DetailView(presenter: presenter))
    }
    
}
