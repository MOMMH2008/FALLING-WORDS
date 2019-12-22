//
//  Services.swift
//  FALLING WORDS
//
//  Created by Mohamed Helmy on 12/21/19.
//  Copyright © 2019 BABBEL. All rights reserved.
//

import Foundation

class Services {
    
    // get the codable object from data
    func getWordsModel() -> WordsModel? {
        guard let jsonData = convertJsonToData() else {
            return nil
        }
        
        do {
            let wordsModel = try JSONDecoder().decode(WordsModel.self, from: jsonData)
            return wordsModel
        } catch {
            return nil
        }
        
    }
    
    // convert the words json file to data
    func convertJsonToData() -> Data? {
           if let path = Bundle.main.path(forResource: "words", ofType: "json") {
               do {
                   let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                   return data
               } catch {
                   return nil
               }
           } else {
               return nil
           }
       }
}
