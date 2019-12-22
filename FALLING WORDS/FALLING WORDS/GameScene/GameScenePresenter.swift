//
//  GameScenePresenter.swift
//  FALLING WORDS
//
//  Created by Mohamed Helmy on 12/21/19.
//  Copyright © 2019 BABBEL. All rights reserved.
//

import Foundation

class GameScenePresenter {
    
    weak private var gameSceneView: GameSceneView?
    
    // services contain the data
    let services = Services()
    
    func attachView(view: GameSceneView){
        gameSceneView = view
    }
    
    // select any 5 random objects
    func getFiveWordsModelElemnets() {
        guard let wordsModel = services.getWordsModel() else {
            self.gameSceneView?.failedGetQuestion(error: "Empty List!")
            return
        }
        
        var fiveWordsModelElemnets = WordsModel()
        for _ in 1...5 {
            if let elemnet = wordsModel.randomElement() {
                fiveWordsModelElemnets.append(elemnet)
            } else {
                self.gameSceneView?.failedGetQuestion(error: "Empty List!")
                return
            }
        }
        self.gameSceneView?.getQuestion(fiveOptions: fiveWordsModelElemnets, answer: selectOneElementForQuestion(fiveWordsModelElemnets: fiveWordsModelElemnets))
    }
    
    // select one from the 5 random objects to be the question
    func selectOneElementForQuestion(fiveWordsModelElemnets: WordsModel) -> WordsModelElement? {
        if let elemnet = fiveWordsModelElemnets.randomElement() {
            return elemnet
        } else {
            return nil
        }
    }
    
}
