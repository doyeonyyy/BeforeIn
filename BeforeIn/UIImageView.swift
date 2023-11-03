//
//  UIImageView.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/11/03.
//

import UIKit

extension UIImageView {
    func setImageUrl(_ url: String) {
            let cacheKey = NSString(string: url) // 캐시에 사용될 Key 값
            if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) { // 해당 Key에 캐시이미지 저장되어 있으면 사용
                self.image = cachedImage
                print("캐싱된 이미지 사용")
                return
            }
            
            DispatchQueue.global(qos: .background).async {
                if let imageUrl = URL(string: url) {
                    URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
                        if let _ = err {
                            DispatchQueue.main.async {
                                self.image = UIImage()
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            if let data = data, let image = UIImage(data: data) {
                                ImageCacheManager.shared.setObject(image, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
                                self.image = image
                                print("이미지 파싱해서 사용")
                            }
                        }
                    }.resume()
                }
            }
        }
    
    
}

