//
//  HomeRouter.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import SwiftUI
import Swinject

class HomeRouter {
    
    func makeDetailView(for capybara: CapybaraModel) -> some View {
        let presenter = Injection.shared.container.resolve(
            DetailPresenter.self,
            argument: capybara
        )!
        return DetailView(presenter: presenter)
    }
    
}
