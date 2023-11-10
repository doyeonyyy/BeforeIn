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
    
    convenience init?(color: UIColor) {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        self.init(cgImage: image.cgImage!)
    }
}
