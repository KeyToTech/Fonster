//
//  Fonster.swift
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
import UIKit

/// Dynamically registering font being downloaded from URL
public class Fonster {
    
    private let fontUrl: String
    private let fontFileName: String
    private let fontExtension: String
    private let fontFamily: String
    
    /// Creates an instance with the specified `fontUrl` and local `fontFileName`.
    ///
    /// - parameter fontUrl:            Url of the font file to be downloaded.
    /// - parameter fontFileName:       The name of the file for storing locally.
    ///
    public init(fontUrl: String, fontFileName: String, fontFamily: String) {
        self.fontUrl = fontUrl
        self.fontFileName = fontFileName.fileName()
        self.fontExtension = fontFileName.fileExtension()
        self.fontFamily = fontFamily
    }
    
    /// Registering font being downloaded from URL.
    ///
    /// - parameter completion: Completion handler of registration. Result is dispatching on Main Queue
    ///
    public func register(completion: @escaping (_ registered: Bool) -> ()) {
       // if !isRegistered(family: self.fontFamily) {
        if !exists(file: self.fontFileName) {
            if let fontURL = URL(string: self.fontUrl) {
                let fileDestinationUrl = LocalDocuments(
                    fileName: fontFileName,
                    fileExtension: fontExtension
                    ).destination()
                NetworkFile().load(url: fontURL,
                                   to: fileDestinationUrl) {
                                    let fontRegisterResult = FontRegister(fontPath: fileDestinationUrl).register()
                                    print("Font registration result=\(fontRegisterResult)")
                                    DispatchQueue.main.async {
                                        completion(fontRegisterResult)
                                    }
                }
            }
        } else {
            completion(true)
        }
    }
    
    /// Check if font is registered alread
    ///
    /// - parameter family: Font family to check
    ///
    /// - returns:  true if font is registered, false otherwise.
    ///
    private func isRegistered(family: String) -> Bool {
        var registered = false
        if UIFont.familyNames.filter({ (familia) -> Bool in
            familia == family
        }).first != nil {
            registered = true
        }
        return registered
    }
    
    private func exists(file: String) -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(file) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                print("FILE AVAILABLE")
                return true
            } else {
                print("FILE NOT AVAILABLE")
                return false
            }
        } else {
            print("FILE PATH NOT AVAILABLE")
            return false
        }
    }
    
}
