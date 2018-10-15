//
//  FontRegister.swift
//  Fonster
//
//  (The MIT License)
//
//  Created by Bogdan Ustyak
//  Copyright © 2018 keytotech. All rights reserved.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit

/// Responsible for font registration
class FontRegister {
    
    private let fontPath: URL
    
    /// Creates an instance with the specified `fontPath`.
    ///
    /// - parameter fontPath:            File path of the font.
    ///
    init(fontPath: URL) {
        self.fontPath = fontPath
    }
    
    /// Registrating a font in CTFontManager.
    ///
    /// - returns: The status of registration.
    ///
    func register() -> Bool {
        guard let data = try? Data(contentsOf: fontPath),
            let provider = CGDataProvider(data: data as CFData),
            let font = CGFont(provider)
            else {
                print("Error loading font. Could not create CGFont from CGDataProvider")
                return false
        }
        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        if !success {
            print("Error loading font. Font is possibly already registered.")
        }
        return success
    }
}
