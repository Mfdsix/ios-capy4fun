//
//  FavoriteView.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    ActivityIndicator()
                }
            } else {
                if presenter.capybaras.count == 0 {
                    Text("You have no Capybara. Let's Find One")
                        .foregroundColor(.blue)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 0) {
                            ForEach(self.presenter.capybaras, id: \.id) { capybara in
                                self.presenter.linkBuilder(for: capybara) {
                                    CapybaraFavRow(capybara: capybara)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .refreshable {
                        presenter.getCapybaras()
                    }
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
            self.presenter.getCapybaras()
        }
        .navigationBarTitle(
            Text("My Favs"),
            displayMode: .automatic
        )
    }
}
