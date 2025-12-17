//
//  HomeRouting.swift
//  Core
//
//  Created by Mputh on 16/12/25.
//

import Core
import SwiftUI

public protocol HomeRouting {
    func makeDetailView(for capybara: CapybaraModel) -> AnyView
}
