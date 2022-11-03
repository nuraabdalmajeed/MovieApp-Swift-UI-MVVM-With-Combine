//
//  ImageCacheKey.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import SwiftUI

struct ImageCacheKey:EnvironmentKey{
    static let defaultValue: ImageCache = TempImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get {
            self[ImageCacheKey.self]
        }
        set {
            self[ImageCacheKey.self] = newValue
        }
    }
}
