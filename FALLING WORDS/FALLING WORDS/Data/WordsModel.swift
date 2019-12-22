//
//  WordsModel.swift
//  FALLING WORDS
//
//  Created by Mohamed Helmy on 12/21/19.
//  Copyright © 2019 BABBEL. All rights reserved.
//

import Foundation

// MARK: - WordsModelElement
struct WordsModelElement: Codable {
    let textEng: String?
    let textSPA: String?

    enum CodingKeys: String, CodingKey {
        case textEng = "text_eng"
        case textSPA = "text_spa"
    }
}

typealias WordsModel = [WordsModelElement]
