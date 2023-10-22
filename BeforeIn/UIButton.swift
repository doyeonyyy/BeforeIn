//
//  UIButton.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/22.
//

import UIKit

extension UIButton {
    
    func resizeImageButton(image: UIImage?, width: Int, height: Int, color: UIColor) -> UIImage? {
           guard let image = image else { return nil }
        
           let newSize = CGSize(width: width, height: height)
           let coloredImage = image.withTintColor(color)
        
           UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
           coloredImage.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        
           let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
        
           return resizedImage
       }
}
