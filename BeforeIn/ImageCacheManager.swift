//
//  ImageCacheManager.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/11/03.
//

import UIKit

class ImageCacheManager {
    
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
