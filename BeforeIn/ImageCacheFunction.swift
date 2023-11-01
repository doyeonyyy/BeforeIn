//
//  CacheImageDown.swift
//  BeforeIn
//
//  Created by t2023-m079 on 11/1/23.
//

import Foundation
import FirebaseStorage
import UIKit

func loadImageFromCacheOrDownload(_ imageLink: String, completion: @escaping (UIImage?) -> Void) {
    if let cachedImage = loadCachedImage(imageLink) {
        completion(cachedImage)
    } else {
        downloadAndCacheImage(imageLink) { downloadedImage in
            completion(downloadedImage)
        }
    }
}

func downloadAndCacheImage(_ imageLink: String, completion: @escaping (UIImage?) -> Void) {
    let storage = Storage.storage()
    let storageRef = storage.reference()
    let imageReference = storage.reference(forURL: imageLink)
    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    let imageCacheDirectoryURL = documentsURL?.appendingPathComponent("ImageCache")
    
    if let filename = imageLink.components(separatedBy: "/").last, let fileURL = imageCacheDirectoryURL?.appendingPathComponent(filename) {
        imageReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("이미지 다운 실패: \(error)")
                completion(nil)
            } else if let data = data, let image = UIImage(data: data) {
                do {
                    try data.write(to: fileURL)
                    print("캐시에 이미지 저장완료")
                    completion(image)
                } catch {
                    print("Failed to save image to cache: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}

func loadCachedImage(_ imageLink: String) -> UIImage? {
    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    let imageCacheDirectoryURL = documentsURL?.appendingPathComponent("ImageCache")
    let filename = imageLink.components(separatedBy: "/").last
    
    if let filename = filename, let fileURL = imageCacheDirectoryURL?.appendingPathComponent(filename) {
        if fileManager.fileExists(atPath: fileURL.path), let imageData = try? Data(contentsOf: fileURL) {
            print("캐시에 있는 이미지 가져옴")
            return UIImage(data: imageData)
        }
    }
    
    return nil
}
