//
//  DetailView.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import SwiftUI
import SDWebImageSwiftUI
import Core

public struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    @State private var isFavorite: Bool
    
    public init(presenter: DetailPresenter) {
        self.presenter = presenter
        _isFavorite = State(initialValue: presenter.capybara.isFavorite)
    }
    
    public var body: some View {
        ZStack {
            if presenter.loadingState {
                loadingIndicator
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        imageCategory
                        VStack(alignment: .leading, spacing: 20) {
                            headerContent
                            Divider()
                            detailContent
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle(Text(self.presenter.capybara.title))
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension DetailView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var imageCategory: some View {
        WebImage(url: URL(string: self.presenter.capybara.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(maxWidth: .infinity)
    }
    
    var headerContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(self.presenter.capybara.title)
                    .font(.custom("Fredoka-SemiBold", size: 28))
                    .bold()
                Spacer()
                
                Button {
                    withAnimation(.easeOut(duration: 0.2)) {
                        isFavorite.toggle()
                    }
                    
                    presenter.toggleFavorite()
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .font(.title2)
                        .scaleEffect(isFavorite ? 1.2 : 1.0)
                        .animation(.easeOut(duration: 0.2), value: isFavorite)
                }
            }
            
            Text(self.presenter.capybara.id)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    var detailContent: some View {
        VStack(alignment: .leading, spacing: 10) {
            headerTitle("Description")
                .padding(.bottom, 4)
            
            Text(self.presenter.capybara.description)
                .font(.custom("Inter-Regular", size: 14))
                .lineSpacing(4)
        }
    }
    
    func headerTitle(_ title: String) -> some View {
        Text(title)
            .font(.headline)
    }
}
