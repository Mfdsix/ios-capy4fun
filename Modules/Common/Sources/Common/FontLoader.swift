//
//  FontLoader.swift
//  Common
//
//  Created by Mputh on 16/12/25.
//

import UIKit
import CoreText

public enum FontLoader {

    public static func registerFonts() {
        registerFont(named: "FredokaCondensed-SemiBold", extension: "ttf")
        registerFont(named: "Inter-Regular", extension: "ttf")
    }

    private static func registerFont(named name: String, extension ext: String) {
        guard
            let url = Bundle.module.url(forResource: name, withExtension: ext),
            let provider = CGDataProvider(url: url as CFURL),
            let font = CGFont(provider)
        else { return }

        CTFontManagerRegisterGraphicsFont(font, nil)
    }
}
