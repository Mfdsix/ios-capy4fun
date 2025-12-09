//
//  MainTabView.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var homePresenter: HomePresenter
    @ObservedObject var favoritePresenter: FavoritePresenter

    var body: some View {
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }
            .tabItem {
                Label("Feeds", systemImage: "newspaper.fill")
            }

            NavigationView {
                FavoriteView(presenter: favoritePresenter)
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }

             NavigationView { ProfileView() }
                 .tabItem { Label("Profile", systemImage: "person.fill") }
        }
    }
}
