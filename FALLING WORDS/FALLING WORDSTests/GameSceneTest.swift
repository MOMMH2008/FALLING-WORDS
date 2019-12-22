//
//  GameSceneTest.swift
//  FALLING WORDSTests
//
//  Created by Mohamed Helmy on 12/22/19.
//  Copyright © 2019 BABBEL. All rights reserved.
//

import XCTest
import Foundation
import FALLING_WORDS

class GameSceneTest: XCTestCase {
    
    
    override func setUp() {
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testGetDataFromJson() -> Data? {
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                XCTAssertTrue(true)
                return data
            } catch {
                XCTFail()
                return nil
                
            }
        } else {
            XCTFail()
            return nil
        }
    }
    
    func testgetWordsModel() -> WordsModel? {
        guard let jsonData = testGetDataFromJson() else {
             XCTFail()
            return nil
        }
        
        do {
            let wordsModel = try JSONDecoder().decode(WordsModel.self, from: jsonData)
            XCTAssertTrue(true)
            return wordsModel
        } catch {
            XCTFail()
            return nil
        }
    }
    
    func testgetFiveWordsModelElemnets() {
         var fiveWordsModelElemnets = WordsModel()
         for _ in 1...5 {
            if let elemnet = testgetWordsModel()?.randomElement() {
                 fiveWordsModelElemnets.append(elemnet)
             } else {
                 XCTFail()
                 return
             }
         }
        XCTAssertNotNil(fiveWordsModelElemnets)
        if fiveWordsModelElemnets.count == 5 {
            XCTAssertTrue(true)
        }
     }
    
}
