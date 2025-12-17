//
//  Main.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import SwiftUI
import Common

@main
struct Capy4FunApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        FontLoader.registerFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            
            EmptyView()
        }
    }
}
