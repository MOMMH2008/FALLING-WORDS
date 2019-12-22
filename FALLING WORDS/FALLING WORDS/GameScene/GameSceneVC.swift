//
//  GameSceneVC.swift
//  FALLING WORDS
//
//  Created by Mohamed Helmy on 12/21/19.
//  Copyright © 2019 BABBEL. All rights reserved.
//

import UIKit

class GameSceneVC: UIViewController {
    
    private let gameScenePresenter = GameScenePresenter()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var xPostionConstraint: NSLayoutConstraint!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var wrongButton: UIButton!
    @IBOutlet weak var correctButton: UIButton!
    
    // get the right option with 4 wrongs
    var fiveOptions = WordsModel()
    var answer: WordsModelElement?
    var currentScore = 0 {
        didSet {
            self.scoreLabel.text = "\(currentScore)"
        }
    }
    
    // we have 5 options
    var currentOption = 1
    
    var allowAnimation: Bool = true {
        didSet {
            if !allowAnimation {
                self.stopAnimation()
            }
        }
    }
    
    // show game over if the score becomes -5
    var isGameOver = false {
        didSet {
            if isGameOver {
                let alert = UIAlertController(title: "Game Over", message: "Your score is \(currentScore) try agin", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Play again", style: UIAlertAction.Style.default, handler: { action in
                    self.isGameOver = false
                    self.currentScore = 0
                    self.showCorrectAnswer()
                    self.gameScenePresenter.getFiveWordsModelElemnets()
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // connect with the Presenter in MVP
        gameScenePresenter.attachView(view: self)
        
        // ask Presenter to send a new question with 5 solutions
        gameScenePresenter.getFiveWordsModelElemnets()
    }
    
    func showeTheQuestion() {
        questionLabel.text = answer?.textEng
    }
    
    // we have 5 options (1 correct and 4 wrong)
    func showOptions() {
        
        // check if the score becomes -5 or less to show game over
        if currentScore <= -5 {
            allowAnimation = false
            isGameOver = true
            return
        }
        
        // check if the 5 options run out to get a new question
        if self.currentOption > fiveOptions.count {
            allowAnimation = false
            
            // ask Presenter to send a new question with 5 solutions
            gameScenePresenter.getFiveWordsModelElemnets()
            return
        }
        
        // set one of the options in the moving label
        answerLabel.text = fiveOptions[currentOption - 1].textSPA
        restAnswerLabelPostion()
        animateOptions()
    }
    
    // used to set option label at the top and set in a random position
    func restAnswerLabelPostion() {
        
        // don't exceed screen width
        var maxwidth = self.view.frame.width - (answerLabel.frame.width * 1.5)
        if maxwidth < 0 {
            maxwidth = 20
        }
        topConstraint.constant = 0
        xPostionConstraint.constant = CGFloat.random(in: 0 ..< maxwidth)
    }
    
    // used for animate the option label
    func animateOptions() {
        
        // remove any previous moving
        stopAnimation()
        
        // set the end of moving postion
        topConstraint.constant = borderView.frame.origin.y - borderView.frame.size.height - answerLabel.frame.size.height
        
        UIView.animate(withDuration: 3.0, animations: {
            self.view.layoutIfNeeded()
        }){ _ in
            if self.allowAnimation {
                // if it allowed continuing,then get the next option for the same question
                self.currentOption += 1
                self.showOptions()
            } else {
                // if it not allowed continuing,then get a new question
                self.stopAnimation()
                self.gameScenePresenter.getFiveWordsModelElemnets()
                return
            }
        }
    }
    
    // clear any current animation
    func stopAnimation() {
        self.view.layer.removeAllAnimations()
        self.view.layoutIfNeeded()
    }
    
    // when user think it's a correct answer
    @IBAction func correctButtonAction(_ sender: UIButton) {
        allowAnimation = false
        if (answer?.textSPA == answerLabel.text) {
            currentScore += 1
        } else {
            currentScore -= 1
        }
        showCorrectAnswer()
    }
    
    // when user think it's a wrong answer
    @IBAction func wrongButtonAction(_ sender: UIButton) {
        allowAnimation = false
        if (answer?.textSPA != answerLabel.text) {
            currentScore += 1
        } else {
            currentScore -= 1
        }
        showCorrectAnswer()
    }
    
    // show the correct solution
    func showCorrectAnswer() {
        resultLabel.text = (answer?.textEng ?? "") + " = " + (answer?.textSPA ?? "")
        self.answerLabel.isHidden = true
        self.wrongButton.isHidden = true
        self.correctButton.isHidden = true
    }
    
}

// Presenter Response
extension GameSceneVC: GameSceneView {
    // get new question from Presenter with the 5 solution options
    func getQuestion(fiveOptions: WordsModel, answer: WordsModelElement?) {
        self.fiveOptions = fiveOptions
        self.answer = answer
        showeTheQuestion()
        self.currentOption = 1
        allowAnimation = true
        answerLabel.isHidden = false
        wrongButton.isHidden = false
        correctButton.isHidden = false
        showOptions()
    }
    
    func failedGetQuestion(error: String) {
        // in case the Presenter faced any issue to get data
        let alert = UIAlertController(title: "Something went wrong!", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
