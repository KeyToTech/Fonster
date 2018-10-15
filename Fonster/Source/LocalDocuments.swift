//
//  LocalDocumentsDestination.swift
//  Fonster
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

/// Responsible fot generating URL of file in `Documents` directory
class LocalDocuments {
    
    private let fileName: String
    private let fileExtension: String
    
    /// Creates an instance with the specified `fileName` and `fileExtension`.
    ///
    /// - parameter fileName:            File name in the directory.
    /// - parameter fileExtension:       File extension in the directory
    ///
    init(fileName: String, fileExtension: String) {
        self.fileName = fileName
        self.fileExtension = fileExtension
    }
    
    /// Generate destination `URL` in `Documents` directory from `fileName` and `fileExtension`.
    ///
    /// - returns: URL of file in Documents directory.
    ///
    func destination() -> URL {
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
    }
}
