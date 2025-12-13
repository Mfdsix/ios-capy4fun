//
//  SceneDelegate.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import UIKit
import SwiftUI
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        let container = Injection.shared.container
        
        let homePresenter = container.resolve(HomePresenter.self)!
        let favoritePresenter = container.resolve(FavoritePresenter.self)!
        
        let mainTabView = MainTabView(
            homePresenter: homePresenter,
            favoritePresenter: favoritePresenter
        )
        
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: mainTabView)
        self.window = window
        window.makeKeyAndVisible()
    }
}
