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
    let content: [String: [EtiquetteContent]] //content = ["good","bad"]
    let backgroundImage: UIImage
    let mainImage: UIImage
    let description: String
}

var etiquetteList: [Etiquette] = []

struct EtiquetteContent {
    let mainContent: String
    let subContent: String
    let contentImage: UIImage
}
