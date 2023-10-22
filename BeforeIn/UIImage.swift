//
//  UIImage.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/21/23.
//

import Foundation
import UIKit

extension UIImage {
    public func resized(to size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
