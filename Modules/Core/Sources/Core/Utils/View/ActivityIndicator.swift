//
//  ActivityIndicator.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import SwiftUI

public struct ActivityIndicator: UIViewRepresentable {
    
    public init() {}
    
    public func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: .large)
        } else {
            indicator = UIActivityIndicatorView(style: .whiteLarge)
        }
        indicator.startAnimating()
        return indicator
    }
    
    public func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context: Context
    ) {
        uiView.startAnimating()
    }
    
}
