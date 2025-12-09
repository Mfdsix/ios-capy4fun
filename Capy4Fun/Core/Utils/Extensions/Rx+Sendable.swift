//
//  Rx+Sendable.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import RxSwift

extension Observable: @unchecked @retroactive Sendable {}
