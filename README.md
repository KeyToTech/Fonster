# Fonster
Fonster is IOS framework for dynamically loading and registering fonts downloaded from URL written in Swift.

# Requirements
- iOS 9.0+
- Swift 4.0

# Usage
Loading the font from URL and setting it to the label.
```swift
 import Fonster

 Fonster(
            fontUrl: "https://site.com/some_font_file_to_load",
            fontFileName: "FileNameInLocalDir.ttf",
            fontFamily: "SomeFontFamilyToUse"
            ).register(completion: { registered in
                if registered {
                    print("Font family \(UIFont.familyNames)")
                    self.label.font = UIFont(name: "Font_family_to_use", size: 22.0)
                }
            }
        )
```

# Installation
## CocoaPods
CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

```
$ gem install cocoapods
```

To integrate Fonster into your Xcode project using CocoaPods, specify it in your Podfile:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Fonster', :git=>'https://github.com/KeyToTech/Fonster.git', :branch => 'master'
end
```

Then, run the following command:

```
$ pod install
```
