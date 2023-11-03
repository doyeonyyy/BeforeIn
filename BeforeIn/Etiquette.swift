//
//  Etiquette.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/16/23.
//

import Foundation
import UIKit

struct Etiquette {
    let category: String
    let place: String
    var content: [String: [EtiquetteContent]] //content = ["good","bad"]
    let backgroundImage: UIImage
    let mainImage: UIImage
    let description: String
    let imageLink: String
}

extension Etiquette: Equatable {
    static func == (lhs: Etiquette, rhs: Etiquette) -> Bool {
        return lhs.category == rhs.category && lhs.place == rhs.place
    }
    
    
}

var etiquetteList: [Etiquette] = []

struct EtiquetteContent {
    var mainContent: String
    let subContent: String
    var contentImage: UIImage?
    let contentImageLink: String
    
    init(mainContent: String, subContent: String, contentImage: UIImage?, contentImageLink: String) {
        self.mainContent = mainContent
        self.subContent = subContent
        self.contentImage = contentImage
        self.contentImageLink = contentImageLink
    }

}

struct savedEtiquette: Codable, Equatable {
    let category: String
    let place: String
    let imageLink: String
}

class EtiquetteManager {
    static let shared = EtiquetteManager()
    var savedData: [savedEtiquette] = []
    var recentlyEtiquetteList: [Etiquette] = []
    
    
    func fetchSavedData(_ selectEtiquette: Etiquette) {
        let category = selectEtiquette.category
        let place = selectEtiquette.place
        let imageLink = selectEtiquette.imageLink
        let targetEtiquette = savedEtiquette(category: category, place: place, imageLink: imageLink)
        if savedData.contains(targetEtiquette) {
            savedData.remove(at: savedData.firstIndex(of: targetEtiquette)!)
            savedData.insert(targetEtiquette, at: 0)
        }
        else {
            if savedData.count < 6 {
                savedData.insert(targetEtiquette, at: 0)
            }
            else {
                savedData.remove(at: savedData.endIndex - 1)
                savedData.insert(targetEtiquette, at: 0)
            }
        }
    }
    
    func saveEtiquetteList() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(savedData) {
            UserDefaults.standard.set(encodedData, forKey: "savedData")
        }
    }
    
    func loadEtiquetteList() {
        if let encodedData = UserDefaults.standard.data(forKey: "savedData") {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode([savedEtiquette].self, from: encodedData) {
                savedData = loadedData
            }
        }
        fetchrecentlyEtiquetteList()
    }
    
    func fetchrecentlyEtiquetteList() {
        recentlyEtiquetteList = []
        for savedDatum in savedData {
            for etiquette in etiquetteList {
                if savedDatum.place == etiquette.place {
                    recentlyEtiquetteList.append(etiquette)
                    continue
                }
            }
        }
    }
}
