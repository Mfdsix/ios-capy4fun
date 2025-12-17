//
//  HomeView.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Core
import SwiftUI

public struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    public init(presenter: HomePresenter) {
        self.presenter = presenter
    }
    
    public var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    Core.ActivityIndicator()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(self.presenter.capybaras, id: \.id) { capybara in
                            self.presenter.linkBuilder(for: capybara) {
                                CapybaraRow(capybara: capybara)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .refreshable {
                    presenter.getCapybaras()
                }
            }
            
            if !presenter.errorMessage.isEmpty {
                LazyVStack {
                    HStack {
                        Text(presenter.errorMessage)
                            .foregroundColor(.red)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Button("Retry") {
                            presenter.getCapybaras()
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .transition(.opacity)
                .animation(.easeInOut, value: presenter.errorMessage)
            }
        }
        .onAppear {
            Task {
                self.presenter.getCapybaras()
            }
        }
    }
}
