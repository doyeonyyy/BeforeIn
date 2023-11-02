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
