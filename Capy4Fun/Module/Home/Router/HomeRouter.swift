//
//  HomeRouter.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import SwiftUI

class HomeRouter {

  func makeDetailView(for capybara: CapybaraModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(capybara: capybara)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }

}
