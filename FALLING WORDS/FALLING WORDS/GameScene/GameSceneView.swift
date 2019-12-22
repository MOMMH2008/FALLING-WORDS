//
//  GameSceneView.swift
//  FALLING WORDS
//
//  Created by Mohamed Helmy on 12/21/19.
//  Copyright © 2019 BABBEL. All rights reserved.
//

import Foundation

protocol GameSceneView: class {
    
    // get new question from Presenter with the 5 solution options
    func getQuestion(fiveOptions: WordsModel, answer: WordsModelElement?)
    
    // in case the Presenter faced any issue to get data
    func failedGetQuestion(error:String)
}
